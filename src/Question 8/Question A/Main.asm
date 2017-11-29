;Tyler Wilding
;DESKTOP-EVD5HKS
;8/8/2016 10:43:22 AM
;Question_A

;Write a sequence of instructions that shift three memory bytes to the right by 1 bit position.
;Use the following test data:

INCLUDE Irvine32.inc

.data

byteArray       BYTE    81h,20h,33h
turnsInto       BYTE    " -> ",0

.code
main PROC

	mov     ECX, LENGTHOF byteArray
        mov     ESI, OFFSET byteArray
        mov     EDX, OFFSET turnsInto

        LoopArray:
                
                movzx   EAX, BYTE PTR [ESI]
                call    WriteDec
                call    WriteString
                shr     AL, 1
                call    WriteDec
                mov     [ESI], AL
                add     ESI, TYPE byteArray
                call    crlf

        LOOP    LoopArray

	exit
main ENDP

END main