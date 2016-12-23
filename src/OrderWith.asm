;Written by Tyler Wilding
;OrderWith

INCLUDE Irvine32.inc

.data

source	BYTE	"This is the source string", 0
target	BYTE	SIZEOF source DUP('#')	

.code
main PROC

	mov ECX, LENGTHOF source								

	mov ESI, OFFSET source + SIZEOF source - TYPE source		;End of Original string
	mov EDI, OFFSET target										;Beginning of target string

	ReverseString:
		
		movzx EAX, BYTE PTR [ESI]								;One way to do a move with different operand sizes
		mov [EDI], AL											;Another way

		add EDI, TYPE source									;Move to the next items
		sub ESI, TYPE target

	LOOP ReverseString

	exit
main ENDP

END main