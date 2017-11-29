;Tyler Wilding
;DESKTOP-EVD5HKS
;7/21/2016 2:08:32 PM
;Question_2

;[20 marks] Write a program that asks the user for the speed of a train and how many hours
;they want to track the distance traveled. Then prepare a chart which looks something like the
;following to show each hour from 1 till the hour specified and the total distance traveled by the
;end of that hour.
		;Hour		Distance Traveled
		;------------------------------
		;1			40
		;2			80
		;3			120
		;4			160
		;5			200

INCLUDE Irvine32.inc

.data

speedOfTrain	BYTE	"Please enter the speed of the train: ",0
hoursOfTravel	BYTE	"Please enter the amount of hours of travel: ",0

headerHour		BYTE	"Hour",0
headerDistance	BYTE	"Distance Traveled",0
line			BYTE	"----------------------------------------------",0

varSpeed		DWORD	?

.code
main PROC

	mov EDX, OFFSET speedOfTrain						;Collect input
	call WriteString
	call ReadInt
	mov EBX, EAX
	mov varSpeed, EAX
	
	mov EDX, OFFSET hoursOfTravel
	call WriteString
	call ReadInt
	mov ECX, EAX

	call crlf
	mov EDX, OFFSET headerHour							;Print headers for table
	call WriteString
	mov AL, 9											;9 is the ascii value for TAB
	call WriteChar
	call WriteChar

	mov EDX, OFFSET headerDistance
	call WriteString
	call crlf
	mov EDX, OFFSET line
	call WriteString
	call crlf

	mov EDX, 1											;Hour counter since we dont have conditional jumps
	printChart:
		
		mov EAX, EDX									;Print the hour counter
		call WriteDec
		mov AL,9
		call WriteChar
		call WriteChar

		mov EAX, EBX									;Print the distance so far
		call WriteDec
		call crlf

		inc EDX											;Increase the hour
		add EBX, varSpeed								;Travel 1 hour worth of distance
	
	loop printChart										;Until ECX = 0

	exit
main ENDP

END main