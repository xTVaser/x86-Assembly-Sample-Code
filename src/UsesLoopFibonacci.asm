;Written by Tyler Wilding
;UsesLoopFibonacci

INCLUDE Irvine32.inc

.data

fibNumbers	DWORD	7 DUP (?)
.code
main PROC

	mov ECX, LENGTHOF fibNumbers - 2				;We are going to manually generate the first two fibonacci numbers

	mov EAX, 1
	mov EBX, 1

	mov ESI, OFFSET fibNumbers

	mov [ESI], EAX
	add ESI, TYPE fibNumbers

	mov [ESI], EBX
	add ESI, TYPE fibNumbers

	Fibonacci:
		
		mov EAX, 0									;Reset Accumulator
		add EAX, [ESI-4]							;Add the previous to Accumulator
		add EAX, [ESI-8]							;Add the previous-previous to Accumulator

		mov [ESI], EAX								;Move the fibonacci number to EAX

		add ESI, TYPE fibNumbers					;Add ESI

	LOOP Fibonacci

	exit
main ENDP

END main
