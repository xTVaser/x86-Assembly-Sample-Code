;Written by Tyler Wilding
;ElementsCopy

INCLUDE Irvine32.inc

.data

wordArray	WORD	10h, 20h, 30h, 40h, 50h, 60h
dwordArray	DWORD	SIZEOF wordArray DUP(?)	* 2		;Create DWORD array with the same amount of indexes, (DWORDS are twice as big as WORDS)

.code
main PROC

	mov ECX, LENGTHOF wordArray						
	mov ESI, OFFSET wordArray
	mov EDI, OFFSET dwordArray

	ArrayCopy:
		
		mov AX, [ESI]								;Get the element out of the WORD array
		mov WORD PTR [EDI], AX						;Put the element into the DWORD array

		add ESI, TYPE wordArray						;Move forward
		add EDI, TYPE dwordArray

	LOOP ArrayCopy

	exit
main ENDP

END main