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
usernames         BYTE "user1", 16 dup(0)           ; Pre-defined username
                  BYTE "user2", 16 dup(0)           ; Pre-defined username  
                  BYTE (MAX_USERS-2) *(MAX_USERNAME_LEN +1) DUP(0)  ; Remaining slots

passwords         BYTE "pass1", 16 dup(0)           ; Password for user1
                  BYTE "pass2", 16 dup(0)           ; Password for user2
                  BYTE (MAX_USERS-2) *(MAX_PASSWORD_LEN +1) DUP(0)  ; Remaining slots
                  
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
InvalidChoice   BYTE "Invalid choice. Please select a valid option.",0
TriedAttempt  BYTE "Too many failed attempts. Returning to main menu.",0

;attempt counter
attempt 		DWORD 0 ; Counter for login attempts
maxAttempts 	DWORD 3 ; Maximum allowed login attempts

debugMsg1      BYTE "DEBUG: Entered Username: ",0
debugMsg2      BYTE "DEBUG: Entered Password: ",0

.code
main PROC
    call Clrscr          ; clear the console
    call Menu           ; call the menu procedure

    call WaitMsg         ; pause so console stays open
    exit                 ; exit macro (uses Irvine32), safe
main ENDP

Menu proc
    ; Display the main menu options
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

    call ReadChar      ; read a single character input
    call WriteChar    
    call Crlf
    
    ; Process user input
    cmp al, '1'  ; check if the input is '1'
    je AdminLogin

    cmp al, '2'
    je UserLogin

    cmp al, '3'
    je UserRegister

    cmp al, '4'
    je ExitProgram

    ;If input is invalid, show error and return to menu
    call Crlf
    mov edx, OFFSET InvalidChoice
    call WriteString
    call Crlf
    jmp Menu           ; Return to the menu for another attempt

    ret
Menu endp


AdminLogin proc
    call Clrscr
    mov attempt, 0  ; Reset attempt counter

    CheckAttempts:
        mov eax, attempt
        cmp eax, maxAttempts
        jae TooManyAttempts

        ;-- Username --
        mov edx, OFFSET promptUsername
        call WriteString
        mov edx, OFFSET inputAdminUsername
        mov ecx, SIZEOF inputAdminUsername
        call ReadString
        mov edx, OFFSET inputAdminUsername
        call TrimCR

        mov al, [inputAdminUsername]
        cmp al, 0
        je LoginFailed

        ;-- Password --
        mov edx, OFFSET promptPassword
        call WriteString
        mov edx, OFFSET inputAdminPassword
        mov ecx, SIZEOF inputAdminPassword
        call ReadString
        mov edx, OFFSET inputAdminPassword
        call TrimCR

        mov al, [inputAdminPassword]
        cmp al, 0
        je LoginFailed

        ;-- DEBUG: Show what was entered --
        mov edx, OFFSET debugMsg1
        call WriteString
        mov edx, OFFSET inputAdminUsername
        call WriteString
        call Crlf
        
        mov edx, OFFSET debugMsg2
        call WriteString
        mov edx, OFFSET inputAdminPassword
        call WriteString
        call Crlf


        ;-- Validate Credentials --
        mov esi, OFFSET inputAdminUsername
        mov edi, OFFSET AdminUsername
        call Str_compare
        cmp eax, 0
        jne LoginFailed

        mov esi, OFFSET inputAdminPassword
        mov edi, OFFSET AdminPassword
        call Str_compare
        cmp eax, 0
        jne LoginFailed


    LoginSuccess:
        mov attempt, 0
        mov edx, OFFSET loginSuccess
        call WriteString
        call Crlf
        call AdminMenu
        jmp EndLogin

    LoginFailed:
        inc attempt
        mov edx, OFFSET loginFail
        call WriteString
        call Crlf
        jmp CheckAttempts

    TooManyAttempts:
        mov attempt, 0
        mov edx, OFFSET TriedAttempt
        call WriteString
        call Crlf
        call WaitMsg
        call Clrscr
        call Menu

    EndLogin:
        ret
    AdminLogin ENDP


UserLogin PROC
    ret
    UserLogin ENDP


UserRegister proc
    ret
    UserRegister ENDP
    
AdminMenu proc
    ; Display admin menu options
    mov edx, OFFSET line1
    call WriteString
    call Crlf
    ret
    AdminMenu endp

ExitProgram proc
    exit
    ExitProgram endp

TrimCR PROC
    mov esi, edx        ; EDX = buffer from ReadString
FindEnd:
    mov al, [esi]
    cmp al, 0
    je CheckPrev
    inc esi
    jmp FindEnd
CheckPrev:
    dec esi
    cmp byte ptr [esi], 0Dh
    jne Done
    mov byte ptr [esi], 0
Done:
    ret
TrimCR ENDP


END main
