Include Irvine32.inc

.data

	;Home page part
	banner BYTE "=================================================================================",0Dh,0Ah
		   BYTE "__        __   _                            _             _    _____ ____ ",0Dh,0Ah
		   BYTE "\ \      / /__| | ___ ___  _ __ ___   ___  | |_ ___      / \  |  ___/ ___|",0Dh,0Ah
		   BYTE " \ \ /\ / / _ \ |/ __/ _ \| '_ ` _ \ / _ \ | __/ _ \    / _ \ | |_ | |    ",0Dh,0Ah
		   BYTE "  \ V  V /  __/ | (_| (_) | | | | | |  __/ | || (_) |  / ___ \|  _|| |___ ",0Dh,0Ah
		   BYTE "  _\_/\_/ \___|_|\___\___/|_| |_| |_|\___|  \__\___/  /_/   \_\_|   \____|",0Dh,0Ah
		   BYTE " / ___(_)_ __   ___ _ __ ___   __ _                                       ",0Dh,0Ah
		   BYTE "| |   | | '_ \ / _ \ '_ ` _ \ / _` |                                      ",0Dh,0Ah
		   BYTE "| |___| | | | |  __/ | | | | | (_| |                                      ",0Dh,0Ah
		   BYTE " \____|_|_| |_|\___|_| |_| |_|\__,_|                                      ",0Dh,0Ah
		   BYTE "=================================================================================",0Dh,0Ah,0


	
    mainMenuMsg     BYTE 0dh, 0ah, "MAIN MENU:", 0dh, 0ah
                    BYTE "1. Admin Login", 0dh, 0ah
                    BYTE "2. User Login", 0dh, 0ah
                    BYTE "3. User Registration", 0dh, 0ah
                    BYTE "4. Exit", 0dh, 0ah
                    BYTE "Please select an option (1-4): ", 0


	menuChoice BYTE ?       ; Variable to store user input

	;Login messages
    adminLoginHeader BYTE 0dh, 0ah, "=== ADMIN LOGIN ===", 0dh, 0ah, 0
    userLoginHeader  BYTE 0dh, 0ah, "=== USER LOGIN ===", 0dh, 0ah, 0
    usernamePrompt   BYTE "Username: ", 0
    passwordPrompt   BYTE "Password: ", 0

	;Success messages
    adminLoginSuccess BYTE 0dh, 0ah, "Admin login successful! Welcome, Administrator.", 0dh, 0ah, 0
    userLoginSuccess  BYTE 0dh, 0ah, "User login successful! Welcome, User.", 0dh, 0ah, 0

	;Failure messages
    loginFailed     BYTE 0dh, 0ah, "Login failed! Invalid username or password.", 0dh, 0ah, 0
    maxAttemptsMsg  BYTE "Maximum login attempts exceeded. Access denied.", 0dh, 0ah, 0

	;Other messages
	exitMsg         BYTE 0dh, 0ah, "Exiting the program. Goodbye!", 0dh, 0ah, 0
	InvalidChoice   BYTE 0dh, 0ah, "Invalid choice. Please select a valid option.", 0dh, 0ah, 0
	continueMsg     BYTE 0dh, 0ah, "Press any key to return to main menu...", 0dh, 0ah, 0
	emptyInputMsg     BYTE 0dh, 0ah, "Input cannot be empty. Please try again.", 0dh, 0ah, 0

	;admin credentials
	adminUsername BYTE "admin", 0
	adminPassword BYTE "@96iT2", 0

	;Input buffers for credentials
	inputUsername BYTE 50 DUP(0) ; Buffer for username input
	inputPassword BYTE 50 DUP(0) ; Buffer for password input

	;Attempt counter
	attempts DWORD 0
	maxAttempts DWORD 3 


.code
main PROC
	call MainMenuSystem
	; Further processing based on user choice can be added here
	exit
main ENDP

MainMenuSystem PROC
	;Display banner and main menu
	call Clrscr
	mov edx, OFFSET banner
	call WriteString


MainMenuStart:
	mov edx, OFFSET mainMenuMsg
	call WriteString
	call ReadChar
	mov menuChoice, al
	call WriteChar 
	call Crlf

	;Process user choice
	cmp menuChoice, '1'
	je AdminLoginOption
	cmp menuChoice, '2'
	je UserLoginOption
	cmp menuChoice, '3'
	je UserRegistrationOption
	cmp menuChoice, '4'
	je ExitOption

	;Invalid choice handling
	mov edx, OFFSET InvalidChoice
	call WriteString
	jmp MainMenuStart

AdminLoginOption:
	call AdminLogin
	jmp MainMenuStart

UserLoginOption:
	call UserLogin
	jmp MainMenuStart

UserRegistrationOption:
	; Placeholder for user registration functionality
	mov edx, OFFSET InvalidChoice
	call WriteString
	jmp MainMenuStart

ExitOption:
	mov edx, OFFSET exitMsg
	call WriteString
	ret
MainMenuSystem ENDP

;Admin login function
AdminLogin PROC
	mov edx, OFFSET adminLoginHeader
	call WriteString

	;Reset attempt counter
	mov attempts, 0  

AdminLoginLoop:
	mov eax, attempts
	cmp eax, maxAttempts
	jge AdminLoginFailed

	call GetCredentials
	mov esi, OFFSET inputUsername
	call IsEmptyString
	cmp eax, 1
	je EmptyInput

	mov esi, OFFSET inputPassword
	call IsEmptyString
	cmp eax, 1
	je EmptyInput

	;Validate admin credentials
	mov esi, OFFSET adminUsername
	mov edi, OFFSET adminPassword
	call ValidateLogin
	cmp eax, 1
	je AdminLoginSuccessful

	;Login failed
	mov edx, OFFSET loginFailed
	call WriteString
	inc attempts

	;Check if max attempts reached
	mov eax, attempts
	cmp eax, maxAttempts
	jl AdminLoginLoop
	jmp AdminLoginFailed

EmptyInput:
	mov edx, OFFSET emptyInputMsg
	call WriteString
	inc attempts
	jmp AdminLoginLoop

AdminLoginFailed:
	mov edx, OFFSET maxAttemptsMsg
	call WriteString
	jmp AdminLoginEnd

AdminLoginSuccessful:
	mov edx, OFFSET adminLoginSuccess
	call WriteString

AdminLoginEnd:
	mov edx, OFFSET continueMsg
	call WriteString
	call ReadChar
	ret
AdminLogin ENDP

;User login function
UserLogin PROC
	mov edx, OFFSET userLoginHeader
	call WriteString

	;Reset attempt counter
	mov attempts, 0

UserLoginLoop:
	mov eax, attempts
	cmp eax, maxAttempts
	jge UserLoginFailed

	call GetCredentials

	;Validate user credentials 
	mov esi, OFFSET adminUsername
	mov edi, OFFSET adminPassword
	call ValidateLogin
	cmp eax, 1
	je UserLoginSuccessful

	;Login failed
	mov edx, OFFSET loginFailed
	call WriteString
	inc attempts

	;Check if max attempts reached
	mov eax, attempts
	cmp eax, maxAttempts
	jl UserLoginLoop

UserLoginFailed:
	mov edx, OFFSET maxAttemptsMsg
	call WriteString
	jmp UserLoginEnd

UserLoginSuccessful:
	mov edx, OFFSET userLoginSuccess
	call WriteString

UserLoginEnd:
	mov edx, OFFSET continueMsg
	call WriteString
	call ReadChar
	ret
UserLogin ENDP

; Function to get username and password
GetCredentials PROC
	;Clear buffers
	mov edi, OFFSET inputUsername
	mov ecx, 50
	mov al, 0
	rep stosb

	mov edi, OFFSET inputPassword
	mov ecx, 50
	mov al, 0
	rep stosb

	;Get username
	call Crlf
	mov edx, OFFSET usernamePrompt
	call WriteString
	mov edx, OFFSET inputUsername
	mov ecx, 49
	call ReadString

	;Get password
	mov edx, OFFSET passwordPrompt
	call WriteString
	mov edx, OFFSET inputPassword
	mov ecx, 49
	call ReadString

	ret
GetCredentials ENDP

;Validate login function
;Parameter ESI = expected username, EDI = expected password
;Returns EAX = 1 if valid, 0 if invalid
ValidateLogin PROC
	push esi
	push edi

	;Compare usernames
	mov eax, esi
	mov esi, OFFSET inputUsername
	mov edi,eax
	call CompareStrings
	cmp eax, 0
	jne InvalidLogin

	;Compare passwords
	pop edi		;get expected password
	pop esi		;clean stack
	push edi    ;save expected password
	mov esi, OFFSET inputPassword
	call CompareStrings
	cmp eax, 0
	jne InvalidLogin

	;Both username and password match
	mov eax, 1
	pop edi
	ret

InvalidLogin:
	mov eax, 0
	pop edi
	ret
ValidateLogin ENDP

;Compare two null-terminated strings
;ESI = string1, EDI = string2
;Returns EAX = 0 if equal, non-zero if not equal
CompareStrings PROC
	push esi
	push edi
	push ebx

	CompareLoop:
		mov al, [esi]
		mov bl, [edi]
		cmp al, bl
		jne StringsNotEqual

		;Check if we reached the end of both strings
		cmp al, 0
		je StringsEqual

		inc esi
		inc edi
		jmp CompareLoop

StringsEqual:
		mov eax, 0
		jmp CompareExit

StringsNotEqual:
		mov eax, 1

CompareExit:
		pop ebx
		pop edi
		pop esi
		ret
CompareStrings ENDP	

;Check if a string is empty
;Output: EAX = 1 if empty, 0 if not
IsEmptyString PROC
	mov al,BYTE PTR [esi]  ; Load first character
	cmp al,0
	je Empty
	mov eax,0   ; Not empty
	ret
Empty:
	mov eax,1   ; Is empty
	ret
IsEmptyString ENDP
END main