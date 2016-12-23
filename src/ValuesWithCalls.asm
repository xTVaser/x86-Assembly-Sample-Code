;Written by Tyler Wilding
;ValuesWithCalls

INCLUDE Irvine32.inc

.data

array		DWORD		10 DUP (?)
promptN		BYTE		"Please enter a value for N, less than 10: ",0
promptJ		BYTE		"Please enter a value for J: ",0
promptK		BYTE		"Please enter a value for K: ",0

varN		DWORD		?
varJ		DWORD		?
varK		DWORD		?

.code
main PROC

	mov EDX, OFFSET promptN
	call WriteString
	call ReadDec
	mov varN, EAX

	mov EDX, OFFSET promptJ
	call WriteString
	call ReadInt
	mov varJ, EAX

	mov EDX, OFFSET promptK
	call WriteString
	call ReadInt
	mov varK, EAX
	
	mov ESI, OFFSET array
	mov ECX, varN

	mov EBX, varJ
	mov EAX, varK

	call fillArray
	call crlf
	call fillArray

	exit
main ENDP

;Fills an array with random numbers between EBX and EAX
;Upper BOUND: 		EAX
;Lower BOUND: 		EBX
;OFFSET of Array:	ESI
;Length of array:	ECX
;Dependencies:		ESI, ECX, EAX, EBX
;Result:			nil
fillArray PROC

	push ESI
	push ECX

	loopArray:
		
		push EAX											;Save the upperbound as random gets stored in EAX
		call BetterRandomRange								;Get the random number
	
		mov [ESI], EAX										;Fill Array
		call WriteInt

		mov AL, ' '											
		call WriteChar
		
		add ESI, TYPE array
		pop EAX												;Pop it off

	loop loopArray

	pop ECX
	pop ESI
		
	ret
fillArray ENDP

;Takes in an upper and lower bound and produces a random number between them.
;Upper BOUND: 		EAX
;Lower BOUND: 		EBX
;Formula:			Rand(Upper - Lower) + Lower
;Dependencies:		Uses Irvine32's RandomRange
;Result:			Stored in EAX	
BetterRandomRange PROC
	
	inc EAX					;We want to include the upper bound
	sub EAX, EBX			;Upper - Lower
	call RandomRange

	add EAX, EBX			;Rand(...) + Lower

	ret

BetterRandomRange ENDP

END main