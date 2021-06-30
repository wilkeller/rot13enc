; Author: Wil Keller
; File: rot13enc.asm
; Description: An x86-64 ASM program to encode/decode input to ROT13 format. First ASM
; program using what I've read from the first 8 Chapters of Duntemann's "Assembly 
; Language Step-by-step" and looking up x86 syscalls & etc. Mostly just practice coding 
; to cement the fundamentals in my mind. 
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
    read:   mov rax,0       ; specify x64 sys_read call
            mov rdi,0       ; specify file descriptor stdin
            mov rsi,buff    ; pass address of buffer to read to
            mov rdx,1       ; tell sys_read to read 1 character from stdin
            syscall         ; call sys_read

; Test for EOF. test to see if a character falls within the ASCII uppercase range. Encode it, write it, or pass to lotest().
    uptest: cmp rax,0       ; compare sys_read value to 0
            je exit         ; jump to exit if sys_read value == 0 (EOF); if not equal, proceed to next line
            cmp byte [buff],41h  ; compare contents of buff to 41h (Uppercase A)
            jb write        ; if below A, no encoding necessary; jump to write section
            cmp byte [buff],5ah  ; compare contents of buff to 5ah (uppercase z)
            ja lotest       ; If above Z, jump to lotest
            cmp byte [buff],4Dh ; compare contents of buff to 4Dh (uppercase M)
            ja hihi         ; if above 4Dh (uppercase M), jump to the alternate encode method.
            add byte [buff],0Dh ; encode A-M characters
            jmp write       ; Work complete; pass character to write()
    hihi:   sub byte [buff],0Dh ; encode N-Z characters
            jmp write       ; work complete; pass character to write()
            

; test to see if a character falls within the ASCII lowercase range. Either encode it or write it.
    lotest: cmp byte [buff],7ah ; compare contents of buff against 7ah (lowercase z)
            ja write        ; if above z, no encoding necessary; jump to write section
            cmp byte [buff],61h ; compare contents of buff to 61h (lowercase a)
            jb write        ; if below a (and already established above Z), no encoding necessary; jump to write section
            cmp byte [buff],6Dh ; compare contents of buff to 6Dh (lowercase m)
            ja lolo         ; if above 6Dh (lowercase m), jump to alternate encode method
            add byte [buff],0Dh ; Encode a-m characters
            jmp write       ; work complete, pass character to write()
    lolo:   sub byte [buff],0Dh ; encode n-z characters
            jmp write       ; work complete, pass character to write()
            

; write character in [buff] to stdout.
    write: mov rax,1        ;specify x64 sys_write call
            mov rdi,1       ; specify file descriptor stdout
            mov rsi,buff    ; pass memory address of character to write
            mov rdx,1       ; specify number of characters to move
            syscall         ; write buff to stdout
            jmp read        ; Jump to read; collect next character
    
; exit program gracefully
    exit:   mov rax,60      ; specify terminate sys_call
            mov rdi,0       ; pass 0 code ("success") to OS
            syscall         ; call sys_exit
    
; insert code between nops
    nop
