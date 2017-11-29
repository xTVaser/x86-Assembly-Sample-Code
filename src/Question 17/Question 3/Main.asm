;Tyler Wilding
;DESKTOP-EVD5HKS
;8/11/2016 5:34:23 PM
;Question_3

;Write a procedure that receives a single-precision floating-point binary value and displays it in
;the following format: sign: display ? or ? significand: binary floating-point, prefixed by “1.”
;552 Chapter 12 • Floating-Point Processing and Instruction Encoding
;exponent: display in decimal, unbiased, preceded by the letter E and the exponent’s sign.
;        Sample:
;        .data
;        sample REAL4 -1.75
;Displayed output:

;No idea how to test posinfinity and QNaN, but im pretty sure the bitmasking tests will work.

INCLUDE Irvine32.inc
INCLUDE Macros.inc

.data

sample          REAL4   -10.125
makeitadword    DWORD   ?

posZero         DWORD   00000000000000000000000000000000b
negZero         DWORD   10000000000000000000000000000000b
posInfinity     DWORD   01111111100000000000000000000000b 
negInfinity     DWORD   11111111100000000000000000000000b
QNaN            DWORD   01111111110000000000000000000000b
SNaN            DWORD   01111111100000000000000000000000b
SNaNLow         DWORD   00000000011111111111111111111111b      

mantissaMask    DWORD   00000000011111111111111111111111b
exponentMask    DWORD   01111111100000000000000000000000b
signMask        DWORD   10000000000000000000000000000000b

.code
main PROC

	finit
        fld     sample
        fstp    makeitadword

        mov     EAX, makeitadword
        call    WriteBin
        call    crlf
        call    testEncodings

        and     EAX, signMask
        rol     EAX, 1
        cmp     EAX, 1
        JE      negativeSign
        mov     AL, '+'
        call    WriteChar
        negativeSign:
        mov     AL, '-'
        call    WriteChar
        mWrite  "1."

        mov     EAX, makeitadword
        and     EAX, mantissaMask
        call    WriteBinBIsntEnoughForMe

        mWrite  " E"

        mov     EAX, makeitadword
        and     EAX, exponentMask
        rol     EAX, 9
        sub     EAX, 127
        call    WriteInt
        call    crlf

	exit

main ENDP

testEncodings PROC

        cmp     EAX, posZero
        JNE     test2
        mWrite  "Positive Zero"
        exit

        test2:
                cmp     EAX, negZero
                JNE     test3
                mWrite  "Negative Zero"
                exit

        test3:
                cmp     EAX, posInfinity
                JNE     test4
                mWrite  "Positive Infinity"
                exit

        test4:
                cmp     EAX, negInfinity
                JNE     test5
                mWrite  "Negative Infinity"
                exit

        test5:
                push    EAX
                and     EAX, QNaN
                cmp     EAX, QNaN
                pop     EAX
                JNE     test6
                mWrite  "QNaN"
                exit

        test6:
                push    EAX
                and     EAX, QNaN               ;This is not a mistake
                cmp     EAX, SNaN
                pop     EAX
                JNE     testsComplete
                push    EAX
                and     EAX, SNaNLow
                JZ      testsComplete
                mWrite  "SNaN"
                exit

        testsComplete:
                ret
        

testEncodings ENDP

WriteBinBIsntEnoughForMe PROC

        shl     EAX, 9
        mov     ECX, 23

        LoopMantissa:

                shl     EAX, 1
                push    EAX
                JNC     bitNotSet
                mov     AL, '1'
                JMP     printBit

                bitNotSet:
                        mov     AL, '0'

                printBit:
                        call    WriteChar
                        pop     EAX

        LOOP LoopMantissa

        ret
        
WriteBinBIsntEnoughForMe ENDP

END main