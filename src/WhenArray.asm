;Written by Tyler Wilding
;WhenArray

INCLUDE Irvine32.inc

.data

array	BYTE	50 DUP (0)
N		BYTE	50

.code
main PROC

	mov EAX, 2
	mov ESI, OFFSET array
	mov ECX, LENGTHOF array
	call multiples
										;The question does not say to reset the array before each call
										;It would make sense not to reset the array if you are finding primes anyway
	mov EAX, 3
	mov ESI, OFFSET array
	mov ECX, LENGTHOF array
	call multiples

	exit
main ENDP

;Finds all the multiples of K in EAX, marks the respective index in an array of N length
;Registers
;EAX			K
;ECX			Length of array
;ESI			Offset of array
;Return			nil
multiples PROC

	push EAX							;Save all registers
	push ESI
	push EDX
	push ECX
	push EBX

	mov EBX, EAX
	mov EAX, ECX
	sub EAX, 1							;We want all multiples up to less than N, 
										;else our array needs to be 1 spot larger

	div BL								;Find out how many times to loop
	mov AH, 0							;Clear the remainder
	mov ECX, EAX
	mov EAX, EBX

	findMultiples:

		add ESI, EAX					;Add K value to EAX
		mov EBX, 1
		mov [ESI], BL
		
	LOOP findMultiples
	
	pop EBX								;Restore register
	pop ECX
	pop EDX
	pop ESI
	pop EAX

	ret
multiples ENDP	


END main