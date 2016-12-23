;Written by Tyler Wilding
;HexadecimalUnder

INCLUDE Irvine32.inc

.data

bigEndian BYTE 12h, 34h, 56h, 78h
littleEndian DWORD ?				;78 56 34 12

.code
main PROC

	mov eax, OFFSET bigEndian				;For debugging purposes, go to this memory address to see the values being stored.

	mov al, bigEndian[3]					;last element in big endian into the first in little endian
	mov BYTE PTR littleEndian[0], al

	mov al, bigEndian[2]					;...
	mov BYTE PTR littleEndian[1], al

	mov al, bigEndian[1]					;...
	mov BYTE PTR littleEndian[2], al

	mov al, bigEndian[0]					;...
	mov BYTE PTR littleEndian[3], al

	mov EAX, DWORD PTR bigEndian			;Big Endian number interpreted as little endian, logic error = 78563412
	mov EAX, littleEndian					;Big Endian number stored as little endian = 12345678 as expected

	exit
main ENDP

END main
