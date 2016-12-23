;Written by Tyler Wilding
;ArrayCharacter

INCLUDE Irvine32.inc

.data

characters		BYTE	"H","A","C","E","B","D","F","G"
orderedChars	BYTE	LENGTHOF characters DUP (?)

links			DWORD	0d,4d,5d,6d,2d,3d,7d,0d

.code
main PROC

	mov ECX, LENGTHOF links

	mov ESI, OFFSET orderedChars
	mov EDI, 1									;Starting Index

	LinkTraversal:
		
		mov AL, characters[EDI]					;Get the Character
		mov [ESI], AL							;Put it in the ordered array

		call WriteChar

		mov EDI, links[EDI * TYPE links]		;Get the next link, its a DWORD array

	LOOP LinkTraversal

	exit
main ENDP

END main