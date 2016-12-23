;Written by Tyler Wilding
;MembersAddressingPosition

INCLUDE Irvine32.inc

.data

intArray	DWORD	10d,20d,30d,40d,50d

.code
main PROC

	mov EAX, OFFSET intArray
	mov ECX, LENGTHOF intArray - 1						; Swap n-1 elements
	mov ESI, SIZEOF intArray - (TYPE intArray)			; Start at the end of the array

	mov EDX, intArray[ESI]								; Save the last element that will be lost during rotation

	RotateArray:
			
		mov EAX, intArray[ESI - TYPE intArray]			; Move the preceeding element forward
		mov intArray[ESI], EAX

		sub ESI, TYPE intArray							

	LOOP RotateArray

	mov intArray[ESI], EDX								; Rotate the last element to the front

	exit
main ENDP

END main