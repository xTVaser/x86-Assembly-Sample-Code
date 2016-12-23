;Written by Tyler Wilding
;RequiredFalls

INCLUDE Irvine32.inc

.data

whiteCount      DWORD   ?
blueCount       DWORD   ?
greenCount      DWORD   ?

whiteString     BYTE    "White: ",0
blueString      BYTE    "Blue: ",0
greenString     BYTE    "Green: ",0

helloWorld      BYTE    "Hello World!",13d,10d,0

WHITE           =       15
BLUE            =       11
GREEN           =       10

.code
main PROC

        call    Randomize                                       ;Get different numbers everytime

        mov     ECX, 100                                
        mov     EDX, OFFSET helloWorld

        Print100Strings:

	        mov     EAX, 10
                mov     EBX, 0
                call    BetterRandomRange                       ;Get the random number between 0-9
                xchg    EAX, EBX

                cmp     EBX, 2                                  ;If its <= 2, make it white
                JG      IsItBlue

                mov     EAX, WHITE
                call    SetTextColor
                inc     whiteCount
                JMP     PrintString
        
                IsItBlue:

                        cmp     EBX, 3                          ;If its not 3, then its not blue or white so its green
                        JNE     ItsGreen
                        mov     EAX, BLUE
                        call    SetTextColor                    ;Else set it to blue
                        inc     blueCount
                        JMP     PrintString

                ItsGreen:                                       ;Set it to green
                
                        mov     EAX, GREEN
                        call    SetTextColor
                        inc     greenCount
        
                PrintString:

                        call    WriteString
                        call    crlf

        loop Print100Strings

        mov     EDX, OFFSET whiteString                         ;Print out the stats to justify the random number correctness
        call    WriteString
        mov     EAX, whiteCount
        call    WriteDec
        call    crlf

        mov     EDX, OFFSET blueString
        call    WriteString
        mov     EAX, blueCount
        call    WriteDec
        call    crlf

        mov     EDX, OFFSET greenString
        call    WriteString
        mov     EAX, greenCount
        call    WriteDec
        call    crlf

	exit

main ENDP

;Takes in an upper and lower bound and produces a random number inclusively between them.
;Upper BOUND: 		EAX
;Lower BOUND: 		EBX
;Formula:		Rand(Upper - Lower) + Lower
;Dependencies:		Uses Irvine32's RandomRange
;Result:		Stored in EAX	
BetterRandomRange PROC
	
	inc EAX				;We want to include the upper bound
	sub EAX, EBX			;Upper - Lower
	call RandomRange

	add EAX, EBX			;Rand(...) + Lower

	ret

BetterRandomRange ENDP


END main