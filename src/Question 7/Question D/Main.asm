;Tyler Wilding
;DESKTOP-EVD5HKS
;8/2/2016 1:12:07 PM
;Question_D

;Page 188

INCLUDE Irvine32.inc

.data

userChar        BYTE    ?
startFore       DWORD    ?
startBack       DWORD    ?

promptChar      BYTE    "Please enter the starting capital letter: ",0
promptFore      BYTE    "Please enter the starting foreground (0-15): ",0
promptBack      BYTE    "Please enter the starting background (0-15): ",0

.code
main PROC

        mov     EDX, OFFSET promptChar
        call    WriteString
        call    ReadChar
        mov     userChar, AL
        call    crlf

        mov     EDX, OFFSET promptFore
        call    WriteString
        call    ReadDec
        mov     startFore, EAX

        mov     EDX, OFFSET promptBack
        call    WriteString
        call    ReadDec
        mov     startBack, EAX


	mov     EBX, startFore				;Foreground
	mov     EDX, startBack				;Background
        shl     EDX, 4

	mov     ECX, 16					;16 background colors

	Background:
		
		push    ECX				;Preserve ECX
		mov     ECX, 16				;16 foreground colors
		
		Foreground:

			mov     EAX, EBX                ;Add Foreground and Background color together
			add     EAX, EDX

			call    SetTextColor	        ;Set Color

			mov     AL, userChar            ;Print the letter
			call    WriteChar
                        inc     userChar
                        cmp     AL, 'Z'                 ;If the letter is a Z set it to be an A for next iteration
                        JNE     nextIteration
                        mov     userChar, 'A'
                        
                        nextIteration:
			inc     EBX			;Increment foreground color

                        cmp     EBX, 15                 ;If we have 
                        JNE     nextIteration2
                        mov     EBX, 0

                        nextIteration2:
		LOOP    Foreground

		pop     ECX				;Retrieve ECX

		mov     EBX, startFore			;Reset Foreground
		add     EDX, 16				;Increment background color

                call    crlf

                cmp     EDX, 256                        ;Max colors
                JNE     comeOnLoop
                mov     EDX, 0
		comeOnLoop:

	LOOP    Background

	mov     EAX, white + 0
	call    SetTextColor

	exit
main ENDP

END main