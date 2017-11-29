;Tyler Wilding
;DESKTOP-EVD5HKS
;8/8/2016 11:02:59 AM
;Question_C

;Implement the following C++ expression in assembly language, using 32-bit signed
;operands:
;       val1 = (val2 / val3) * (val1 + val2)

INCLUDE Irvine32.inc

.data

val1            SDWORD   1
val2            SDWORD   6
val3            SDWORD   3

.code
main PROC

        cmp     val3, 0
        JE      divideByZero

	mov     EAX, val2
        cdq
        idiv    val3

        mov     EBX, val1
        add     EBX, val2

        imul    EBX

        call    WriteInt
        mov     val1, EAX

        divideByZero:
	exit
main ENDP

END main