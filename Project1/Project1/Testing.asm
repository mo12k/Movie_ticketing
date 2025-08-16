.386
.model flat, stdcall
option casemap:none

include Irvine32.inc

.data
line1   BYTE "=====================================================",0
welcome BYTE "            Welcome to AFC Cinema",0


.code
main PROC
    call Clrscr          ; clear the console

    mov edx, OFFSET line1
    call WriteString
    call Crlf

    mov edx, OFFSET welcome
    call WriteString
    call Crlf

    mov edx, OFFSET line1
    call WriteString
    call Crlf

    call WaitMsg         ; pause so console stays open
    exit                 ; exit macro (uses Irvine32), safe
main ENDP

END main
