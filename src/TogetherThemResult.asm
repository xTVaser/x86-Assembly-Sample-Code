;Written by Tyler Wilding
;TogetherThemResult

INCLUDE         Irvine32.inc

.data

menuOption1     BYTE    "x AND y",0                             ;Because the program wants individual names of operations
menuOption2     BYTE    "x OR y",0
menuOption3     BYTE    "NOT x",0
menuOption4     BYTE    "x XOR y",0
menuOption5     BYTE    "Exit program",0

completeMenu    BYTE    "1) x AND y", 13d, 10d,                 ;A more convienant way to print the menu
                        "2) x OR y", 13d, 10d,                  ;13 is carriage return, 10 is linefeed in ASCII
                        "3) NOT x", 13d, 10d,
                        "4) x XOR y", 13d, 10d,
                        "5) Exit program", 13d, 10d, 0

MenuChoices     BYTE    '1'                                     ;Table Driven Selection
                DWORD   AND_op
EntrySize       =       ($ - MenuChoices)                       ;Find the size for each pair of key and offset
                BYTE    '2'
                DWORD   OR_op
                BYTE    '3'
                DWORD   NOT_op
                BYTE    '4'
                DWORD   XOR_op
MenuSize        =       ($ - MenuChoices) / EntrySize           ;Number of pairs

prompt          BYTE    "Please select an option: ",0  

hexPrompt       BYTE    "Please enter a hexadecimal number: ",0          

.code
main PROC

        StartOver:                                              ;Invalid number is hit, we restart
                
        mov     EDX, OFFSET completeMenu                        ;Print the menu
        call    WriteString

        mov     EDX, OFFSET prompt                              ;Print the prompt and get the char
        call    WriteString
        call    ReadChar
        call    crlf

        mov     ESI, OFFSET MenuChoices
        mov     ECX, MenuSize

        LoopMenu:
                
                cmp     AL, '5'                                 ;If the user enters 5, we stop
                JE      exitLoop

                cmp     AL, [ESI]                               ;Otherwise, search the array for the key if they didnt match
                JNE     continueSearch

                call    NEAR PTR [ESI+1]                        ;If they did match, call the procedure, its an indirect call so we need to use NEAR      
                JMP     StartOver                               ;After the procedure is done, loop it

                continueSearch:
                add     ESI, EntrySize                          ;Move ahead to the next pair of if we didnt find it

        LOOP    LoopMenu

        JMP     StartOver                                       ;If the menu is exhausted, start over as well

        exitLoop:
                call crlf
	        exit

main ENDP

;Calculates the result of two hex numbers bitwise ANDed together
AND_op PROC

        call    crlf
        mov     EDX, OFFSET menuOption1                         ;Menu option
        call    WriteString
        call    crlf

        mov     EDX, OFFSET hexPrompt                           ;Get the first number
        call    WriteString
        call    ReadHex
        mov     EBX, EAX                                        ;Move it out of the way

        call    WriteString                                     ;Get the second number
        call    ReadHex
        
        AND     EAX, EBX                                        ;Do the operation and print it
        call    WriteHex        
        call    crlf
        call    crlf

        ret

AND_op ENDP

;Calculates the result of two hex numbers bitwise ORed together
OR_op PROC

        call    crlf
        mov     EDX, OFFSET menuOption2
        call    WriteString
        call    crlf

        mov     EDX, OFFSET hexPrompt
        call    WriteString
        call    ReadHex
        mov     EBX, EAX

        call    WriteString
        call    ReadHex
        
        OR      EAX, EBX
        call    WriteHex
        call    crlf
        call    crlf

        ret
OR_op ENDP

;Calculates the result of a hex number bitwise NOT
NOT_op PROC
        
        call    crlf
        mov     EDX, OFFSET menuOption3
        call    WriteString
        call    crlf

        mov     EDX, OFFSET hexPrompt
        call    WriteString
        call    ReadHex
        
        NOT     EAX
        call    WriteHex
        call    crlf
        call    crlf

        ret
NOT_op ENDP

;Calculates the result of two hex numbers bitwise XORed together
XOR_op PROC
        
        call    crlf
        mov     EDX, OFFSET menuOption4
        call    WriteString
        call    crlf

        mov     EDX, OFFSET hexPrompt
        call    WriteString
        call    ReadHex
        mov     EBX, EAX

        call    WriteString
        call    ReadHex
        
        XOR     EAX, EBX
        call    WriteHex
        call    crlf
        call    crlf

        ret
XOR_op ENDP

END main
