declare i32 @strcmp(i8*, i8*)
declare i32 @printf(i8*, ...)
declare void @abort()
declare i8* @malloc(i32)
define i32 @Main_main() {

entry:
	%i0 = alloca i32
	%i1 = alloca i32
	store i32 10, i32* %i0
	store i32 10, i32* %i0
	store i32 10, i32* %i1
	%tmp.6 = load i32, i32* %i1
	%tmp.8 = sub i32 %tmp.6, 2
	store i32 %tmp.8, i32* %i1
	ret i32 %tmp.8

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

