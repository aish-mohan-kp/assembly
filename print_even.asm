;Assembly program to print even numbers from 1 to 100.
;
;
;Assemble using :: nasm -f elf32 print_even.asm
;Compile and run using :: gcc -m32 print_even.o && ./a.out
;
;
BITS 32

extern printf

section .data
	even : db "Even numbers between 1 and 100 are:", 10, 0
	fmt: db "%d", 10, 0							; Format specifier for printf

section .text
	global main
	main:
	push ebp									; Prologue
	mov ebp, esp

	push even 									; Print the string 
	call printf
	add esp, 4

	mov ebx, 2									; Initialize ebx register to 2

print_even:
	push ebx									;Push parameters for printf into the stack in reverse order
	push fmt									;First the number is pushed and then the format specifier
	call printf									
	add esp, 4									
	add ebx, 2									; Adds 2 to obtain next number
	cmp ebx, 100								; Comparison to loop till 100
	jle print_even

	mov esp, ebp								; Epilogue
	pop ebp
	ret
