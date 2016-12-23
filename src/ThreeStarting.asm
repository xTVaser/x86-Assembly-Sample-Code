;Written by Tyler Wilding
;ThreeStarting

INCLUDE Irvine32.inc

.data

prompt	BYTE	"Please enter an integer: ",0
answer	BYTE	"The sum is: ",0

.code
main PROC

	mov ECX, 3
	
	Routine:
		call GetMaxXY				;Height in AL, Width in DL
		SAR AL, 1					;Divide by two to get the center of screen
		SAR DL, 1					;Divide by two

		mov DH, AL
		call Gotoxy					;Height in DH, Width in DL
	
		mov EDX, OFFSET prompt
		call WriteString
		call ReadInt				;First Int, stored in EAX
		mov EBX, EAX

		call WriteString
		call ReadInt				;Second int
		add EAX, EBX

		mov EDX, OFFSET answer
		call WriteString
		call WriteInt				;Print sum

		call WaitMsg
		call Clrscr					;Clear Screen

	LOOP Routine

	exit
main ENDP

END main