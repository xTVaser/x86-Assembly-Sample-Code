;Written by Tyler Wilding
;ValuesValue

INCLUDE Irvine32.inc

.data

N		DWORD	47
array	DWORD	47 DUP (?)

.code
main PROC

	mov ESI, OFFSET array
	mov ECX, N

	call fibonacci

	exit
main ENDP

;Calculates and stores fibonacci results into a DWORD array
;Registers
;ECX				fib(n)
;ESI				Offset of array
;Returns			nil
fibonacci PROC
	
	mov EAX, 0						;First Term
	mov EBX, 1						;Second Term

	
	mov [ESI], EBX					;First value is 1
	add ESI, TYPE DWORD

	fib:
		
		add EAX, EBX				;Add, result is in EAX
		mov [ESI], EAX

		xchg EAX, EBX				;Swap EAX and EBX so the order of terms is preserved

		add ESI, TYPE DWORD
	
	LOOP fib

	ret
fibonacci ENDP
END main