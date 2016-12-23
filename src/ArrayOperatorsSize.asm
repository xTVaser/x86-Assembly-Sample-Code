;Written by Tyler Wilding
;ArrayOperatorsSize

INCLUDE Irvine32.inc

.data

intArray	DWORD	10d, 20d, 30d, 40d, 50d, 60d, 70d, 80d, 90d

.code
main PROC

	mov ESI, OFFSET intArray										;Beginning of Array
	mov EDI, OFFSET intArray + SIZEOF intArray - TYPE intArray		;End of Array

	mov ECX, LENGTHOF intArray / 2									;We swap two elements at a time, so half as many iterations

	ReverseArray:

		mov EAX, [ESI]
		mov EBX, [EDI]

		mov [ESI], EBX												
		mov [EDI], EAX

		add ESI, TYPE intArray
		sub EDI, TYPE intArray

	LOOP ReverseArray


	exit
main ENDP

END main