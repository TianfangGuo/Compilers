declare i32 @strcmp(i8*, i8*)
declare i32 @printf(i8*, ...)
declare void @abort()
declare i8* @malloc(i32)
define i32 @Main_main() {

entry:
	%x0 = alloca i1
	%ifTemp.0 = alloca i32
	store i1 true, i1* %x0
	%tmp.2 = load i1, i1* %x0
	%tmp.4 = icmp eq i1 %tmp.2, true
	br i1 %tmp.4, label %then.0, label %else.0

then.0:
	store i32 1, i32* %ifTemp.0
	br label %fi.0

else.0:
	store i32 0, i32* %ifTemp.0
	br label %fi.0

fi.0:
	%tmp.5 = load i32, i32* %ifTemp.0
	ret i32 %tmp.5

divByZeroError:
	call void @abort(  )
	ret i32 0
}

@str = internal constant [25 x i8] c"Main.main() returned %d\0A\00"
define i32 @main() {

entry:
	%main_ret = call i32 @Main_main(  )
	%str_ret = getelementptr [25 x i8], [25 x i8]* @str, i32 0, i32 0
	%vtpm.1 = call i32(i8*, ... ) @printf( i8* %str_ret, i32 %main_ret )
	ret i32 0
}

