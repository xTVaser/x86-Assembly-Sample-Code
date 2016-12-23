;Written by Tyler Wilding
;RandomStrings

INCLUDE Irvine32.inc

.data

string	BYTE	50 DUP (?)

.code
main PROC

	mov ECX, 20

	displayStrings:

		mov EAX, LENGTHOF string - 1			;Leave one empty spot so we can always null terminate
		call RandomRange						;Random Length

		mov EBX, OFFSET string

		call randomString						;Random String

		mov EDX, OFFSET string					;Print the String
		call WriteString
		call CRLF

	LOOP displayStrings

	exit
main ENDP

;Generates a random string
;EAX:			Length of String
;EBX:			Offset of storage array
;Return:		nil
;Preservations: ECX
randomString PROC

	push ECX									;Save ECX Counter

	;Capital Letters are 65->90 in ASCII
	mov ECX, EAX
	mov ESI, EBX

	generateString:

		mov EAX, 90+1							;Z
		mov EBX, 65								;A
		call BetterRandomRange

		mov [ESI], AL

		inc ESI

	LOOP generateString

	mov AL, 0
	mov [ESI], AL								;Null Terminate

	pop ECX										;Restore ECX Counter
	ret

randomString ENDP

;Takes in an upper and lower bound and produces a random number between them.
;Upper BOUND: 		EAX
;Lower BOUND: 		EBX
;Formula:			Rand(Upper - Lower) + Lower
;Dependencies:		Uses Irvine32's RandomRange
;Result:			Stored in EAX	
BetterRandomRange PROC
	
	sub EAX, EBX			;Upper - Lower
	call RandomRange

	add EAX, EBX			;Rand(...) + Lower

	ret

BetterRandomRange ENDP

END main