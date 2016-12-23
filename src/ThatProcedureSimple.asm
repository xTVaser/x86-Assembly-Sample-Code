;Written by Tyler Wilding
;ThatProcedureSimple

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
                DWORD   xANDy
EntrySize       =       ($ - MenuChoices)                       ;Find the size for each pair of key and offset
                BYTE    '2'
                DWORD   xORy
                BYTE    '3'
                DWORD   NOTx
                BYTE    '4'
                DWORD   xXORy
MenuSize        =       ($ - MenuChoices) / EntrySize           ;Number of pairs

prompt          BYTE    "Please select an option: ",0           

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

	        exit

main ENDP


xANDy PROC

        mov     EDX, OFFSET menuOption1
        call    WriteString
        call    crlf

        ret

xANDy ENDP

xORy PROC

        mov     EDX, OFFSET menuOption2
        call    WriteString
        call    crlf

        ret
xORy ENDP

NOTx PROC

        mov     EDX, OFFSET menuOption3
        call    WriteString
        call    crlf

        ret
NOTx ENDP

xXORy PROC

        mov     EDX, OFFSET menuOption4
        call    WriteString
        call    crlf

        ret
xXORy ENDP

END main