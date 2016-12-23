;Written by Tyler Wilding
;PageDifferentBooks

INCLUDE Irvine32.inc

.data

string BYTE "Hello World",0

.code
main PROC

	mov ECX, 14					;We want to skip black, which is 0

	mov EDX, OFFSET string	


	ColorLoop:

		mov EAX, ECX			;Move color info to EAX
		inc EAX					;Add one to it

		call SetTextColor		
		call WriteString
		call CRLF				;New Line

	LOOP ColorLoop

	exit
main ENDP

END main
