;Written by Tyler Wilding
;ThatSymbols

INCLUDE Irvine32.inc

.data

monday		EQU		<"Monday ",0>
tuesday		EQU		<"Tuesday ",0>
wednesday	EQU		<"Wednesday ",0>
thursday	EQU		<"Thursday ",0>
saturday	EQU		<"Saturday ",0>
sunday		EQU		<"Sunday ",0>
friday		EQU		<"Friday ",0>

days		BYTE	monday, tuesday, wednesday, thursday, friday, saturday, sunday

.code
main PROC

	mov EDX, OFFSET days
	call WriteString
	

	exit
main ENDP

END main