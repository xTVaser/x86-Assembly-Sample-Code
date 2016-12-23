;Written by Tyler Wilding
;EncryptionPlainDecrypt

INCLUDE Irvine32.inc

.data

sPrompt         BYTE    "Enter the plain text:",0
sEncrypt        BYTE    "Cipher text: ",0
sDecrypt        BYTE    "Decrypted: ",0
buffer          BYTE    BUFMAX+1 DUP(0)
bufSize         DWORD   ?

.code
main PROC

	call InputTheString ; input the plain text
        call TranslateBuffer ; encrypt the buffer
        mov edx,OFFSET sEncrypt ; display encrypted message
        call DisplayMessage
        call TranslateBuffer ; decrypt the buffer
        mov edx,OFFSET sDecrypt ; display decrypted message
        call DisplayMessage

	exit
main ENDP

;-----------------------------------------------------
; Prompts user for a plaintext string. Saves the string
; and its length.
; Receives: nothing
; Returns: nothing
;-----------------------------------------------------
InputTheString PROC

        pushad ; save 32-bit registers
        mov edx,OFFSET sPrompt ; display a prompt
        call WriteString
        mov ecx,BUFMAX ; maximum character count
        mov edx,OFFSET buffer ; point to the buffer
        call ReadString ; input the string
        mov bufSize,eax ; save the length
        call Crlf
        popad
        ret

InputTheString ENDP

;-----------------------------------------------------
; Displays the encrypted or decrypted message.
; Receives: EDX points to the message
; Returns: nothing
;-----------------------------------------------------
DisplayMessage PROC

        pushad
        call WriteString
        mov edx,OFFSET buffer ; display the buffer
        call WriteString
        call Crlf
        call Crlf
        popad
        ret

DisplayMessage ENDP

;-----------------------------------------------------
; Translates the string by exclusive-ORing each
; byte with the encryption key byte.
; Receives: nothing
; Returns: nothing
;-----------------------------------------------------
TranslateBuffer PROC

        pushad
        mov ecx,bufSize ; loop counter
        mov esi,0 ; index 0 in buffer
        L1:
        xor buffer[esi],KEY ; translate a byte
        inc esi ; point to next byte
        loop L1
        popad
        ret

TranslateBuffer ENDP

END main
