;Written by Tyler Wilding
;RegistersCalculatesExpression

INCLUDE Irvine32.inc

.data


.code
main PROC

	mov EAX, 100h		;Assigning Values to Registers
	mov EBX, 200h
	mov ECX, -100h
	mov EDX, -500h

	add EAX, EBX		;A+B
	add ECX, EDX		;C+D

	sub EAX, ECX		;A+B - (C+D)

	call DumpRegs

	exit
main ENDP

END main