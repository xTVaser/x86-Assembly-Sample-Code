;Written by Tyler Wilding
;RecursiveRecursionNumber

INCLUDE Irvine32.inc

.data


.code
main PROC

	mov EAX, 0			
	mov ECX, 50					;Recurse 50 times
	call RecursiveCount

	exit
main ENDP

RecursiveCount PROC

	LOOP RecursiveCall			;Loop as long as ECX isnt 0
		inc EAX					;If it is, increment and return
		ret

	RecursiveCall:
		inc EAX
		call RecursiveCount
		ret						;Exit after returning from base case, and recursive calls

RecursiveCount ENDP

END main
