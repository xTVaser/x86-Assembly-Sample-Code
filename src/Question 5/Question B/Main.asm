;Tyler Wilding
;DESKTOP-EVD5HKS
;8/2/2016 9:48:52 AM
;Question_B

INCLUDE Irvine32.inc

.data

string          BYTE    250 DUP (?)
numLetters      DWORD   ?
prompt          BYTE    "Give me a string: ",0

newLine         BYTE    13d,10d

fileName        BYTE    "output.txt",0
fileHandle      DWORD   ?

.code
main PROC

        mov     EDX, OFFSET prompt
        call    WriteString
        
        mov     EDX, OFFSET string
        mov     ECX, LENGTHOF string - 1
        call    ReadString
        mov     numLetters, EAX

        mov     EDX, OFFSET string
        call    WriteString
        call    crlf

        mov     EDX, OFFSET fileName
        call    CreateOutputFile
        mov     fileHandle, EAX

        mov     EAX, fileHandle
        mov     EDX, OFFSET string
        mov     ECX, numLetters
        call    WriteToFile

        mov     ESI, OFFSET string
        call    edgyStringConversion

        mov     EDX, OFFSET string
        call    WriteString
        call    crlf
        
        mov     EAX, fileHandle
        mov     EDX, OFFSET newLine
        mov     ECX, 2
        call    WriteToFile

        mov     EAX, fileHandle
        mov     EDX, OFFSET string
        mov     ECX, numLetters
        call    WriteToFile

        call    CloseFile

	exit

main ENDP

edgyStringConversion PROC

        mov     ECX, numLetters
        mov     EAX, 0

        LoopString:

                cmp     BYTE PTR [ESI], 41h
                JL      nextLetter
                cmp     BYTE PTR [ESI], 5Ah
                JG      checkLowerCase                                  ;UpperCase If no jump

                inc     EAX
                TEST    EAX, 00000001b                                  ;See if even or odd
                JE      nextLetter                                      ;if result is 0, aka if eax is even

                mov     BL, BYTE PTR [ESI]
                add     BL, 32d
                mov     BYTE PTR [ESI], BL

                JMP     nextLetter

                checkLowerCase:
                
                        cmp     BYTE PTR [ESI], 61h
                        JL      nextLetter
                        cmp     BYTE PTR [ESI], 7Ah
                        JG      nextLetter                              ;LowerCase if no jump

                        inc     EAX
                        TEST    EAX, 00000001b                          
                        JNE     nextLetter                              ;If EAX is odd, we dont need to change it

                        mov     BL, BYTE PTR [ESI]
                        sub     BL, 32d
                        mov     BYTE PTR [ESI], BL
                
        nextLetter:
                
        add     ESI, TYPE BYTE
        LOOP    LoopString

        ret

edgyStringConversion ENDP
END main