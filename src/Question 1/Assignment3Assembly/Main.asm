;Tyler Wilding
;DESKTOP-EVD5HKS
;7/21/2016 1:39:04 PM

;Write a program which prompts the user to enter four numbers and store the numbers into four
;double word variables, A, B, C & D in the data segment. Each prompt must be different and
;specific. A and B are unsigned whereas C and D are signed values. Once collected, use the four
;values to solve and report the results for each of the following equations using only the EBX and
;EAX registers:

		;(A + B) – (C + D)
		;D – (A + B) – C
		;(B – D) + (A – C)

;To print a signed integer number, you would make sure the number to print is in the EAX
;register and then call the WriteInt library function. Your output should looks something like:

		;(A + B) – (C + D) = +23
		;D – (A + B) – C = +450
		;(B – D) + (A – C) = -32540

INCLUDE Irvine32.inc

.data

promptA		BYTE	"Please enter an unsigned number for var A: ",0
varA		DWORD	?
promptB		BYTE	"Please enter an unsigned number for var B: ",0
varB		DWORD	?
promptC		BYTE	"Please enter an signed number for var C: ",0
varC		SDWORD	?
promptD		BYTE	"Please enter an signed number for var D: ",0
varD		SDWORD	?

answerOne	BYTE	"(A + B) - (C + D) = ",0
answerTwo	BYTE	"D - (A + B) - C = ",0
answerThree	BYTE	"(B - D) + (A - C) = ",0

.code
main PROC

	mov EAX, 0

	mov EDX, OFFSET promptA						;Get the numbers
	call WriteString
	call ReadDec
	mov varA, EAX

	mov EDX, OFFSET promptB
	call WriteString
	call ReadDec
	mov varB, EAX

	mov EDX, OFFSET promptC
	call WriteString
	call ReadInt
	mov varC, EAX

	mov EDX, OFFSET promptD
	call WriteString
	call ReadInt
	mov varD, EAX

	mov EDX, OFFSET answerOne
	call WriteString

	mov EAX, varA								;(A + B) - (C + D)
	add EAX, varB
	mov EBX, varC
	add EBX, varD
	sub EAX, EBX
	call WriteInt
	call crlf

	mov EDX, OFFSET answerTwo					;D - (A + B) - C
	call WriteString

	mov EAX, varA
	add EAX, varB
	mov EBX, varD
	sub EBX, EAX
	sub EBX, varC
	mov EAX, EBX
	call WriteInt
	call crlf

	mov EDX, OFFSET answerThree					;(B - D) + (A - C)
	call WriteString

	mov EAX, varB
	sub EAX, varD
	mov EBX, varA
	sub EBX, varC
	add EAX, EBX
	call WriteInt
	call crlf

	exit
main ENDP

END main