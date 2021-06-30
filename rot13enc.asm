; Author: Wil Keller
; File: rot13enc.asm
; Description: An x86-64 ASM program to encode/decode input to ROT13 format. First ASM
; program using what I've read from Duntemann's "Assembly Language Step-by-step" and
; looking up x84 syscalls & etc. Mostly just practice coding to cement the fundamentals 
; in my mind. 
; Date: 30 Jun 21
;

; Build using these commands: 
; nasm -f elf64 -g -F dwarf rot13enc.asm
; ld -o rot13enc rot13enc.o
;

section .data ; Section containing initialized data (i.e. variables)
section .bss ; Section containing UNinitialized data
    buff resb 1     ; reserve 1 byte (for 1 ASCII char) in buffer 'buff'
    
section .text ; Section containing code 

    global _start
    
_start:
    nop
; insert code between nops

; Read one byte at a time; yes, I know it's slow, but it's my first attempt at an implementation.
    Read:   mov rax,0       ; specify x64 sys_read call
            mov rdi,0       ; specify file descriptor stdin
            mov rsi,buff    ; pass address of buffer to read to
            mov rdx,1       ; tell sys_read to read 1 character from stdin
            syscall         ; call sys_read

            cmp eax,0       ; compare sys_read value to 0
            je exit         ; jump to exit if sys_read value == 0 (EOF); if not equal, proceed to next line
            ; implement tests and conditions to detect if byte [buff] is within the range 41h to 7Ah
            ; determine whether to add 0Ch or subtract an appropriate offset before encoding

    ; Write: Implement write functions
    
    exit:   mov rax,60      ; specify terminate sys_call
            mov rdi,0       ; pass 0 code ("success") to OS
            syscall         ; call sys_exit
    
; insert code between nops
    nop


