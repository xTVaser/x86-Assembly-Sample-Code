;Written by Tyler Wilding
;ScreenCurrent

INCLUDE Irvine32.inc

.data


.code
main PROC

	mov ECX, 100

	RandomScreenSpots:
		
		mov EAX, 0
		call GetMaxXY				;AL = Row DL = Col
		call RandomRange

		mov DH, AL					;Move the random Row to DH
		movzx EAX, DL				;Move the screen's cols to eax
		call RandomRange

		mov DL, AL					;Move the random Col to DL

		call Gotoxy					;Move the cursor to row,col

		mov EAX, 90+1				;A-Z
		mov EBX, 65

		call BetterRandomRange
		call WriteChar

	LOOP RandomScreenSpots

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