;Tyler Wilding
;DESKTOP-EVD5HKS
;8/2/2016 12:03:37 PM
;Question_C

INCLUDE Irvine32.inc

.data

characters		BYTE	'Z','X','A','P','Q','S','I','U','M','K','H','R','L','J','C','E','G','Y','N','O','V','D','F','B','W','T'
orderedChars	        BYTE	LENGTHOF characters DUP (?)

links			DWORD	0,17,23,4,11,25,13,20,18,12,6,5,8,9,21,22,10,0,19,3,24,15,16,14,1,7

.code
main PROC

	mov ECX, LENGTHOF links

	mov ESI, OFFSET orderedChars
	mov EDI, 2									;Starting Index

	LinkTraversal:
		
		mov AL, characters[EDI]					                ;Get the Character
		mov [ESI], AL							        ;Put it in the ordered array

		call WriteChar

		mov EDI, links[EDI * TYPE links]		                        ;Get the next link, its a DWORD array

	LOOP LinkTraversal

        call crlf

	exit
main ENDP

END main