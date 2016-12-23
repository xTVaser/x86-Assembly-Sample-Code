;Written by Tyler Wilding
;DisplayRegister

INCLUDE Irvine32.inc

.data

TRUE            =       1
FALSE           =       0
gradeAverage    WORD    ?                                                                       ; test value
credits         WORD    ?                                                                       ; test value
OkToRegister    BYTE    ?      

creditsError1   BYTE    "Credits is below 1, try again",0
creditsError2   BYTE    "Credits is greater than 30, try again",0
prompt1         BYTE    "Please enter your grade average: ",0
prompt2         BYTE    "Please enter your credits: ",0

success         BYTE    "The student can register",0
failure         BYTE    "The student cannot register",0

.code
main PROC

        
        mov     EDX, OFFSET prompt1                                                             ;Ask the user for grade
        call    WriteString
        call    ReadInt

        mov     gradeAverage, AX

        UserInput:
                mov     EDX, OFFSET prompt2                                                     ;Ask the user for credits
                call    WriteString
                call    ReadInt

                mov     credits, AX
                cmp     EAX, 1
                JGE     Check30                                                                 ;Check the AND condition if >= 1

                mov     EDX, OFFSET creditsError1                                               ;If not, print the error and loop the input
                call    WriteString
                call    crlf
                JMP     UserInput

                Check30:
                        cmp     EAX, 30                                                         ;Check if its <= 30
                        JLE     BeginIF
                        
                        mov     EDX, OFFSET creditsError2                                       ;If not, print error and loop the input
                        call    WriteString
                        call    crlf
                        JMP     UserInput

        BeginIF:
        
                mov     OkToRegister, FALSE                                                     ; Begin IF

                cmp     gradeAverage, 350                                                       ;If the grade is less than 350, check the other ifs
                JLE     LessThan350
                mov     OkToRegister, TRUE

                LessThan350:                                                                    ;If greater than 250 and <= 16 credits
                        cmp     gradeAverage, 250
                        JLE     ANDFailed
                        cmp     credits, 16
                        JG      ANDFailed

                        mov     OkToRegister, TRUE

                ANDFailed:                                                                      ;Lastly, if all else fails but they have <= 12 credits, true
                        cmp     credits, 12
                        JG      exitIf
                
                        mov     OkToRegister, TRUE

        exitIf:

        cmp     OkToRegister, TRUE                                                              ;Print out result based on true or false value.
        JNE     CantRegister

        mov     EDX, OFFSET success
        call    WriteString
        call    crlf
        exit

        CantRegister:
                
                mov     EDX, OFFSET failure
                call    WriteString
                call    crlf
   
	exit
main ENDP

END main
