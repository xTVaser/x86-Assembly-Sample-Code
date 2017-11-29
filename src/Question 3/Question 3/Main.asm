;Tyler Wilding
;DESKTOP-EVD5HKS
;7/21/2016 2:25:50 PM
;Question_3

;[20 marks] Design a program which has an array of at least 5 elements. Initially the data type
;should be BYTE. Your program will:
		;a.		Display the items as signed integer values in a comma and space separated list. (The
				;last item can have a comma after it since you can’t do IF statements). End the list with a
				;carriage return and line feed.

		;b.		Display the items as HEX values in a comma and space separated list. (The last item can
				;have a comma after it since you can’t do IF statements). End the list with a carriage
				;return and line feed. For this requirements, BYTE values should be just 2 digit HEX
				;numbers and WORD values should be 4 digit HEX numbers.

		;c. Total the numbers in the array together.

		;d. Display the total as a signed integer value.

;Your program must be adaptable. If elements are added or removed to the array, the program
;must continue to work correctly. If the array is changed from BYTE to WORD, it must continue
;to work correctly.

INCLUDE Irvine32.inc

.data

array		WORD	1000h, 2000h, 3000h, 4000h, 5000h						;Anything will work, dont worry.

.code
main PROC

	mov ECX, LENGTHOF array - 1												;-1 items because i dont want a trailing comma at the end
	mov ESI, OFFSET array

	printArrayInt:															;Part A

		movzx EAX, (TYPE array) PTR [ESI]									;EAX is a 32-bit register, so we must say that the address points to only a byte, word, etc
		call WriteInt
		
		add ESI, TYPE array

		mov AL, ','
		call WriteChar
		mov AL, ' '
		call WriteChar

	LOOP printArrayInt

	mov EAX, [ESI]
	call WriteInt
	call crlf

	mov ECX, LENGTHOF array - 1
	mov ESI, OFFSET array

	printArrayHex:															;Part B

		movzx EAX, (TYPE array) PTR [ESI]									;Same as last except we call WriteHex instead
		call WriteHex

		add ESI, TYPE array
		
		mov AL, ','
		call WriteChar
		mov AL, ' '
		call WriteChar

	LOOP printArrayHex

	mov EAX, [ESI]
	call WriteHex
	call crlf

	mov ECX, LENGTHOF array
	mov ESI, OFFSET array

	mov EAX, 0																;Reset accumulator

	totalArray:																;Part C
		
		movzx EBX, (TYPE array) PTR [ESI]									;Same, add to EAX
		add EAX, EBX

		add ESI, TYPE array

	LOOP totalArray

	call WriteInt															;Part D
	call crlf
		
	exit
main ENDP

END main