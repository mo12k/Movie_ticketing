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
	inputUsername BYTE 20 DUP(0) ; Buffer for username input
	inputPassword BYTE 20 DUP(0) ; Buffer for password input

	;Attempt counter
	attempts DWORD 0
	maxAttempts DWORD 3

.code
main PROC
	; Display banner
	call Clrscr
	call MainMenu
	; Further processing based on user choice can be added here
	exit
main ENDP

MainMenu PROC
	call Clrscr

	
MainMenuLoop:
	mov edx, OFFSET banner
	call WriteString
	mov edx, OFFSET mainMenuMsg
	call WriteString
	call ReadChar
	call WriteChar
	call CrLf

	cmp al, '1'
	je AdminLoginOption
	cmp al, '2'
	je UserLoginOption
	cmp al, '3'
	je UserRegOption
	cmp al, '4'
	je ExitProgram

	; Invalid choice handling
	mov edx, OFFSET InvalidChoice
	call WriteString
	jmp MainMenuLoop

AdminLoginOption:
	call AdminLogin
	jmp MainMenuLoop

UserLoginOption:
	call UserLogin
	jmp MainMenuLoop

UserRegOption:
	mov edx, OFFSET InvalidChoice
	call WriteString
	jmp MainMenuLoop

ExitProgram:
	mov edx, OFFSET exitMsg
	call WriteString
	ret

MainMenu ENDP

;Admin login procedure
AdminLogin PROC
	mov edx, OFFSET adminLoginHeader
	call WriteString
	mov attempts, 0

AdminLoginLoop:
	mov eax, attempts
	cmp eax, maxAttempts
	jge AdminLoginFailed

	call GetCredentials

	; Check for empty inputs
	mov esi, OFFSET inputUsername
	call IsEmptyString
	cmp eax, 1
	je EmptyInputAdmin

	mov esi, OFFSET inputPassword
	call IsEmptyString
	cmp eax, 1
	je EmptyInputAdmin

	; Compare with admin credentials
	call ValidateAdminCredentials ;returns 1 if match, 0 if not
	cmp eax, 1 
	je AdminLoginSuccessful

	;Login failed
	inc attempts
	mov edx, OFFSET loginFailed
	call WriteString
	

	;Check if max attempts reached
	mov eax, attempts
	cmp eax, maxAttempts
	jl AdminLoginLoop
	jmp AdminLoginEnd

EmptyInputAdmin:
	mov edx, OFFSET emptyInputMsg
	call WriteString
	jmp AdminLoginLoop

AdminLoginSuccessful:
	mov edx, OFFSET adminLoginSuccess
	call WriteString

AdminLoginFailed:
	mov edx, OFFSET maxAttemptsMsg
	call WriteString
	

AdminLoginEnd:
	mov edx, OFFSET continueMsg
	call WriteString
	call ReadChar
	call Clrscr
	ret
AdminLogin ENDP

UserLogin PROC
	mov edx, OFFSET userLoginHeader
	call WriteString
	; Reset attempt counter
	mov attempts, 0

UserLogin ENDP

GetCredentials PROC
	;Clear input buffers
	mov ecx, 20
	mov esi, OFFSET inputUsername
	call ClearBuffer

	mov ecx, 20
	mov esi, OFFSET inputPassword
	call ClearBuffer

	;-- Username --
	call Crlf
	mov edx, OFFSET usernamePrompt
	call WriteString
	mov edx, OFFSET inputUsername
	mov ecx, SIZEOF inputUsername
	call ReadString

	;-- Password --
	mov edx, OFFSET passwordPrompt
	call WriteString
	mov edx, OFFSET inputPassword
	mov ecx, SIZEOF inputPassword
	call ReadString
	ret
GetCredentials ENDP

ValidateAdminCredentials PROC
	;Compare username
	mov esi, OFFSET inputUsername
	mov edi, OFFSET adminUsername
	call CompareAdmin
	cmp eax,0
	jne NotMatchAdmin

	;Compare password
	mov esi, OFFSET inputPassword
	mov edi, OFFSET adminPassword
	call CompareAdmin
	cmp eax,0
	jne NotMatchAdmin

	;Both match - return 1
	mov eax,1
	ret

NotMatchAdmin:
	mov eax,0
	ret
ValidateAdminCredentials ENDP

CompareAdmin PROC
	; Compares two null-terminated strings
	;ESI = first string, EDI = second string
	; Returns 0 if equal, non-zero if not
	push ebx
	push ecx

CompareLoop:
	mov al, [esi]
	mov bl, [edi]
	cmp al, bl
	jne NotEqualAdmin

	cmp al, 0
	je EqualAdmin
	inc esi
	inc edi
	jmp CompareLoop

NotEqualAdmin:
	mov eax, 1
	jmp CompareEndAdmin
	

EqualAdmin:
	mov eax, 0

CompareEndAdmin:
	pop ecx
	pop ebx
	ret

CompareAdmin ENDP

IsEmptyString PROC
	push ebx

	mov al, BYTE PTR [esi]
	cmp al, 0
	je IsEmpty
	cmp al, 20h
	je IsEmpty
	cmp al, 09h
	je IsEmpty

	; Not empty
	mov eax, 0
	jmp IsEmptyEnd

IsEmpty:
	mov eax, 1

IsEmptyEnd:
	pop ebx
	ret
IsEmptyString ENDP

ClearBuffer PROC
	;Input: ESI = buffer, ECX = size
	push eax
	push edi
	push ecx

	mov edi, esi
	mov al, 0
	rep stosb

	pop ecx
	pop edi
	pop eax
	ret

ClearBuffer ENDP
End main
