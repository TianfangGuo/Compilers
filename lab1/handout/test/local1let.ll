declare i32 @strcmp(i8*, i8*)
declare i32 @printf(i8*, ...)
declare void @abort()
declare i8* @malloc(i32)
define i32 @Main_main() {

entry:
	%n0 = alloca i32
	%m1 = alloca i32
	%tmp.3 = mul i32 3, 3
	%tmp.5 = add i32 %tmp.3, 1
	store i32 %tmp.5, i32* %n0
	%tmp.8 = load i32, i32* %n0
	%tmp.9 = load i32, i32* %n0
	%tmp.10 = mul i32 %tmp.8, %tmp.9
	%tmp.11 = load i32, i32* %n0
	%tmp.12 = add i32 %tmp.10, %tmp.11
	store i32 %tmp.12, i32* %m1
	%tmp.14 = load i32, i32* %m1
	%tmp.15 = load i32, i32* %n0
	%tmp.17 = icmp ne i32 %tmp.15, 0
	br i1 %tmp.17, label %noDivByZeroError2, label %divByZeroError

noDivByZeroError2:
	%tmp.16 = sdiv i32 %tmp.14, %tmp.15
	ret i32 %tmp.16

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

