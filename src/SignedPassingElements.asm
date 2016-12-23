;Written by Tyler Wilding
;SignedPassingElements

INCLUDE Irvine32.inc

.data

array	SDWORD		10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150

varJ	DWORD		?
varK	DWORD		?

promptJ	BYTE		"Please enter the value for J: ",0
promptK	BYTE		"Please enter the value for K: ",0

answer	BYTE		"The sum of all values in the array from J..K is: ",0

.code
main PROC

	mov EDX, OFFSET promptJ					;Get value for J
	call WriteString
	call ReadInt
	mov varJ, EAX
	call crlf

	mov EDX, OFFSET promptK					;Get value for K
	call WriteString
	call ReadInt
	mov varK, EAX
	call crlf

	mov ESI, OFFSET array					;Push all nessecary values to registers
	mov ECX, LENGTHOF array
	mov EBX, varJ
	mov EDX, varK

	mov EAX, 0						;Reset EAX to 0 cause it will store the value
	call sumJToK
	call WriteInt
	call crlf

	mov EAX, 0
	call sumJToK
	call WriteInt
	call crlf

	exit
main ENDP

;Finds the sum of all integers inside and array between and inclusive range
;Upper BOUND: 		EDX
;Lower BOUND: 		EBX
;OFFSET of Array:	ESI
;Dependencies:		ESI, ECX, EDX, EBX
;Result:			Sum stored in EAX
sumJToK PROC

	push ESI                                                ;Preserve register values
	push ECX        
	push EBX
	push EDX

	loopArray:
		
		cmp [ESI], EBX				        ;Check if the value in the array is greater than lower bound
		JL skip
		
		cmp [ESI], EDX                                  ;Check if it is also smaller than the upperbound
		JG skip

		add EAX, [ESI]                                  ;If both conditions are met, then add to the total (AND)

		skip:

		add ESI, TYPE array

	loop loopArray

	pop EDX                                                 ;Restore register values
	pop EBX
	pop ECX
	pop ESI

	ret
sumJToK ENDP

END main