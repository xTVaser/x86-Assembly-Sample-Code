;Written by Tyler Wilding
;ThatConsistent

INCLUDE Irvine32.inc

.data

varBYTE		BYTE	255								;1byte
varSBYTE	SBYTE	128								;1byte-1bit
varWORD		WORD	65535							;2bytes
varSWORD	SWORD	32768							;2bytes-1bit
varDWORD	DWORD	4294967295						;4bytes
varSDWORD	SDWORD	2147483647						;4bytes-1bit
varFWORD	FWORD	281474976710655					;6bytes
varQWORD	QWORD	18446744073709551615			;8bytes
varTBYTE	TBYTE	1208925819614629174706175		;10bytes
varREAL4	REAL4	10.10							;4byte IEEE Floating Point, Single Precision
varREAL8	REAL8	1000.10							;8byte IEEE Floating Point, Double Precision
varREAL10	REAL10	100000000.10					;10byte IEEE Floating Point, Extended Double Precision

.code
main PROC


	exit
main ENDP

END main