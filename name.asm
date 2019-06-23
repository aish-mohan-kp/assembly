;Greeting program.
;Program asks your name and outputs “Good Morning %name%”


; Assemble using :: nasm -f elf32 name.asm ( In 64 bit machines)
; Compile and run using :: gcc -m32 name.o && ./a.out ( In 64 bit machines)
;
;
BITS 32							; To tell assembler that its 32 bit 
extern printf
extern gets

section .data
	name: db  " What's your name?", 10, 0	; Declare strings that you need 
	mng : db  "Good Morning ", 0			; 10 is for newline 
section .text
	global main

	main:
		push ebp 							; Prologue
		mov ebp, esp						; Saving previous ebp and making a new frame

		sub esp, 40							; Declaration of a buffer to read the input into

		push name							; Pushing parameter needed for the printf into stack
		call printf
		add esp, 4							; Poping the previous string stored for the printf

		lea eax, [ebp-40]					; Loading the address of buffer into the register eax 
		push eax							; Pushing eax into stack as parameter for gets
		call gets				

		push mng 							; Push the string Good Morning to stack 
		call printf							; Calls printf and pops the string out of the stack
		add esp, 4

		call printf							; There is no need of pushing parameter for printf into the stack as the address of buffer is already in the stack for the previous gets
		add esp, 4							

		mov esp,ebp 						;epilogue
		pop ebp
		ret