;Tyler Wilding
;DESKTOP-EVD5HKS
;8/8/2016 10:54:32 AM
;Question_B

; Implement the following C++ expression in assembly language, using 32-bit unsigned
; operands:
;       val1 = (val2 * val3) / (val4 - 3)

INCLUDE Irvine32.inc

.data

val1            DWORD   1                       
val2            DWORD   2
val3            DWORD   3
val4            DWORD   4

quotient        BYTE    "Quotient: ",0
remainder       BYTE    "Remainder: ",0
divideByZero    BYTE    "Can't divide by zero",0

.code
main PROC

	mov     EAX, val2
        mul     val3

        mov     EBX, val4
        sub     EBX, 3
        cmp     EBX, 0
        JE      dividedByZero
        div     EBX

        push    EDX
        mov     EDX, OFFSET quotient
        call    WriteString
        call    WriteInt
        mov     val1, EAX

        call    crlf

        mov     EDX, OFFSET remainder
        call    WriteString
        pop     EAX
        call    WriteInt
        call    crlf

        exit

        dividedByZero:
                
                mov     EDX, OFFSET divideByZero
                call    WriteString
                call    crlf

	exit
main ENDP

END main