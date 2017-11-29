;Tyler Wilding
;DESKTOP-EVD5HKS
;8/18/2016 9:11:04 AM
;Question_1

INCLUDE Irvine32.inc

MergeString     PROTO   str1:DWORD, str2:DWORD, str3:DWORD, str1Length:DWORD, str2Length:DWORD

.data

prompt1         BYTE    "Enter the first String ",0
prompt2         BYTE    "Enter the second String ",0

charsLeft       DWORD   250
charsLeftStr    BYTE    " Chars Left): ",0

string1         BYTE    251 DUP (?)                             ;Needs to be one spot bigger to hold the nullterminator
string2         BYTE    251 DUP (?)

string3         BYTE    251 DUP (?)

outputMsg       BYTE    "Merged String 1 and String 2: ",0
outputMsg2      BYTE    "Merged String 2 and String 1: ",0

.code
main PROC

	mov     EDX, OFFSET prompt1
        call    WriteString
        mov     AL, '('
        call    WriteChar
        mov     EAX, charsLeft
        call    WriteDec
        mov     EDX, OFFSET charsLeftStr
        call    WriteString

        mov     EDX, OFFSET string1
        mov     ECX, LENGTHOF string1 - 1                       ;todo, add the characters left to the prompt
        call    ReadString
        sub     charsLeft, EAX
        xchg    EAX, EBX

        mov     EDX, OFFSET prompt2
        call    WriteString
        mov     AL, '('
        call    WriteChar
        mov     EAX, charsLeft
        call    WriteDec
        mov     EDX, OFFSET charsLeftStr
        call    WriteString

        mov     EDX, OFFSET string2
        mov     ECX, LENGTHOF string1 - 1
        sub     ECX, EBX                                        ;Limit the length of the second string, so a maximum of 250 characters cannot be exceeded.
        call    ReadString
        xchg    EAX, EBX

        INVOKE  MergeString, ADDR string1, ADDR string2, ADDR string3, EAX, EBX

        mov     EDX, OFFSET outputMsg
        call    WriteString
        mov     EDX, OFFSET string3
        call    WriteString
        call    crlf

        INVOKE  MergeString, ADDR string2, ADDR string1, ADDR string3, EAX, EBX

        mov     EDX, OFFSET outputMsg
        call    WriteString
        mov     EDX, OFFSET string3
        call    WriteString
        call    crlf

	exit
main ENDP

MergeString PROC, str1:DWORD, str2:DWORD, str3:DWORD, str1Length:DWORD, str2Length:DWORD
        LOCAL tempArray[250]:BYTE

        push    EAX
        push    EBX

        push    str1Length
        push    str2Length

        LEA     EDI, tempArray

        ;Both strings have characters left

        BothStrings:                                       ;Cant use only string pimritives, as we cant use rep.
                
                mov     ESI, str1
                mov     AL, [ESI]
                cmp     AL, 0
                JZ      onlyString2HasCharacters
                movsb   
                
                inc     str1
                dec     str1Length

                mov     ESI, str2
                mov     AL, [ESI]
                cmp     AL, 0
                JZ      onlyString1HasCharacters
                movsb

                inc     str2
                dec     str2Length

        JMP BothStrings


        ;Only string 1 has characters left                                                           
                                                                                                     
        onlyString1HasCharacters:                                                                    
                                                                                                     
                mov     ESI, str1                                                                    
                mov     ECX, str1Length                                                              
                cld                                                                                  
                rep     movsb                                                                        
                JMP     copyStringToDestination                                                      
                                                                                                     
        ;Only string 2 has characters left                                                           
                                                                                                     
        onlyString2HasCharacters:                                                                    
                                                                                                     
                mov     ESI, str2                                                                    
                mov     ECX, str2Length                                                              
                cld                                                                                  
                rep     movsb                                                                        
                                                                                                     
        ;Copy to final string. repne movsb                                                           
                                                                                                     
        copyStringToDestination:                                                                     
                                                                                                     
                pop     ECX                                                                          
                pop     EBX                                                                          
                add     ECX, EBX                                                                     
                                                                                                     
                mov     EDI, str3                                                                    
                LEA     ESI, tempArray                                                               
                cld                                                                                  
                rep     movsb                                                                        
                                                                                                     
                mov     EAX, 0                                                                       
                mov     [ESI], EAX                                                                   
                                                                                                     
        pop EBX                                                                                      
        pop EAX                                                                                      

        ret

MergeString ENDP

END main