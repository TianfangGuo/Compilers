declare i32 @strcmp(i8*, i8*)
declare i32 @printf(i8*, ...)
declare void @abort()
declare i8* @malloc(i32)
define i32 @Main_main() {

entry:
	%tmp.3 = icmp ne i32 3, 0
	br i1 %tmp.3, label %noDivByZeroError0, label %divByZeroError

noDivByZeroError0:
	%tmp.2 = sdiv i32 6, 3
	ret i32 %tmp.2

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

