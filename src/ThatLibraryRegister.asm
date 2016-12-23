;Written by Tyler Wilding
;ThatLibraryRegister

INCLUDE Irvine32.inc

.data

numberFormat    BYTE    ") ",9d,0                               ;9d = TAB

.code
main PROC

        call Randomize                                          ;So we get unique numbers each time

        mov ECX, 10     
        
        FindGrades:
                
                mov EBX, 50                                     ;Make the random number
                mov EAX, 100
                call BetterRandomRange
                call WriteDec

                mov EDX, OFFSET numberFormat
                call WriteString
                
                mov AH, AL                                      ;Result is in AL, move it over for the procedure

                call CalcGrade
                call WriteChar

                call crlf

        loop FindGrades

	exit
main ENDP

;Returns a capital letter matching the respective grade given and integer between 0 and 100
;Integer:               AH
;Grade Letter:          AL
;Dependencies:          AX
;Result                 Stored in AL, ASCII value of character
CalcGrade PROC

        cmp AH, 0                                       ;If the grade given is less than 0 or greater than 100, end.
        JL InvalidGrade
        
        cmp AH, 100
        JG InvalidGrade

        cmp AH, 59                                      ;See if it is lower than 59
        JG GradeD
                mov AL, 'F'                             ;Move F to AL (AL is used for WriteChar)
                jmp ReturnGrade

        GradeD:
        cmp AH, 69                                      ;See if it is lower than 69
        JG GradeC
                mov AL, 'D'
                jmp ReturnGrade

        GradeC:
        cmp AH, 79                                      ;See if it is lower than 79
        JG GradeB
                mov AL, 'C'
                jmp ReturnGrade

        GradeB:
        cmp AH, 89                                      ;See if it is lower than 89
        JG GradeA
                mov AL, 'B'
                jmp ReturnGrade
        
        GradeA:                                         ;Else it's a A
                mov AL, 'A'
                jmp ReturnGrade

        InvalidGrade:
                mov AL, 'X'
                jmp ReturnGrade

        ReturnGrade:
                ret
CalcGrade ENDP

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
