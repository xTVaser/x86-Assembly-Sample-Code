;Written by Tyler Wilding
;ThatTestGenerates

INCLUDE Irvine32.inc

.data


.code
main PROC
	
	mov ECX, 50				;50 Numbers
	
	mov EBX, -300			;Lower Bound

	RandomNumbers:
		
		mov EAX, 100		;Upper Bound

		call BetterRandomRange
		call WriteInt

		call Crlf

	LOOP RandomNumbers

	exit
main ENDP

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