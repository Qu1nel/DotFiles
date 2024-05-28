global _start

section .text

_start:
    call WRITE_HELLO ; WRITE_HELLO()
    call EXIT        ; EXIT()

WRITE_HELLO:  ; syscall(4, 1, msg, 14);  ==  write(1, "Hello, World!\n", 14);
    mov eax, 0x04
    mov ebx, 0x1
    mov ecx, msg
    mov edx, 14
    int 0x80

EXIT:  ; syscall(1, 0);  ==  return 0;
    mov eax, 0x01
    mov ebx, 0
    int 0x80

section .rodata
    msg: db "Hello, World!", 0xA, 0x0
