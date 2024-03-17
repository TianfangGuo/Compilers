declare i32 @strcmp(i8*, i8*)
declare i32 @printf(i8*, ...)
declare void @abort()
declare i8* @malloc(i32)
define i32 @Main_main() {

entry:
	%ifTemp.0 = alloca i32
	%y0 = alloca i1
	%ifTemp.1 = alloca i32
	%tmp.2 = icmp eq i1 true, true
	br i1 %tmp.2, label %then.0, label %else.0

then.0:
	%tmp.5 = xor i1 false, true
	store i1 %tmp.5, i1* %y0
	%tmp.7 = load i1, i1* %y0
	%tmp.9 = icmp eq i1 %tmp.7, true
	br i1 %tmp.9, label %then.1, label %else.1

then.1:
	%tmp.13 = add i32 5, 9
	store i32 %tmp.13, i32* %ifTemp.1
	br label %fi.1

else.1:
	%tmp.17 = icmp ne i32 11, 0
	br i1 %tmp.17, label %noDivByZeroError1, label %divByZeroError

noDivByZeroError1:
	%tmp.16 = sdiv i32 99, 11
	store i32 %tmp.16, i32* %ifTemp.1
	br label %fi.1

fi.1:
	%tmp.10 = load i32, i32* %ifTemp.1
	store i32 %tmp.10, i32* %ifTemp.0
	br label %fi.0

else.0:
	store i32 50, i32* %ifTemp.0
	br label %fi.0

fi.0:
	%tmp.3 = load i32, i32* %ifTemp.0
	ret i32 %tmp.3

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

