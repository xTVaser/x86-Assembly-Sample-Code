;Tyler Wilding
;DESKTOP-EVD5HKS
;8/10/2016 10:22:03 AM
;Question_1

INCLUDE Irvine32.inc

genRandomNum    PROTO, lowerBound:SDWORD, upperBound:SDWORD

.data

menu            BYTE            "------------------============= MENU =============------------------", 13d, 10d
                BYTE            "  1 - Populate the array with random numbers (user supplied range)", 13d, 10d
                BYTE            "  2 - Multiply the array with a user provided multiplier", 13d, 10d
                BYTE            "  3 - Divide the array with a user provided divisor", 13d, 10d
                BYTE            "  4 - Modulus the array with a user provided divisor", 13d, 10d
                BYTE            "  5 - Print the array", 13d, 10d
                BYTE            "  0 - Exit", 13d, 10d
                BYTE            "------------------================================------------------", 13d, 10d, 0

menuChoices     BYTE            '1'
                DWORD           populateArray
EntrySize       =               ($ - menuChoices)
                BYTE            '2'
                DWORD           multiplyArray
                BYTE            '3'
                DWORD           divideArray
                BYTE            '4'
                DWORD           modulusArray
                BYTE            '5'
                DWORD           printArray
menuSize        =               ($ - menuChoices) / EntrySize

prompt          BYTE            "Please select an option: ",0
promptHigh      BYTE            "Please enter a upperbound for the random range: ",0
promptLow       BYTE            "Please enter a lowerbound for the random range: ",0

promptMul       BYTE            "Please enter a value for the entire array to be multiplied by: ",0
promptDiv       BYTE            "Please enter a value for the entire array to be divided by: ",0
promptMod       BYTE            "Please enter a value for the entire array to be divided by and then store the remainder: ",0

finishPop       BYTE            "Array Populated", 13d, 10d, 0
finishMul       BYTE            "Array Multiplied", 13d, 10d, 0
finishDiv       BYTE            "Array Divided", 13d, 10d, 0
finishMod       BYTE            "Array Modulus'ed", 13d, 10d, 0

array           SDWORD          10 DUP (0)
             
                ;Unamed Parameter Values (Using EBP)                    DONE (In all of them)
                ;Named parameters using a parameter list                DONE (genRandomNum)
                ;local unnamed STACK variables (Using EBP)              DONE(populateArray)
                ;and local variables using LOCAL                        DONE(modulusArray, its not really needed though)
                            
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
main ENDP

populateArray PROC

        push    EDX
        push    ECX
        push    ESI
        push    EDI
        push    EAX
        push    EBX

        push    EBP
        mov     EBP, ESP

        mov     EDX, OFFSET promptLow
        call    WriteString
        call    ReadInt
        xchg    EAX, EBX
        call    crlf

        mov     EDX, OFFSET promptHigh
        call    WriteString
        call    ReadInt
        call    crlf

        sub     ESP, TYPE SDWORD * 10 
        mov     ECX, [EBP + TYPE SDWORD * 9]                    ;Length of the array on stack, bypass 6 registers, ret and ebp itself and the second paramter
        mov     EDI, [EBP + TYPE SDWORD * 8]                    ;Offset of array

        mov     ESI, EBP
        sub     ESI, TYPE SDWORD                                ;So we can fill local variables

        fillLocalRandoms:
                
                push    EAX

                INVOKE  genRandomNum, EBX, EAX                  ;Result will be in EAX
                
                mov     [ESI], EAX
                sub     ESI, TYPE SDWORD

                pop     EAX

        LOOP    fillLocalRandoms

        mov     ECX, [EBP + TYPE SDWORD * 9]

        fillArray:

                add     ESI, TYPE SDWORD
                mov     EAX, [ESI]
                mov     [EDI], EAX

                add     EDI, TYPE SDWORD

        LOOP    fillArray

        mov     EDX, OFFSET finishPop
        call    WriteString
        call    crlf

        mov     ESP, EBP
        pop     EBP

        pop     EBX
        pop     EAX
        pop     EDI
        pop     ESI
        pop     ECX
        pop     EDX          

        ret     TYPE SDWORD * 2                 ;Clean up the two parameters on the stack

populateArray ENDP

multiplyArray PROC

        push    ECX
        push    EDX
        push    EBX
        push    EAX
        push    ESI

        push    EBP
        mov     EBP, ESP

        mov     EDX, OFFSET promptMul
        call    WriteString
        call    ReadInt
        call    crlf

        xchg    EAX, EBX

        mov     ECX, [EBP + TYPE SDWORD * 8]
        mov     ESI, [EBP + TYPE SDWORD * 7]

        LoopArray:
                
                mov     EAX, [ESI]
                imul    EBX
                mov     [ESI], EAX

                add     ESI, TYPE SDWORD

        LOOP    loopArray

        mov     EDX, OFFSET finishMul
        call    WriteString
        call    crlf

        mov     ESP, EBP
        pop     EBP

        pop     ESI
        pop     EAX
        pop     EBX
        pop     EDX
        pop     ECX

        ret     TYPE SDWORD * 2

multiplyArray ENDP

divideArray PROC

        push    ECX
        push    EDX
        push    EBX
        push    EAX
        push    ESI

        push    EBP
        mov     EBP, ESP

        mov     EDX, OFFSET promptDiv
        call    WriteString
        call    ReadInt
        call    crlf

        xchg    EAX, EBX

        mov     ECX, [EBP + TYPE SDWORD * 8]
        mov     ESI, [EBP + TYPE SDWORD * 7]

        LoopArray:
                
                mov     EAX, [ESI]
                cdq
                idiv    EBX
                mov     [ESI], EAX

                add     ESI, TYPE SDWORD

        LOOP    loopArray

        mov     EDX, OFFSET finishDiv
        call    WriteString
        call    crlf

        mov     ESP, EBP
        pop     EBP

        pop     ESI
        pop     EAX
        pop     EBX
        pop     EDX
        pop     ECX

        ret     TYPE SDWORD * 2

divideArray ENDP

modulusArray PROC       
        LOCAL remainder:SDWORD

        push    ECX
        push    EDX
        push    EBX
        push    EAX
        push    ESI

        mov     EDX, OFFSET promptDiv
        call    WriteString
        call    ReadInt
        call    crlf

        xchg    EAX, EBX

        mov     ECX, [EBP + TYPE SDWORD * 3]
        mov     ESI, [EBP + TYPE SDWORD * 2]

        LoopArray:
                
                mov     EAX, [ESI]
                cdq
                idiv    EBX
                mov     remainder, EDX                  ;Woohoo, i used it
                mov     [ESI], EDX                      ;too bad i cant do memory to memory

                add     ESI, TYPE SDWORD

        LOOP    loopArray

        mov     EDX, OFFSET finishMod
        call    WriteString
        call    crlf

        pop     ESI
        pop     EAX
        pop     EBX
        pop     EDX
        pop     ECX

        ret     TYPE SDWORD * 2

modulusArray ENDP

printArray PROC

        push    ECX
        push    EDX
        push    EAX
        push    ESI

        push    EBP
        mov     EBP, ESP

        mov     ECX, [EBP + TYPE SDWORD * 7]
        mov     ESI, [EBP + TYPE SDWORD * 6]
        
        dec     ECX
        mov     AL, '{'
        call    WriteChar

        loopArray:
                
                mov     EAX, [ESI]
                call    WriteInt

                mov     AL, ','
                call    WriteChar

                add     ESI, TYPE SDWORD

        LOOP loopArray

        mov     EAX, [ESI]
        call    WriteInt

        mov     AL, '}'
        call    WriteChar

        call    crlf
        call    crlf

        
        mov     ESP, EBP
        pop     EBP

        pop     ESI
        pop     EAX
        pop     EDX
        pop     ECX

        ret     TYPE SDWORD * 2

printArray ENDP


genRandomNum PROC, lowerBound:SDWORD, upperBound:SDWORD

        inc     upperBound			;We want to include the upper bound
        mov     EAX, upperBound                 ;Upper - Lower
        sub     EAX, lowerBound		
	call    RandomRange

	add     EAX, lowerBound		        ;Rand(...) + Lower

        ret

genRandomNum ENDP

printMenu PROC

        push    EDX
        mov     EDX, OFFSET menu
        call    WriteString
        
        pop     EDX
        ret

printMenu ENDP

menuSelection PROC

        push    EDX
        mov     EDX, OFFSET prompt
        call    WriteString
        call    ReadChar
        call    crlf
        call    crlf

        pop     EDX
        ret

menuSelection ENDP

END main