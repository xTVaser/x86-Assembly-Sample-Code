;Written by Tyler Wilding
;ElementsExchange

INCLUDE Irvine32.inc

.data

array DWORD 10h, 20h, 30h, 40h, 50h, 60h, 70h, 80h, 90h, 100h

.code
main PROC

	mov EAX, OFFSET array						;Debugging purposes to view the array in memory.

	mov ESI, 0									;Start at 0

	mov ECX, LENGTHOF array / 2					;Half the elements as we are moving 2 at a time

	Exchange:									;Begin Loop for Exchanging Elements

		mov EAX, array[ESI]						;Hold the first value in a temp. register
		mov EBX, array[ESI + TYPE DWORD]		;Hold the second value in a temp. register as well since we cant do memory to memory
		mov array[ESI], EBX						;2nd item into first spot
		mov array[ESI + TYPE DWORD], EAX		;1st item into second spot
		
		ADD ESI, 2 * TYPE DWORD					;Move two indexes ahead

	LOOP Exchange								;End Exchange Loop

	exit
main ENDP

END main