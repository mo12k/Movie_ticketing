.386
.model flat, stdcall
option casemap:none

include Irvine32.inc

.data
;Home page part
line1               BYTE "=====================================================",0
welcome             BYTE "            Welcome to AFC Cinema",0
opt1                BYTE "1. Admin Login",0
opt2                BYTE "2. User Login",0
opt3                BYTE "3. User Register",0
opt4                BYTE "4. Exit",0
optionMsg           BYTE "Please select an option (1-4): ",0
UserChoiceOption    BYTE ?       ; Variable to store user input

;Constants for user storage
MAX_USERS           equ 100
MAX_USERNAME_LEN    equ 20
MAX_PASSWORD_LEN    equ 20

;User storage arrays
usernames         BYTE "user1", 16 dup(0)  ; Pre-defined username
                  BYTE "user2", 16 dup(0)  ; Pre-defined username
                  BYTE MAX_USERS *(MAX_USERNAME_LEN +1) DUP(0)
passwords         BYTE (MAX_USERS-2) *(MAX_PASSWORD_LEN +1) DUP(0)
userCount         DWORD 2 ; Initial user count (2 users pre-defined)  

;Input buffers
inputCustomerUsername  BYTE MAX_USERNAME_LEN+1 DUP(0)
inputCustomerPassword  BYTE MAX_PASSWORD_LEN+1 DUP(0)

;ADMIN part
AdminUsername   BYTE "admin",0
AdminPassword   BYTE "@96iT2",0

;Input buffers for admin
inputAdminUsername    BYTE MAX_USERNAME_LEN+1 DUP(0)
inputAdminPassword    BYTE MAX_PASSWORD_LEN+1 DUP(0)

;Messages
promptUsername   BYTE "Enter your username: ",0
promptPassword   BYTE "Enter your password: ",0
loginSuccess     BYTE "Login successful!",0
loginFail        BYTE "Login failed. Please try again.",0
regSuccess       BYTE "Registration successful!",0
userExists       BYTE "User already exists. Please choose a different username.",0

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
    mov UserChoiceOption, al  ; store the user input in UserOption
    call WriteChar      ; echo the input back to the console
    call Crlf
    

    call WaitMsg         ; pause so console stays open
    exit                 ; exit macro (uses Irvine32), safe
main ENDP

END main
