;Tyler Wilding
;DESKTOP-EVD5HKS
;8/11/2016 4:29:33 PM
;Question_1

;Ask the user to supply the radius and height of a regular cylinder
;and then report the Surface Area of a single end, the area of the
;side, the total surface area (both ends and the side) of the cylinder
;and the volume of the cylinder. Your program should loop until the
;value 0 is entered for the radius – and then it should promptly exit.

INCLUDE Irvine32.inc

.data

promptRadius            BYTE    "GIVE ME A RADIUS!: ",0
promptHeight            BYTE    "GIVE ME A HEIGHT!: ",0

radius                  REAL8   ?
height                  REAL8   ?
              
surfaceAreaResult       BYTE    "Cylinder's Surface Area: ",0
volumeResult            BYTE    "Cylinder's Volume: ",0

constant                DWORD   2
PI                      REAL8   3.141592654
zero                    REAL4   0.0


.code
main PROC

        LoopQuestion:

                finit

                mov     EDX, OFFSET promptRadius
                call    WriteString
                call    ReadFloat
                fcom    zero
                fnstsw  ax
                sahf
                JZ      endLoop
                fstp    radius
                
                mov     EDX, OFFSET promptHeight
                call    WriteString
                call    ReadFloat
                fstp    height

                fild    constant
                fld     PI
             
                fld     radius
                fld     radius     
                fmulp   
                fmulp
                fmulp 

                fild    constant
                fld     PI
                fld     radius
                fld     height

                fmulp
                fmulp
                fmulp

                fadd

                mov     EDX, OFFSET surfaceAreaResult
                call    WriteString
                call    WriteFloat
                call    crlf

                fld     PI
                fld     radius
                fld     radius
                fmulp
                fld     height
                fmulp
                fmulp

                mov     EDX, OFFSET volumeResult
                call    WriteString
                call    WriteFloat
                call    crlf

        JMP LoopQuestion

        endLoop:
	        exit
main ENDP

END main