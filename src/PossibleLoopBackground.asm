;Written by Tyler Wilding
;PossibleLoopBackground

INCLUDE Irvine32.inc

.data


.code
main PROC

	mov EBX, 0					;Foreground
	mov EDX, 0					;Background

	mov ECX, 16					;16 background colors

	Background:
		
		push ECX				;Preserve ECX
		mov ECX, 16				;16 foreground colors
		
		Foreground:

			mov EAX, EBX
			push EDX			;Preserve EDX
			shl EDX, 4			;Multiply by 16
			add EAX, EDX
			pop EDX				;Retrieve EDX

			call SetTextColor	;Set Color

			mov AL, '#'
			call WriteChar

			inc EBX				;Increment foreground color

		LOOP Foreground

		pop ECX					;Retrieve ECX

		mov EBX, 0				;Reset Foreground
		inc EDX					;Increment background color
		call CRLF

	LOOP Background

	mov EAX, white + 0
	call SetTextColor

	exit
main ENDP

END main