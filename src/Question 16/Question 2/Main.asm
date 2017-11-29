;Tyler Wilding
;DESKTOP-EVD5HKS
;8/11/2016 5:13:24 PM
;Question_2

;Prompt the user for each of the required values (A thru E) and present the formula along with
;the answer. Have the program loop to repeat the 5 times- collecting new numbers and
;performing the calculation again using the new numbers.

;((A + B) / C) * ((D - A) + E)

INCLUDE Irvine32.inc

.data

varA            REAL8   ?
varB            REAL8   ?
varC            REAL8   ?
varD            REAL8   ?
varE            REAL8   ?

promptA         BYTE    "Please enter a value for A: ",0
promptB         BYTE    "Please enter a value for B: ",0
promptC         BYTE    "Please enter a value for C: ",0
promptD         BYTE    "Please enter a value for D: ",0
promptE         BYTE    "Please enter a value for E: ",0

formula         BYTE    "((A + B) / C) * ((D - A) + E) = ",0

.code
main PROC

	mov     ECX, 5

        LoopFormula:

                finit

                call    collectNumbers

                fld     varA
                fld     varB
                faddp

                fld     varC
                fdivp

                fld     varA
                fld     varD
                fsubp

                fld     varE
                faddp
                fmulp

                mov     EDX, OFFSET formula
                call    WriteString
                call    WriteFloat

        LOOP LoopFormula

	exit
main ENDP

collectNumbers PROC   

        mov     EDX, OFFSET promptA
        call    WriteString
        call    ReadFloat
        fstp    varA

        mov     EDX, OFFSET promptB
        call    WriteString
        call    ReadFloat
        fstp    varB
                
        mov     EDX, OFFSET promptC
        call    WriteString
        call    ReadFloat
        fstp    varC
                
        mov     EDX, OFFSET promptD
        call    WriteString
        call    ReadFloat
        fstp    varD
                
        mov     EDX, OFFSET promptE
        call    WriteString
        call    ReadFloat   
        fstp    varE 

        ret
collectNumbers ENDP

END main