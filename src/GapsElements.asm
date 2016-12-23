;Written by Tyler Wilding
;GapsElements

INCLUDE Irvine32.inc

.data

array	DWORD	0, 2, 5, 9, 10				;Gaps of 2, 3, 4 and 1, sum is 10

.code
main PROC

	mov ECX, LENGTHOF array - 1				;We start 1 less because there are n-1 gaps
	mov ESI, 0
	mov EAX, 0								;Use EAX as our accumulator

	GapAdd:
		
		mov EDX, array[ESI + TYPE array]	;i+1
		mov EBX, array[ESI]					;i
		sub EDX, EBX						;i+1 - i = Gap Value

		add EAX, EDX						;add the gap to the total

		add ESI, TYPE array					;move ahead a DWORD

	LOOP GapAdd								;Loop until ECX equals 0

	call WriteInt			

	exit
main ENDP

END main