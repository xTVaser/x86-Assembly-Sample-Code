;Tyler Wilding
;DESKTOP-EVD5HKS
;8/8/2016 11:48:20 AM
;Question_D

;Write a procedure that displays an unsigned 8-bit binary value in decimal format. Pass the
;binary value in AL. The input range is limited to 0 to 99, decimal. The only procedure you
;can call from the book’s link library is WriteChar. The procedure should contain approxi-
;mately eight instructions. Here is a sample call:
        ;mov al,65 ; range limit: 0 to 99
        ;call showDecimal8


INCLUDE Irvine32.inc

.data



.code
main PROC

        mov     EAX, 0
	mov     AL, 65
        call    showDecimal8

	exit
main ENDP

showDecimal8 PROC

        mov     BL, 10			
	div     BL				

	add     AH, '0'			
	add     AL, '0'			

	call    WriteChar			
	mov     AL, AH			
	call    WriteChar

        ret
showDecimal8 ENDP

END main