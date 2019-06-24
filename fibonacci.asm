;Program to print fibonacci sequence upto “n” where n is read from user 
;
;Assemble using :: nasm -f elf32 fibonacci.asm
;Compile and run using :: gcc -m32 fibonacci.o && ./a.out
;
;
BITS 32

extern scanf
extern printf

section .data
	msg : db "Enter a number : ", 10, 0
	fib : db "Fibonacci numbers:", 10, 0
	fmt_p : db "%d", 10, 0
	fmt_s : db "%d", 0	

section .text
	global main

	main:

	push ebp 						;Prologue
	mov ebp, esp
	sub esp, 16 					;Buffer

	mov eax, 0						;Saving 0 and 1 to ebp-8 and ebp-12
	mov [ebp-8], eax
	mov eax, 1
	mov [ebp-12], eax

	push msg						;Print the message
	call printf
	add esp, 4

	lea eax, [ebp - 4] 				;Take number from the user
	push eax
	push fmt_s
	call scanf
	add esp, 8

	push fib 				 		;Print the second string
	call printf
	add esp,4

print: 								;Loop for printing ebp-8 which has the first argument
	mov eax, [ebp-8]
	push eax
	push fmt_p
	call printf
	add esp,8
	
	mov eax, [ebp-8] 				;Put arg1 in eax
	mov ebx, [ebp-12]				;Move second argument to ebp-8
	mov [ebp-8], ebx
	add eax, [ebp-12]				;Add eax and second argument and save it in ebp-12
	mov [ebp-12], eax
	mov eax, [ebp-8]				;Checks if the value is less than the user input
	cmp eax, [ebp-4]
	jle print 						;Loop if less or equal

	mov esp, ebp
	pop ebp
	ret
