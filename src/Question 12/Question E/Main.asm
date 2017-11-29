;Tyler Wilding
;DESKTOP-EVD5HKS
;8/8/2016 12:11:12 PM
;Question_E

;Challenge: Using only SUB, MOV, and AND instructions, show how to calculate x = n mod y,
;assuming that you are given the values of n and y. You can assume that n is any 32-bit
;unsigned integer, and y is a power of 2.

INCLUDE Irvine32.inc

.data

prompt1         BYTE    "Enter a value for n: ",0
prompt2         BYTE    "Enter a value for y(power of 2): ",0

n               DWORD   ?
y               DWORD   ?

.code
main PROC

	mov     EDX, OFFSET prompt1
        call    WriteString
        call    ReadDec
        mov     n, EAX

        mov     EDX, OFFSET prompt2
        call    WriteString
        call    ReadDec
        mov     y, EAX

        mov     EAX, n
        mov     EBX, y
        sub     ebx, 1
        and     EAX, EBX                        

        call    WriteDec
        call    crlf

	exit
main ENDP

END main