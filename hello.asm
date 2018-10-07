; -------------------------------------------------------------
; Writes "Hello, World" to the console using only system calls.
; Runs on 64-bit Linux only.
; To assemble and run:
;
;     nasm -f elf64 hello.asm
;     ld hello.o -o hello
;     ./hello
;     or in one line
;     nasm -felf64 hello.asm && ld hello.o -o hello && ./hello
;
; -------------------------------------------------------------

%define newline 0xA
%define nullchar 0x0

%define SYS_WRITE 1 ; system callcode for write
%define SYS_EXIT 60 ; system callcode for exit

%define STD_OUT 1

section   .data
    message  db    "Hello, World!", newline, nullchar
    len_message  equ  $-message

section   .text
;we must export the entry point to the ELF linker or
;loader. They conventionally recognize _start as their
;entry point. Use ld -e foo to override the default.
global  _start

    _start:
        call .print
        call .exit

    .print:
        mov       rax, SYS_WRITE
        mov       rdi, STD_OUT            ; we write text in the shell
        mov       rsi, message            ; address of string to output
        mov       rdx, len_message        ; number of bytes
        syscall                           ; invoke kernel
        ret                               ; return

    .exit:
        mov       rax, SYS_EXIT
        mov       rdi, 0                  ; exit code 0
        syscall                           ; invoke kernel

