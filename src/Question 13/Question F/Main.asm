;Tyler Wilding
;DESKTOP-EVD5HKS
;8/9/2016 8:37:39 AM
;Question_F

;Challenge: Using only SAR, ADD, and XOR instructions (but no conditional jumps), write
;code that calculates the absolute value of the signed integer in the EAX register. Hints: A
;number can be negated by adding ?1 to it and then forming its one’s complement. Also, if
;you XOR an integer with all 1s, its 1s are reversed. On the other hand, if you XOR an inte-
;ger with all zeros, the integer is unchanged.

;r = (v + mask) ^ mask;

INCLUDE Irvine32.inc

.data

.code
main PROC

        mov     EAX, -5

        xor     EBX, EBX
        add     EBX, EAX
        sar     EBX, 32 - 1

        add     EAX, EBX
        xor     EAX, EBX

	exit
main ENDP

END main