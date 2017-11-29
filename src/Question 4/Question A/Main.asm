;Tyler Wilding
;DESKTOP-EVD5HKS
;8/2/2016 9:10:29 AM
;Question_A

INCLUDE Irvine32.inc

.data

string1         BYTE    "Moved Disk ",0
string2         BYTE    " from ",0
string3         BYTE    " to ",0


.code
main PROC

        mov     ESI, 0
        mov     EDI, 0
        mov     EBX, 0

	mov     ECX, 3
        mov     ESI, 'A'
        mov     EDI, 'B'
        mov     EBX, 'C'

        call    towers

	exit
main ENDP

;Recursive Towers of Hanoi, utilizing registers
;ECX:           Number of Disks
;ESI:           Source Disk Char                from
;EDI:           Destination Disk Char           spare
;EBX:           Spare Disk Char                 to
;Base Case:     ECX = 1
towers PROC

        cmp     ECX, 1                                                          ;If there is only one disk, print and return
        JLE     return

                                                                                ;Else
        pushad                                                                  ;We must preserve the values of the registers as they are manipulated after the call
        dec     ECX
        xchg    EDI, EBX                                                        ;Swap spare and to
        call    towers
        popad                                                                   ;Restore

        mov     EDX, OFFSET string1                                             ;Print out the movement
        call    WriteString
        mov     EAX, ECX
        call    WriteDec
        mov     EDX, OFFSET string2                                             
        call    WriteString             
        mov     EAX, ESI                                                        ;from
        call    WriteChar
        mov     EDX, OFFSET string3
        call    WriteString
        mov     EAX, EBX                                                        ;to
        call    WriteChar
        call    crlf

        pushad
        dec     ECX
        xchg    ESI, EDI                                                        ;Swap from and spare
        call    towers
        popad
        jmp     endTowers                                                       ;Skip the IF condition could probably replace with another return

        return:

                mov     EDX, OFFSET string1
                call    WriteString
                mov     EAX, ECX
                call    WriteDec
                mov     EDX, OFFSET string2
                call    WriteString
                mov     EAX, ESI                                                ;from
                call    WriteChar
                mov     EDX, OFFSET string3
                call    WriteString
                mov     EAX, EBX                                                ;to
                call    WriteChar
                call    crlf

        endTowers:
                ret
towers ENDP

END main