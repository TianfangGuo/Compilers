declare i32 @strcmp(i8*, i8*)
declare i32 @printf(i8*, ...)
declare void @abort()
declare i8* @malloc(i32)
define i32 @Main_main() {

entry:
	%ifTemp.0 = alloca i32
	%tmp.2 = icmp eq i1 false, true
	br i1 %tmp.2, label %then.0, label %else.0

then.0:
	store i32 3, i32* %ifTemp.0
	br label %fi.0

else.0:
	store i32 5, i32* %ifTemp.0
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

