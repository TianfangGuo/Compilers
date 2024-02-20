/*********************************************************************
 Intermediate code generator for COOL: SKELETON

 Read the comments carefully and add code to build an LLVM program
*********************************************************************/

#define EXTERN
#include "cgen.h"
#include <fstream>
#include <sstream>
#include <string>

extern int cgen_debug, curr_lineno;

/*********************************************************************
 For convenience, a large number of symbols are predefined here.
 These symbols include the primitive type and method names, as well
 as fixed names used by the runtime system. Feel free to add your
 own definitions as you see fit.
*********************************************************************/
EXTERN Symbol
    // required classes
    Object,
    IO, String, Int, Bool, Main,

    // class methods
    cool_abort, type_name, cool_copy, out_string, out_int, in_string, in_int,
    length, concat, substr,

    // class members
    val,

    // special symbols
    No_class,  // symbol that can't be the name of any user-defined class
    No_type,   // If e : No_type, then no code is generated for e.
    SELF_TYPE, // Special code is generated for new SELF_TYPE.
    self,      // self generates code differently than other references

    // extras
    arg, arg2, newobj, Mainmain, prim_string, prim_int, prim_bool;

// Initializing the predefined symbols.
static void initialize_constants(void) {
  Object = idtable.add_string("Object");
  IO = idtable.add_string("IO");
  String = idtable.add_string("String");
  Int = idtable.add_string("Int");
  Bool = idtable.add_string("Bool");
  Main = idtable.add_string("Main");

  cool_abort = idtable.add_string("abort");
  type_name = idtable.add_string("type_name");
  cool_copy = idtable.add_string("copy");
  out_string = idtable.add_string("out_string");
  out_int = idtable.add_string("out_int");
  in_string = idtable.add_string("in_string");
  in_int = idtable.add_string("in_int");
  length = idtable.add_string("length");
  concat = idtable.add_string("concat");
  substr = idtable.add_string("substr");

  val = idtable.add_string("val");

  No_class = idtable.add_string("_no_class");
  No_type = idtable.add_string("_no_type");
  SELF_TYPE = idtable.add_string("SELF_TYPE");
  self = idtable.add_string("self");

  arg = idtable.add_string("arg");
  arg2 = idtable.add_string("arg2");
  newobj = idtable.add_string("_newobj");
  Mainmain = idtable.add_string("main");
  prim_string = idtable.add_string("sbyte*");
  prim_int = idtable.add_string("int");
  prim_bool = idtable.add_string("bool");
}

/*********************************************************************

  CgenClassTable methods

*********************************************************************/

// CgenClassTable constructor orchestrates all code generation
CgenClassTable::CgenClassTable(Classes classes, std::ostream &s)
    : nds(0), current_tag(0) {
  if (cgen_debug)
    std::cerr << "Building CgenClassTable" << std::endl;
  ct_stream = &s;
  // Make sure we have a scope, both for classes and for constants
  enterscope();

  // Create an inheritance tree with one CgenNode per class.
  install_basic_classes();
  install_classes(classes);
  build_inheritance_tree();

  // First pass
  setup();

  // Second pass
  code_module();
  // Done with code generation: exit scopes
  exitscope();
}

// Creates AST nodes for the basic classes and installs them in the class list
void CgenClassTable::install_basic_classes() {
  // The tree package uses these globals to annotate the classes built below.
  curr_lineno = 0;
  Symbol filename = stringtable.add_string("<basic class>");

  //
  // A few special class names are installed in the lookup table but not
  // the class list. Thus, these classes exist, but are not part of the
  // inheritance hierarchy.

  // No_class serves as the parent of Object and the other special classes.
  Class_ noclasscls = class_(No_class, No_class, nil_Features(), filename);
  install_special_class(new CgenNode(noclasscls, CgenNode::Basic, this));
  delete noclasscls;

#ifdef LAB2
  // SELF_TYPE is the self class; it cannot be redefined or inherited.
  Class_ selftypecls = class_(SELF_TYPE, No_class, nil_Features(), filename);
  install_special_class(new CgenNode(selftypecls, CgenNode::Basic, this));
  delete selftypecls;
  //
  // Primitive types masquerading as classes. This is done so we can
  // get the necessary Symbols for the innards of String, Int, and Bool
  //
  Class_ primstringcls =
      class_(prim_string, No_class, nil_Features(), filename);
  install_special_class(new CgenNode(primstringcls, CgenNode::Basic, this));
  delete primstringcls;
#endif
  Class_ primintcls = class_(prim_int, No_class, nil_Features(), filename);
  install_special_class(new CgenNode(primintcls, CgenNode::Basic, this));
  delete primintcls;
  Class_ primboolcls = class_(prim_bool, No_class, nil_Features(), filename);
  install_special_class(new CgenNode(primboolcls, CgenNode::Basic, this));
  delete primboolcls;
  //
  // The Object class has no parent class. Its methods are
  //    cool_abort() : Object    aborts the program
  //    type_name() : Str        returns a string representation of class name
  //    copy() : SELF_TYPE       returns a copy of the object
  //
  // There is no need for method bodies in the basic classes---these
  // are already built in to the runtime system.
  //
  Class_ objcls = class_(
      Object, No_class,
      append_Features(
          append_Features(single_Features(method(cool_abort, nil_Formals(),
                                                 Object, no_expr())),
                          single_Features(method(type_name, nil_Formals(),
                                                 String, no_expr()))),
          single_Features(
              method(cool_copy, nil_Formals(), SELF_TYPE, no_expr()))),
      filename);
  install_class(new CgenNode(objcls, CgenNode::Basic, this));
  delete objcls;

  //
  // The Int class has no methods and only a single attribute, the
  // "val" for the integer.
  //
  Class_ intcls = class_(
      Int, Object, single_Features(attr(val, prim_int, no_expr())), filename);
  install_class(new CgenNode(intcls, CgenNode::Basic, this));
  delete intcls;

  //
  // Bool also has only the "val" slot.
  //
  Class_ boolcls = class_(
      Bool, Object, single_Features(attr(val, prim_bool, no_expr())), filename);
  install_class(new CgenNode(boolcls, CgenNode::Basic, this));
  delete boolcls;

#ifdef LAB2
  //
  // The class String has a number of slots and operations:
  //       val                                  the string itself
  //       length() : Int                       length of the string
  //       concat(arg: Str) : Str               string concatenation
  //       substr(arg: Int, arg2: Int): Str     substring
  //
  Class_ stringcls =
      class_(String, Object,
             append_Features(
                 append_Features(
                     append_Features(
                         single_Features(attr(val, prim_string, no_expr())),
                         single_Features(
                             method(length, nil_Formals(), Int, no_expr()))),
                     single_Features(method(concat,
                                            single_Formals(formal(arg, String)),
                                            String, no_expr()))),
                 single_Features(
                     method(substr,
                            append_Formals(single_Formals(formal(arg, Int)),
                                           single_Formals(formal(arg2, Int))),
                            String, no_expr()))),
             filename);
  install_class(new CgenNode(stringcls, CgenNode::Basic, this));
  delete stringcls;
#endif

#ifdef LAB2
  //
  // The IO class inherits from Object. Its methods are
  //        out_string(Str) : SELF_TYPE          writes a string to the output
  //        out_int(Int) : SELF_TYPE               "    an int    "  "     "
  //        in_string() : Str                    reads a string from the input
  //        in_int() : Int                         "   an int     "  "     "
  //
  Class_ iocls = class_(
      IO, Object,
      append_Features(
          append_Features(
              append_Features(
                  single_Features(method(out_string,
                                         single_Formals(formal(arg, String)),
                                         SELF_TYPE, no_expr())),
                  single_Features(method(out_int,
                                         single_Formals(formal(arg, Int)),
                                         SELF_TYPE, no_expr()))),
              single_Features(
                  method(in_string, nil_Formals(), String, no_expr()))),
          single_Features(method(in_int, nil_Formals(), Int, no_expr()))),
      filename);
  install_class(new CgenNode(iocls, CgenNode::Basic, this));
  delete iocls;
#endif
}

// install_classes enters a list of classes in the symbol table.
void CgenClassTable::install_classes(Classes cs) {
  for (auto cls : cs) {
    install_class(new CgenNode(cls, CgenNode::NotBasic, this));
  }
}

// Add this CgenNode to the class list and the lookup table
void CgenClassTable::install_class(CgenNode *nd) {
  Symbol name = nd->get_name();
  if (!this->find(name)) {
    // The class name is legal, so add it to the list of classes
    // and the symbol table.
    nds.push_back(nd);
    this->insert(name, nd);
  }
}

// Add this CgenNode to the special class list and the lookup table
void CgenClassTable::install_special_class(CgenNode *nd) {
  Symbol name = nd->get_name();
  if (!this->find(name)) {
    // The class name is legal, so add it to the list of special classes
    // and the symbol table.
    special_nds.push_back(nd);
    this->insert(name, nd);
  }
}

// CgenClassTable::build_inheritance_tree
void CgenClassTable::build_inheritance_tree() {
  for (auto node : nds)
    set_relations(node);
}

// CgenClassTable::set_relations
// Takes a CgenNode and locates its, and its parent's, inheritance nodes
// via the class table. Parent and child pointers are added as appropriate.
//
void CgenClassTable::set_relations(CgenNode *nd) {
  Symbol parent = nd->get_parent();
  auto parent_node = this->find(parent);
  if (!parent_node) {
    throw std::runtime_error("Class " + nd->get_name()->get_string() +
                             " inherits from an undefined class " +
                             parent->get_string());
  }
  nd->set_parent(parent_node);
}

// Sets up declarations for extra functions needed for code generation
// You should not need to modify this code for Lab1
void CgenClassTable::setup_external_functions() {
  ValuePrinter vp(*ct_stream);
  // setup function: external int strcmp(sbyte*, sbyte*)
  op_type i32_type(INT32), i8ptr_type(INT8_PTR), vararg_type(VAR_ARG);
  std::vector<op_type> strcmp_args;
  strcmp_args.push_back(i8ptr_type);
  strcmp_args.push_back(i8ptr_type);
  vp.declare(*ct_stream, i32_type, "strcmp", strcmp_args);

  // setup function: external int printf(sbyte*, ...)
  std::vector<op_type> printf_args;
  printf_args.push_back(i8ptr_type);
  printf_args.push_back(vararg_type);
  vp.declare(*ct_stream, i32_type, "printf", printf_args);

  // setup function: external void abort(void)
  op_type void_type(VOID);
  std::vector<op_type> abort_args;
  vp.declare(*ct_stream, void_type, "abort", abort_args);

  // setup function: external i8* malloc(i32)
  std::vector<op_type> malloc_args;
  malloc_args.push_back(i32_type);
  vp.declare(*ct_stream, i8ptr_type, "malloc", malloc_args);

#ifdef LAB2
  // TODO: add code here
#endif
}

void CgenClassTable::setup_classes(CgenNode *c, int depth) {
  c->setup(current_tag++, depth);
  for (auto child : c->get_children()) {
    setup_classes(child, depth + 1);
  }
  c->set_max_child(current_tag - 1);
}

// The code generation first pass. Define these two functions to traverse
// the tree and setup each CgenNode
void CgenClassTable::setup() {
  setup_external_functions();
  setup_classes(root(), 0);
}

// The code generation second pass. Add code here to traverse the tree and
// emit code for each CgenNode
void CgenClassTable::code_module() {
  code_constants();

#ifndef LAB2
  // This must be after code_constants() since that emits constants
  // needed by the code() method for expressions
  CgenNode *mainNode = getMainmain(root());
  mainNode->codeGenMainmain();
#endif
  code_main();

#ifdef LAB2
  code_classes(root());
#endif
}

#ifdef LAB2
void CgenClassTable::code_classes(CgenNode *c) {
  // TODO: add code here
}
#endif

// Create global definitions for constant Cool objects
void CgenClassTable::code_constants() {
#ifdef LAB2
  // TODO: add code here
#endif
}

// Create LLVM entry point. This function will initiate our Cool program
// by generating the code to execute (new Main).main()
//
void CgenClassTable::code_main(){
// TODO: add code here

    ValuePrinter main(*ct_stream);
    op_type int32(static_cast<op_type_id>(8));
    std::vector<operand> args;
    std::vector<op_type> arg_types;
    operand main_ret(int32, "main_ret");

    op_type int8_ptr(static_cast<op_type_id>(6));
    op_type int8(static_cast<op_type_id>(5));
    op_arr_type i8_x_25(INT8, 25);
    operand str_ret(int8_ptr, "str_ret");
    std::vector<op_type>printf_args({int8_ptr, op_type(VAR_ARG)});
    std::vector<operand>printf_ret({str_ret, main_ret});

    const_value main_return(i8_x_25, "Main.main() returned %d\n", true);

// str assignment "Main.main() returned %d\n"
    main.init_constant("str", main_return);

// Define a function main that has no parameters and returns an i32
    //std::ostream *stream;
    main.define(int32, "main",args);

// Define an entry basic block
    main.begin_block("entry");

// Call Main_main(). This returns int for phase 1, Object for phase 2
    main.call(*ct_stream, arg_types, "Main_main", true, args, main_ret);

#ifdef LAB2
// LAB2
#else
// Lab1
// Get the address of the string "Main_main() returned %d\n" using
// getelementptr
    main.getelementptr(*ct_stream, i8_x_25, global_value(i8_x_25.get_ptr_type(), "str"), int_value(0), int_value(0), str_ret);

// Call printf with the string address of "Main_main() returned %d\n"
    main.call(printf_args, int32, "printf", true, printf_ret);

// and the return value of Main_main() as its arguments

// Insert return 0
    main.ret(int_value(0));

#endif
    main.end_define();
}

// Get the root of the class tree.
CgenNode *CgenClassTable::root() {
  auto root = this->find(Object);
  if (!root) {
    throw std::runtime_error("Class Object is not defined.");
  }
  return root;
}

#ifndef LAB2
// Special-case functions used for the method Int Main::main() for
// Lab1 only.
CgenNode *CgenClassTable::getMainmain(CgenNode *c) {
  if (c && !c->basic())
    return c; // Found it!
  for (auto child : c->get_children()) {
    if (CgenNode *foundMain = this->getMainmain(child))
      return foundMain; // Propagate it up the recursive calls
  }
  return 0; // Make the recursion continue
}
#endif

/*********************************************************************

  StrTable / IntTable methods

 Coding string, int, and boolean constants

 Cool has three kinds of constants: strings, ints, and booleans.
 This section defines code generation for each type.

 All string constants are listed in the global "stringtable" and have
 type stringEntry. stringEntry methods are defined both for string
 constant definitions and references.

 All integer constants are listed in the global "inttable" and have
 type IntEntry. IntEntry methods are defined for Int constant references only.

 Since there are only two Bool values, there is no need for a table.
 The two booleans are represented by instances of the class BoolConst,
 which defines the definition and reference methods for Bools.

*********************************************************************/

// Create definitions for all String constants
void StrTable::code_string_table(std::ostream &s, CgenClassTable *ct) {
  for (auto &[_, entry] : this->_table) {
    entry.code_def(s, ct);
  }
}

// generate code to define a global string constant
void StringEntry::code_def(std::ostream &s, CgenClassTable *ct) {
#ifdef LAB2
  // TODO: add code here
#endif
}

/*********************************************************************

  CgenNode methods

*********************************************************************/

//
// Class setup. You may need to add parameters to this function so that
// the classtable can provide setup information (such as the class tag
// that should be used by this class).
//
// Things that setup should do:
//  - layout the features of the class
//  - create the types for the class and its vtable
//  - create global definitions used by the class such as the class vtable
//
void CgenNode::setup(int tag, int depth) {
  this->tag = tag;
#ifdef LAB2
  layout_features();

  // TODO: add code here

#endif
}

#ifdef LAB2
// Laying out the features involves creating a Function for each method
// and assigning each attribute a slot in the class structure.
void CgenNode::layout_features() {
  // TODO: add code here
}

// Class codegen. This should performed after every class has been setup.
// Generate code for each method of the class.
void CgenNode::code_class() {
  // No code generation for basic classes. The runtime will handle that.
  if (basic()) {
    return;
  }
  // TODO: add code here
}

void CgenNode::code_init_function(CgenEnvironment *env) {
  // TODO: add code here
}

#else

// code-gen function main() in class Main
void CgenNode::codeGenMainmain() {
  // In Phase 1, this can only be class Main. Get method_class for main().
  assert(std::string(this->name->get_string()) == std::string("Main"));
  method_class *mainMethod = (method_class *)features->nth(features->first());

  // TODO: add code here to generate the function `int Mainmain()`.
  ValuePrinter vp(*ct_stream);


  // Generally what you need to do are:
  // -- setup or create the environment, env, for translating this method
    CgenEnvironment env(*ct_stream, this);
  // -- invoke mainMethod->code(env) to translate the method
  //mainMethod->make_alloca(&env);
  mainMethod->code(&env);


}

#endif

/*********************************************************************

  CgenEnvironment functions

*********************************************************************/

// Look up a CgenNode given a symbol
CgenNode *CgenEnvironment::type_to_class(Symbol t) {
  return t == SELF_TYPE ? get_class()
                        : get_class()->get_classtable()->find_in_scopes(t);
}

/*********************************************************************

  APS class methods

    Fill in the following methods to produce code for the
    appropriate expression. You may add or remove parameters
    as you wish, but if you do, remember to change the parameters
    of the declarations in `cool-tree.handcode.h'.

*********************************************************************/

void program_class::cgen(const std::optional<std::string> &outfile) {
  initialize_constants();
  if (outfile) {
    std::ofstream s(*outfile);
    if (!s.good()) {
      std::cerr << "Cannot open output file " << *outfile << std::endl;
      exit(1);
    }
    class_table = new CgenClassTable(classes, s);
  } else {
    class_table = new CgenClassTable(classes, std::cout);
  }
}

// Create a method body
void method_class::code(CgenEnvironment *env) {
  if (cgen_debug) {
    std::cerr << "method" << std::endl;
  }

  ValuePrinter vp(*env->cur_stream);
  // TODO: add code here
    //std::vector<operand> args;
    op_type ret(return_type->get_string());
    std::vector<operand> args;
    //std::vector<operand> args;
    std::vector<op_type> arg_types;
    //vp.define(ret, name->get_string(), args);
    vp.define(INT32, "Main_main", args);

    //entry block
    vp.begin_block("entry");

    //recurse for alloca statements at the beginning
    std::cerr <<std::endl << "beginning alloca sweep" << std::endl;
    expr->make_alloca(env);
    env->reset_counters();

    //recurse through code
    std::cerr <<std::endl << "beginning recursive cgen" << std::endl;
    operand retreg = expr->code(env);

    vp.ret(retreg);

    //error handlers
    vp.begin_block("divByZeroError");
    vp.call( arg_types, VOID, "abort", true, args);
    vp.ret(int_value(0));

    vp.end_define();
}

// Codegen for expressions. Note that each expression has a value.

operand assign_class::code(CgenEnvironment *env) {
  if (cgen_debug)
    std::cerr << "assign" << std::endl;

  ValuePrinter vp(*env->cur_stream);
  // TODO: add code here and replace `return operand()`
  operand assignVal = expr->code(env);
  std::basic_string<char> retName = env->new_name();
//  operand ptr(assignVal.get_type().get_ptr_type(), ptrName);
//  operand retPtr(assignVal.get_type().get_ptr_type(), name->get_string());
  operand target(assignVal.get_type().get_ptr_type(), env->new_assign_label(name->get_string(), true));
  operand ret(assignVal.get_type(), retName);
//  std::basic_string<char> retName = env->new_name();
//  operand ptr(assignVal.get_type(), retName);
//  operand ret(assignVal.get_type(), retName);
//
//  //vp.getelementptr( assignVal.get_type(), assignVal, global_value(ptr), assignVal.get_type().get_ptr_type());
//  vp.load(*env->cur_stream, assignVal.get_type().get_ptr_type(), ptr, ret);
  operand *target1 = env->find_in_scopes(name);

  vp.store(*env->cur_stream, assignVal, *target1);
    //vp.getelementptr()



  return assignVal;
}

operand cond_class::code(CgenEnvironment *env) {
  if (cgen_debug)
    std::cerr << "cond" << std::endl;

  // TODO: add code here and replace `return operand()`
  ValuePrinter vp(*env->cur_stream);

  operand predVal = pred->code(env);
  operand compTrue = bool_const(true)->code(env);
  operand compResult(INT1, env->new_name());
  std::string thenLabel = env->new_then_label();
  std::string elseLabel = env->new_else_label();
  std::string fiLabel = env->new_fi_label();

  //setting up the return operand
    op_type ret_type(VOID);
    std::string retPtrName = env->new_if_temp_var();
    std::string retName = env->new_name();
    if(type == Int){
        ret_type.set_type(INT32);
    }
    else if(type == Bool){
        ret_type.set_type(INT1);
    }
    operand retPtr(ret_type.get_ptr_type(), retPtrName);
    operand ret(ret_type, retName);

  //evaluate predicate
  vp.icmp(*env->cur_stream, EQ, predVal, compTrue, compResult);
  vp.branch_cond(compResult, thenLabel, elseLabel);

  //then block
  vp.begin_block(thenLabel);
  operand thenVal = then_exp->code(env);
  vp.store(thenVal, retPtr);
  vp.branch_uncond(fiLabel);

  //else block
  vp.begin_block(elseLabel);
  operand elseVal = else_exp->code(env);
  vp.store(elseVal, retPtr);
  vp.branch_uncond(fiLabel);

  //fi block
  vp.begin_block(fiLabel);
  vp.load(*env->cur_stream, ret_type, retPtr, ret);

  return ret;
}

operand loop_class::code(CgenEnvironment *env) {
  if (cgen_debug)
    std::cerr << "loop" << std::endl;

  // TODO: add code here and replace `return operand()`
  ValuePrinter vp(*env->cur_stream);
  std::string condLabel = env->new_loop_condition_label();
  std::string bodyLabel = env->new_loop_body_label();
  std::string poolLabel = env->new_pool_label();
//  operand predVal = pred->code(env);
//  operand compTrue = bool_const(true)->code(env);
//  operand compResult(INT1, env->new_name());


  vp.branch_uncond(condLabel);
  //loop condition check, jump to body or pool
  vp.begin_block(condLabel);
  operand predVal = pred->code(env);
  operand compTrue = bool_const(true)->code(env);
  operand compResult(INT1, env->new_name());
  //vp.icmp(*env->cur_stream, EQ, predVal, compTrue, compResult);
//  vp.branch_cond(compResult, bodyLabel, poolLabel);
    vp.branch_cond(predVal, bodyLabel, poolLabel);

  //loop body, jump to condition check
  vp.begin_block(bodyLabel);
  operand bodyVal = body->code(env);
  vp.branch_uncond(condLabel);

  //pool
  vp.begin_block(poolLabel);
  //vp.ret(bodyVal);

  return bodyVal;
}

operand block_class::code(CgenEnvironment *env) {
  if (cgen_debug)
    std::cerr << "block" << std::endl;

  // TODO: add code here and replace `return operand()`
    //body->code(env);
    //this->dump(*env->cur_stream, 3);
    //operand op = body->nth(body->len()-1)->code(env);
    //body->next()
    operand op;
    for(int i = 0; i < body->len(); i++){
        op = body->nth(i)->code(env);
    }

  return op;
}

operand let_class::code(CgenEnvironment *env) {
  if (cgen_debug)
    std::cerr << "let" << std::endl;

  // TODO: add code here and replace `return operand()`
  ValuePrinter vp(*env->cur_stream);
  operand initVal = init->code(env);
  //TODO: two bugs to fix: naming and non-assignment lets
  operand target(VOID, env->new_label(identifier->get_string(), true));
  //operand target(VOID, "i0");
  if(type_decl == Int){
      //operand target(INT32_PTR, identifier->get_string());
      target.set_type(INT32_PTR);
  }
  else if(type_decl == Bool){
      //operand target(INT1_PTR, identifier->get_string());
      target.set_type(INT1_PTR);
  }

  //store the constant into a reg
  //vp.init_constant(env->new_name(), initVal);
  //store that reg to
  //op_type voidType((op_type_id)VOID);
  operand isVoid(EMPTY, env->new_name());
  if(initVal.get_type().get_id() == isVoid.get_type().get_id()) {

  }
  else{
      vp.store(*env->cur_stream, initVal, target);
  }

  env->open_scope();
  env->add_binding(identifier, &target);

  operand letBody = body->code(env);

  env->close_scope();

  return letBody;
}

operand plus_class::code(CgenEnvironment *env) {
  if (cgen_debug)
    std::cerr << "plus" << std::endl;

  // TODO: add code here and replace `return operand()`
  ValuePrinter vp(*env->cur_stream);
  operand LHS = e1->code(env);
  operand RHS = e2->code(env);
  operand ret(INT32, env->new_name());

  vp.add(*env->cur_stream, LHS, RHS, ret);

  return ret;
}

operand sub_class::code(CgenEnvironment *env) {
  if (cgen_debug)
    std::cerr << "sub" << std::endl;

  // TODO: add code here and replace `return operand()`
  ValuePrinter vp(*env->cur_stream);
  operand LHS = e1->code(env);
  operand RHS = e2->code(env);
  operand ret(INT32, env->new_name());

  vp.sub(*env->cur_stream, LHS, RHS, ret);

  return ret;
}

operand mul_class::code(CgenEnvironment *env) {
  if (cgen_debug)
    std::cerr << "mul" << std::endl;

  // TODO: add code here and replace `return operand()`
  ValuePrinter vp(*env->cur_stream);
  operand LHS = e1->code(env);
  operand RHS = e2->code(env);
  operand ret(INT32, env->new_name());

  vp.mul(*env->cur_stream, LHS, RHS, ret);

  return ret;
}

operand divide_class::code(CgenEnvironment *env) {
  if (cgen_debug)
    std::cerr << "div" << std::endl;

  // TODO: add code here and replace `return operand()`
  ValuePrinter vp(*env->cur_stream);
  operand LHS = e1->code(env);
  operand RHS = e2->code(env);
  operand ret(INT32, env->new_name());

  //should check for divide by zero error
  operand errorCheck(INT1, env->new_name());
    int_value zero = 0;
  std::string passLabel = env->new_label("noDivByZeroError", false);
  std::string errorLabel = env->new_label("divByZeroError", false);

  vp.icmp(*env->cur_stream, NE, RHS, zero, errorCheck);
  vp.branch_cond(errorCheck, passLabel, "divByZeroError");

  vp.begin_block(passLabel);
  vp.div(*env->cur_stream, LHS, RHS, ret);

  return ret;
}

operand neg_class::code(CgenEnvironment *env) {
  if (cgen_debug)
    std::cerr << "neg" << std::endl;

  // TODO: add code here and replace `return operand()`
    ValuePrinter vp(*env->cur_stream);
    operand target = e1->code(env);
    operand ret(INT32, env->new_name());
    int_value zero = 0;

    vp.sub(*env->cur_stream, zero, target, ret);

  return ret;
}

operand lt_class::code(CgenEnvironment *env) {
  if (cgen_debug)
    std::cerr << "lt" << std::endl;

  // TODO: add code here and replace `return operand()`
    ValuePrinter vp(*env->cur_stream);
    operand LHS = e1->code(env);
    operand RHS = e2->code(env);
    operand ret(INT1, env->new_name());

    vp.icmp(*env->cur_stream, LT, LHS, RHS, ret);

    return ret;

  return operand();
}

operand eq_class::code(CgenEnvironment *env) {
  if (cgen_debug)
    std::cerr << "eq" << std::endl;

  // TODO: add code here and replace `return operand()`
    ValuePrinter vp(*env->cur_stream);
    operand LHS = e1->code(env);
    operand RHS = e2->code(env);
    operand ret(INT1, env->new_name());

    vp.icmp(*env->cur_stream, EQ, LHS, RHS, ret);

    return ret;
  return operand();
}

operand leq_class::code(CgenEnvironment *env) {
  if (cgen_debug)
    std::cerr << "leq" << std::endl;

  // TODO: add code here and replace `return operand()`
    ValuePrinter vp(*env->cur_stream);
    operand LHS = e1->code(env);
    operand RHS = e2->code(env);
    operand ret(INT1, env->new_name());

    vp.icmp(*env->cur_stream, LE, LHS, RHS, ret);

    return ret;
  return operand();
}

operand comp_class::code(CgenEnvironment *env) {
  if (cgen_debug)
    std::cerr << "complement" << std::endl;

  // TODO: add code here and replace `return operand()`
    ValuePrinter vp(*env->cur_stream);
    operand target = e1->code(env);
    operand ret(INT1, env->new_name());

    vp.xor_in(*env->cur_stream, target, target, ret);

  return ret;
}

operand int_const_class::code(CgenEnvironment *env) {
  if (cgen_debug)
    std::cerr << "Integer Constant" << std::endl;

  // TODO: add code here and replace `return operand()`

    ValuePrinter vp(*env->cur_stream);

    std::basic_string<char>retreg = env->new_name();
    operand ret(op_type(INT32), retreg);
    const_value num(op_type(INT32), this->token->get_string(), false);

    //vp.init_constant(*env->cur_stream, retreg, num);

  return num;
}

operand bool_const_class::code(CgenEnvironment *env) {
  if (cgen_debug)
    std::cerr << "Boolean Constant" << std::endl;

  // TODO: add code here and replace `return operand()`

    ValuePrinter vp(*env->cur_stream);

    std::basic_string<char>retreg = env->new_name();
    operand ret(op_type(INT32), retreg);
    bool_value boolnum(this->val, false);
    //vp.init_constant(retreg, boolnum);

  return boolnum;
}

operand object_class::code(CgenEnvironment *env) {
  if (cgen_debug)
    std::cerr << "Object" << std::endl;


  // TODO: add code here and replace `return operand()`
  ValuePrinter vp(*env->cur_stream);
  op_type p = VOID;
  op_type t = VOID;
  if(this->get_type() == Int){
      t = INT32;
      p = INT32_PTR;
  }
  else if(this->get_type() == Bool){
      t = INT1;
      p = INT1_PTR;
  }

  operand ret(t, env->new_name());
  operand value(p, env->new_obj_label(name->get_string(), true));
  operand *value1 = env->find_in_scopes(name);

  vp.load(*env->cur_stream, t, *value1,ret);

  return ret;
}

operand no_expr_class::code(CgenEnvironment *env) {
  if (cgen_debug)
    std::cerr << "No_expr" << std::endl;

  // TODO: add code here and replace `return operand()`
  operand ret(EMPTY, "noExpr");

  return ret;
}

//*****************************************************************
// The next few functions are for node types not supported in Phase 1
// but these functions must be defined because they are declared as
// methods via the Expression_SHARED_EXTRAS hack.
//*****************************************************************

operand static_dispatch_class::code(CgenEnvironment *env) {
  if (cgen_debug)
    std::cerr << "static dispatch" << std::endl;
#ifndef LAB2
  assert(0 && "Unsupported case for phase 1");
#else
  // TODO: add code here and replace `return operand()`
  return operand();
#endif
}

operand string_const_class::code(CgenEnvironment *env) {
  if (cgen_debug)
    std::cerr << "string_const" << std::endl;
#ifndef LAB2
  assert(0 && "Unsupported case for phase 1");
#else
  // TODO: add code here and replace `return operand()`
  return operand();
#endif
}

operand dispatch_class::code(CgenEnvironment *env) {
  if (cgen_debug)
    std::cerr << "dispatch" << std::endl;
#ifndef LAB2
  assert(0 && "Unsupported case for phase 1");
#else
  // TODO: add code here and replace `return operand()`
  return operand();
#endif
}

// Handle a Cool case expression (selecting based on the type of an object)
operand typcase_class::code(CgenEnvironment *env) {
  if (cgen_debug)
    std::cerr << "typecase::code()" << std::endl;
#ifndef LAB2
  assert(0 && "Unsupported case for phase 1");
#else
  // TODO: add code here and replace `return operand()`
  return operand();
#endif
}

operand new__class::code(CgenEnvironment *env) {
  if (cgen_debug)
    std::cerr << "newClass" << std::endl;
#ifndef LAB2
  assert(0 && "Unsupported case for phase 1");
#else
  // TODO: add code here and replace `return operand()`
  return operand();
#endif
}

operand isvoid_class::code(CgenEnvironment *env) {
  if (cgen_debug)
    std::cerr << "isvoid" << std::endl;
#ifndef LAB2
  assert(0 && "Unsupported case for phase 1");
#else
  // TODO: add code here and replace `return operand()`
  return operand();
#endif
}

// Create the LLVM Function corresponding to this method.
void method_class::layout_feature(CgenNode *cls) {
#ifndef LAB2
  assert(0 && "Unsupported case for phase 1");
#else
  // TODO: add code here
#endif
}

// Handle one branch of a Cool case expression.
// If the source tag is >= the branch tag
// and <= (max child of the branch class) tag,
// then the branch is a superclass of the source.
// See the LAB2 handout for more information about our use of class tags.
operand branch_class::code(operand expr_val, operand tag, op_type join_type,
                           CgenEnvironment *env) {
#ifndef LAB2
  assert(0 && "Unsupported case for phase 1");
#else
  // TODO: add code here and replace `return operand()`
  return operand();
#endif
}

// Assign this attribute a slot in the class structure
void attr_class::layout_feature(CgenNode *cls) {
#ifndef LAB2
  assert(0 && "Unsupported case for phase 1");
#else
  // TODO: add code here
#endif
}

void attr_class::code(CgenEnvironment *env) {
#ifndef LAB2
  assert(0 && "Unsupported case for phase 1");
#else
  // TODO: add code here
#endif
}

/*
 * Definitions of make_alloca
 */
void assign_class::make_alloca(CgenEnvironment *env) {
  if (cgen_debug)
    std::cerr << "assign" << std::endl;

  // TODO: add code here

  expr->make_alloca(env);
}

void cond_class::make_alloca(CgenEnvironment *env) {
  if (cgen_debug)
    std::cerr << "cond" << std::endl;

  // TODO: add code here
  ValuePrinter vp(*env->cur_stream);
  op_type ret_type(VOID);
  if(type == Int){
      ret_type.set_type(INT32);
  }
  else if(type == Bool){
      ret_type.set_type(INT1);
  }
  operand retPtr(ret_type.get_ptr_type(), env->new_if_temp_var());

  vp.alloca_mem(*env->cur_stream, ret_type, retPtr);

  pred->make_alloca(env);
  then_exp->make_alloca(env);
  else_exp->make_alloca(env);
}

void loop_class::make_alloca(CgenEnvironment *env) {
  if (cgen_debug)
    std::cerr << "loop" << std::endl;

  // TODO: add code here

  pred->make_alloca(env);
  body->make_alloca(env);
}

void block_class::make_alloca(CgenEnvironment *env) {
  if (cgen_debug)
    std::cerr << "block" << std::endl;

  // TODO: add code here
  for(int i = 0; i < body->len(); i++){
      body->nth(i)->make_alloca(env);
  }
}

void let_class::make_alloca(CgenEnvironment *env) {
  if (cgen_debug)
    std::cerr << "let" << std::endl;

  // TODO: add code here
  ValuePrinter vp(*env->cur_stream);
  op_type type(type_decl->get_string());
  operand op2(type, env->new_label(identifier->get_string(), true));
  if(type_decl == Int){
      vp.alloca_mem(*env->cur_stream, INT32, op2);
  }
  else if(type_decl == Bool){
      vp.alloca_mem(*env->cur_stream, INT1, op2);
  }

  //vp.alloca_mem(*env->cur_stream, type, op2);

  init->make_alloca(env);
  body->make_alloca(env);
}

void plus_class::make_alloca(CgenEnvironment *env) {
  if (cgen_debug)
    std::cerr << "plus" << std::endl;

  // TODO: add code here
  e1->make_alloca(env);
  e2->make_alloca(env);
}

void sub_class::make_alloca(CgenEnvironment *env) {
  if (cgen_debug)
    std::cerr << "sub" << std::endl;

  // TODO: add code here
    e1->make_alloca(env);
    e2->make_alloca(env);
}

void mul_class::make_alloca(CgenEnvironment *env) {
  if (cgen_debug)
    std::cerr << "mul" << std::endl;

  // TODO: add code here
    e1->make_alloca(env);
    e2->make_alloca(env);
}

void divide_class::make_alloca(CgenEnvironment *env) {
  if (cgen_debug)
    std::cerr << "div" << std::endl;

  // TODO: add code here
    e1->make_alloca(env);
    e2->make_alloca(env);
}

void neg_class::make_alloca(CgenEnvironment *env) {
  if (cgen_debug)
    std::cerr << "neg" << std::endl;

  // TODO: add code here
    e1->make_alloca(env);
}

void lt_class::make_alloca(CgenEnvironment *env) {
  if (cgen_debug)
    std::cerr << "lt" << std::endl;

  // TODO: add code here
  ValuePrinter vp(*env->cur_stream);
  //op_type boolType = op_type_id (INT1);
    //operand retPtr(boolType.get_ptr_type(), env->new_if_temp_var());

    //vp.alloca_mem(*env->cur_stream, boolType, retPtr);

    e1->make_alloca(env);
    e2->make_alloca(env);
}

void eq_class::make_alloca(CgenEnvironment *env) {
  if (cgen_debug)
    std::cerr << "eq" << std::endl;

  // TODO: add code here
    e1->make_alloca(env);
    e2->make_alloca(env);
}

void leq_class::make_alloca(CgenEnvironment *env) {
  if (cgen_debug)
    std::cerr << "leq" << std::endl;

  // TODO: add code here
    e1->make_alloca(env);
    e2->make_alloca(env);
}

void comp_class::make_alloca(CgenEnvironment *env) {
  if (cgen_debug)
    std::cerr << "complement" << std::endl;

  // TODO: add code here
    e1->make_alloca(env);
    //e2->make_alloca(env);
}

void int_const_class::make_alloca(CgenEnvironment *env) {
  if (cgen_debug)
    std::cerr << "Integer Constant" << std::endl;

  // TODO: add code here
}

void bool_const_class::make_alloca(CgenEnvironment *env) {
  if (cgen_debug)
    std::cerr << "Boolean Constant" << std::endl;

  // TODO: add code here
}

void object_class::make_alloca(CgenEnvironment *env) {
  if (cgen_debug)
    std::cerr << "Object" << std::endl;

  // TODO: add code here
}

void no_expr_class::make_alloca(CgenEnvironment *env) {
  if (cgen_debug)
    std::cerr << "No_expr" << std::endl;

  // TODO: add code here
}

void static_dispatch_class::make_alloca(CgenEnvironment *env) {
  if (cgen_debug)
    std::cerr << "static dispatch" << std::endl;
#ifndef LAB2
  assert(0 && "Unsupported case for phase 1");
#else
    // TODO: add code here
#endif
}

void string_const_class::make_alloca(CgenEnvironment *env) {
  if (cgen_debug)
    std::cerr << "string_const" << std::endl;
#ifndef LAB2
  assert(0 && "Unsupported case for phase 1");
#else
    // TODO: add code here
#endif
}

void dispatch_class::make_alloca(CgenEnvironment *env) {
  if (cgen_debug)
    std::cerr << "dispatch" << std::endl;
#ifndef LAB2
  assert(0 && "Unsupported case for phase 1");
#else
    // TODO: add code here
#endif
}

void typcase_class::make_alloca(CgenEnvironment *env) {
  if (cgen_debug)
    std::cerr << "typecase::make_alloca()" << std::endl;
#ifndef LAB2
  assert(0 && "Unsupported case for phase 1");
#else
    // TODO: add code here
#endif
}

void new__class::make_alloca(CgenEnvironment *env) {
  if (cgen_debug)
    std::cerr << "newClass" << std::endl;
#ifndef LAB2
  assert(0 && "Unsupported case for phase 1");
#else
    // TODO: add code here
#endif
}

void isvoid_class::make_alloca(CgenEnvironment *env) {
  if (cgen_debug)
    std::cerr << "isvoid" << std::endl;
#ifndef LAB2
  assert(0 && "Unsupported case for phase 1");
#else
    // TODO: add code here
#endif
}

void branch_class::make_alloca(CgenEnvironment *env) {
#ifndef LAB2
  assert(0 && "Unsupported case for phase 1");
#else
  // TODO: add code here
#endif
}

void method_class::make_alloca(CgenEnvironment *env) { return; }

void attr_class::make_alloca(CgenEnvironment *env) {
#ifndef LAB2
  assert(0 && "Unsupported case for phase 1");
#else
  // TODO: add code here
#endif
}

#ifdef LAB2
// conform - If necessary, emit a bitcast or boxing/unboxing operations
// to convert an object to a new type. This can assume the object
// is known to be (dynamically) compatible with the target type.
// It should only be called when this condition holds.
// (It's needed by the supplied code for typecase)
operand conform(operand src, op_type type, CgenEnvironment *env) {
  // TODO: add code here
  return operand();
}
#endif
