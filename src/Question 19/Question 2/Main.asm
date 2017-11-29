;Tyler Wilding
;DESKTOP-EVD5HKS
;8/23/2016 12:44:18 PM
;Question_2

INCLUDE Irvine32.inc

addRows         PROTO           

.data

menu            BYTE            "------------------============= MENU =============------------------", 13d, 10d
                BYTE            "  A - Populate the array with random numbers (-200 - 300)", 13d, 10d
                BYTE            "  B - Print the array as HEX", 13d, 10d
                BYTE            "  C - Add first two rows", 13d, 10d
                BYTE            "  D - Multiply first two rows", 13d, 10d
                BYTE            "  E - Divide first two rows", 13d, 10d
                BYTE            "  F - Print the array as normal", 13d, 10d
                BYTE            "  0 - Exit", 13d, 10d
                BYTE            "------------------================================------------------", 13d, 10d, 0

menuChoices     BYTE            'A'
                DWORD           populateArray
EntrySize       =               ($ - menuChoices)
                BYTE            'B'
                DWORD           printTableHex
                BYTE            'C'
                DWORD           addRows
                BYTE            'D'
                DWORD           mulpRows
                BYTE            'E'
                DWORD           divRows
                BYTE            'F'
                DWORD           printTable
menuSize        =               ($ - menuChoices) / EntrySize

finishPop       BYTE            "Array Populated", 13d, 10d, 0
finishMul       BYTE            "Array Multiplied", 13d, 10d, 0
finishDiv       BYTE            "Array Divided", 13d, 10d, 0
finishMod       BYTE            "Array Modulus'ed", 13d, 10d, 0

numColumns      =               5
numRows         =               6

.code
main PROC

	call    Randomize

	StartOver:

                call    printMenu
                call    menuSelection

                mov     ESI, OFFSET menuChoices
                mov     ECX, menuSize

        LoopMenu:

                cmp     AL, '0'
                JE      exitLoop

                cmp     AL, [ESI]
                JNE     continueSearch

                push    LENGTHOF array
                push    OFFSET array
                call    NEAR PTR [ESI+1]
                JMP     StartOver
                call    crlf

                continueSearch:
                        add     ESI, EntrySize

        LOOP    LoopMenu
        JMP     StartOver

        exitLoop:

        INVOKE  ExitProcess,0

	exit

main ENDP

;parameter pass by registers: ESI - offset of array, ECX - num columns, EDX - num rows.
;random numbers between -200 -> 300
;dont show array
;should work for a 6x? array
populateArray PROC   

        

populateArray ENDP

printTableHex PROC      ;Push parameters onto the stack, only use EBP, push OFFSEt of array, num columns, and num rows.

printTableHex ENDP

addRows PROC            ;INVOKE

addRows ENDP

mulpRows PROC           ;Parameter pass on stack with push, have named parameters (EQU?) and local variables, use enter and leave

mulpRows ENDP

divRows PROC            ;only parameters on the stack, only use EBP            

divRows ENDP

printTable PROC         ;Use invoke with named parameters and local variables

printTable ENDP

END main