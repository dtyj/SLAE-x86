; ping.asm
;
; Author: Dennis Tan
; Date: 11-June-2020

global _start

section .text
    _start:
        xor ebx, ebx
        mul ebx

        push edx
        mov eax, 0x34399798
        mov bl, 0x02
        mul ebx
        dec eax
        push eax
        push 0x6e69622f
        mov ebx, esp

        push edx        
        mov dword [esp-4], 0x20207473
        mov dword [esp-8], 0x6f686c61
        mov dword [esp-12], 0x636f6c20
        mov dword [esp-16], 0x676e6970
        sub esp, 16
        mov esi,esp

        push edx
        push word 0x632d
        mov ecx, esp

        push edx ; null terminator
        push esi ; localhost
        push ecx ; -c
        push ebx ; hs//nib/

        mov ecx,esp
        xor eax,eax
        mov al, 0xb
        int 0x80
