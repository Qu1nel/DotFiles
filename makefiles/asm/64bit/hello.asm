global _start

section .text

_start:
    call WRITE_HELLO
    call EXIT

WRITE_HELLO:
    mov rax, 1          ; write(
    mov rdi, 1          ;   STDOUT_FILENO,
    mov rsi, msg        ;   "Hello, World!\n",
    mov rdx, msglen     ;   sizeof("Hello, World!\n")
    syscall             ; );

EXIT:
    mov rax, 60         ; _exit(
    mov rdi, 0          ;   EXIT_SUCCESS  //  return 0;
    syscall             ; );

section .rodata
    msg: db "Hello, World!", 10
    msglen: equ $-msg
