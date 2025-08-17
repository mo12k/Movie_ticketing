.386
.model flat, stdcall
option casemap:none

include Irvine32.inc

.data
line1       BYTE "=====================================================",0
welcome     BYTE "            Welcome to AFC Cinema",0
opt1        BYTE "1. Admin Login",0
opt2        BYTE "2. User Login",0
opt3        BYTE "3. User Register",0
opt4        BYTE "4. Exit",0
optionMsg      BYTE "Please select an option (1-4): ",0

UserOption BYTE ?       ; Variable to store user input

.code
main PROC
    call Clrscr          ; clear the console

    ; Display HEADER
    mov edx, OFFSET line1
    call WriteString
    call Crlf

    mov edx, OFFSET welcome
    call WriteString
    call Crlf

    mov edx, OFFSET line1
    call WriteString
    call Crlf
    call Crlf

    ;Options
    mov edx, OFFSET opt1
    call WriteString
    call Crlf

    mov edx, OFFSET opt2
    call WriteString
    call Crlf

    mov edx, OFFSET opt3
    call WriteString
    call Crlf
    
    mov edx, OFFSET opt4
    call WriteString
    call Crlf
    call Crlf

    ; Prompt for user input
    mov edx, OFFSET optionMsg   
    call WriteString

    call ReadChar       ; read user input
    mov UserOption, al  ; store the user input in UserOption
    call WriteChar      ; echo the input back to the console
    call Crlf
    
    call WaitMsg         ; pause so console stays open
    exit                 ; exit macro (uses Irvine32), safe
main ENDP

END main
