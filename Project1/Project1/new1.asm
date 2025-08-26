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
	emptyInputMsg   BYTE 0dh, 0ah, "Input cannot be empty. Please try again.", 0dh, 0ah, 0

	;admin credentials
	adminUsername BYTE "admin", 0
	adminPassword BYTE "@96iT2", 0

	;User structure constants
	MAX_USERS EQU 100
	USERNAME_SIZE EQU 20
	PASSWORD_SIZE EQU 20
	EMAIL_SIZE EQU 30
	PHONE_SIZE EQU 15

	; Size of a single user record
	USER_RECORD_SIZE EQU USERNAME_SIZE + PASSWORD_SIZE + EMAIL_SIZE + PHONE_SIZE 

	;user data storage - structured array
	userData BYTE MAX_USERS * USER_RECORD_SIZE DUP(0)

	;Predefined user data for initialization
	predefUser1 BYTE "user1", 0
	predefPass1 BYTE "pass1", 0
	predefEmail1 BYTE "user1@gmail.com",0
	predefPhone1 BYTE "0123456789",0

	predefUser2 BYTE "user2", 0
	predefPass2 BYTE "pass2", 0
	predefEmail2 BYTE "user2@gmail.com",0
	predefPhone2 BYTE "0123456987",0

	userCount DWORD 2 ; Number of predefined users
	currenUser BYTE USERNAME_SIZE DUP(0) ; Buffer for current user operations

	;Input for registration
	inputEmail BYTE EMAIL_SIZE DUP(0) 
	inputPhone BYTE PHONE_SIZE DUP(0)

	;Input buffers for credentials
	inputUsername BYTE 20 DUP(0) ; Buffer for username input
	inputPassword BYTE 20 DUP(0) ; Buffer for password input

	;Attempt counter
	attempts DWORD 0
	maxAttempts DWORD 3

.code
main PROC
	; Initialize userData with predefined users
	call InitializeUserData
	call Clrscr
	call MainMenu
	exit
main ENDP

; Initialize userData array with predefined users
InitializeUserData PROC
	push eax
	push ecx
	push esi
	push edi

	; Copy user1 data to userData[0]
	mov edi, OFFSET userData                    ; Point to first user record
	
	; Copy username
	mov esi, OFFSET predefUser1
	mov ecx, USERNAME_SIZE
	call CopyStringToBuffer
	
	; Copy password  
	add edi, USERNAME_SIZE                      ; Move to password field
	mov esi, OFFSET predefPass1
	mov ecx, PASSWORD_SIZE
	call CopyStringToBuffer
	
	; Copy email
	add edi, PASSWORD_SIZE                      ; Move to email field
	mov esi, OFFSET predefEmail1
	mov ecx, EMAIL_SIZE
	call CopyStringToBuffer
	
	; Copy phone
	add edi, EMAIL_SIZE                         ; Move to phone field
	mov esi, OFFSET predefPhone1
	mov ecx, PHONE_SIZE
	call CopyStringToBuffer

	; Copy user2 data to userData[1]
	mov edi, OFFSET userData
	add edi, USER_RECORD_SIZE                   ; Point to second user record
	
	; Copy username
	mov esi, OFFSET predefUser2
	mov ecx, USERNAME_SIZE
	call CopyStringToBuffer
	
	; Copy password
	add edi, USERNAME_SIZE
	mov esi, OFFSET predefPass2
	mov ecx, PASSWORD_SIZE
	call CopyStringToBuffer
	
	; Copy email
	add edi, PASSWORD_SIZE
	mov esi, OFFSET predefEmail2
	mov ecx, EMAIL_SIZE
	call CopyStringToBuffer
	
	; Copy phone
	add edi, EMAIL_SIZE
	mov esi, OFFSET predefPhone2
	mov ecx, PHONE_SIZE
	call CopyStringToBuffer

	pop edi
	pop esi
	pop ecx
	pop eax
	ret
InitializeUserData ENDP

; Helper procedure to copy string to buffer
CopyStringToBuffer PROC
	; ESI = source string, EDI = destination buffer, ECX = buffer size
	push eax
	push ebx
	push ecx
	push esi
	push edi
	
	; Clear the destination buffer first
	mov al, 0
	push edi
	rep stosb
	pop edi
	
	; Copy string until null terminator or buffer limit
	mov ebx, ecx                                ; Save buffer size
	dec ebx                                     ; Leave space for null terminator

CopyLoop:
	cmp ebx, 0
	je CopyDone
	mov al, [esi]
	cmp al, 0
	je CopyDone
	mov [edi], al
	inc esi
	inc edi
	dec ebx
	jmp CopyLoop

CopyDone:
	pop edi
	pop esi
	pop ecx
	pop ebx
	pop eax
	ret
CopyStringToBuffer ENDP

; Get user data by index
GetUserData PROC
	; Input: EBX = user index (0-based)
	; Output: EDI = pointer to user record
	push eax
	
	mov eax, USER_RECORD_SIZE
	mul ebx                                     ; EAX = index * record_size
	mov edi, OFFSET userData
	add edi, eax                                ; EDI points to user[index]
	
	pop eax
	ret
GetUserData ENDP

; Get specific field from user record
GetUserField PROC
	; Input: EBX = user index, EAX = field type (0=username, 1=password, 2=email, 3=phone)
	; Output: EDI = pointer to field
	push ecx
	
	call GetUserData                            ; EDI = pointer to user record
	
	cmp eax, 0
	je GetUsername
	cmp eax, 1
	je GetPassword
	cmp eax, 2
	je GetEmail
	cmp eax, 3
	je GetPhone
	jmp GetFieldEnd

GetUsername:
	; EDI already points to username (offset 0)
	jmp GetFieldEnd

GetPassword:
	add edi, USERNAME_SIZE
	jmp GetFieldEnd

GetEmail:
	add edi, USERNAME_SIZE + PASSWORD_SIZE
	jmp GetFieldEnd

GetPhone:
	add edi, USERNAME_SIZE + PASSWORD_SIZE + EMAIL_SIZE

GetFieldEnd:
	pop ecx
	ret
GetUserField ENDP

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
	mov ebx, 0		; 0 = admin login
	call PerformLogin
	jmp MainMenuLoop

UserLoginOption:
	mov ebx, 1		; 1 = user login
	call PerformLogin
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

; Combined Login Procedure (replaces AdminLogin and UserLogin)
; Input: EBX = login type (0 = admin, 1 = user)
PerformLogin PROC
	push eax
	push edx
	
	; Display appropriate header
	cmp ebx, 0
	je DisplayAdminHeader
	mov edx, OFFSET userLoginHeader
	jmp DisplayHeader
DisplayAdminHeader:
	mov edx, OFFSET adminLoginHeader
DisplayHeader:
	call WriteString
	mov attempts, 0

LoginLoop:
	mov eax, attempts
	cmp eax, maxAttempts
	jae MaxAttemptsReached		; Changed: jge to jae and renamed label

	call GetCredentials

	; Check for empty inputs
	mov esi, OFFSET inputUsername
	call IsEmptyString
	cmp eax, 1
	je EmptyInput

	mov esi, OFFSET inputPassword
	call IsEmptyString
	cmp eax, 1
	je EmptyInput

	; Validate credentials based on login type
	call ValidateCredentials	; EBX already contains login type
	cmp eax, 1 
	je LoginSuccessful

	; Login failed
	inc attempts
	mov edx, OFFSET loginFailed
	call WriteString
	
	; Check if max attempts reached
	mov eax, attempts
	cmp eax, maxAttempts
	jl LoginLoop
	jmp LoginEnd

EmptyInput:
	mov edx, OFFSET emptyInputMsg
	call WriteString
	jmp LoginLoop

LoginSuccessful:
	; Display appropriate success message
	cmp ebx, 0
	je DisplayAdminSuccess
	mov edx, OFFSET userLoginSuccess
	jmp DisplaySuccess
DisplayAdminSuccess:
	mov edx, OFFSET adminLoginSuccess
DisplaySuccess:
	call WriteString
	jmp LoginEnd

MaxAttemptsReached:		; Changed: renamed from LoginFailed
	mov edx, OFFSET maxAttemptsMsg
	call WriteString

LoginEnd:
	mov edx, OFFSET continueMsg
	call WriteString
	call ReadChar
	call Clrscr
	
	pop edx
	pop eax
	ret
PerformLogin ENDP

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

; Combined Credential Validation (replaces ValidateAdminCredentials and ValidateUserCredentials)
; Input: EBX = validation type (0 = admin, 1 = user)
; Output: EAX = 1 if valid, 0 if invalid
ValidateCredentials PROC
	push ebx
	push ecx
	push edi
	
	cmp ebx, 0
	je ValidateAdmin
	jmp ValidateUser

ValidateAdmin:
	; Compare username
	mov esi, OFFSET inputUsername
	mov edi, OFFSET adminUsername
	call CompareStrings
	cmp eax, 0
	jne CredentialsInvalid

	; Compare password
	mov esi, OFFSET inputPassword
	mov edi, OFFSET adminPassword
	call CompareStrings
	cmp eax, 0
	jne CredentialsInvalid

	; Both match
	mov eax, 1
	jmp ValidateEnd

ValidateUser:
	mov ebx, 0		; Index for users

ValidateUserLoop:
	cmp ebx, userCount
	jae CredentialsInvalid		; Changed: jge to jae

	; Get username field for current user
	mov eax, 0		; 0 = username field
	call GetUserField	; EDI = pointer to username
	
	; Compare username
	mov esi, OFFSET inputUsername
	call CompareStrings
	cmp eax, 0
	jne NextUser		; Username doesn't match
	
	; Get password field for current user
	mov eax, 1		; 1 = password field
	call GetUserField	; EDI = pointer to password
	
	; Compare password
	mov esi, OFFSET inputPassword
	call CompareStrings
	cmp eax, 0
	je CredentialsValid	; Both match!

NextUser:
	inc ebx
	jmp ValidateUserLoop

CredentialsValid:
	mov eax, 1
	jmp ValidateEnd

CredentialsInvalid:
	mov eax, 0

ValidateEnd:
	pop edi
	pop ecx
	pop ebx
	ret
ValidateCredentials ENDP

CompareStrings PROC
	; Compares two null-terminated strings
	;ESI = first string, EDI = second string
	; Returns 0 if equal, non-zero if not
	push ebx
	push ecx

CompareLoop:
	mov al, [esi]
	mov bl, [edi]
	cmp al, bl
	jne NotEqual

	cmp al, 0
	je Equal
	inc esi
	inc edi
	jmp CompareLoop

NotEqual:
	mov eax, 1
	jmp CompareEnd

Equal:
	mov eax, 0

CompareEnd:
	pop ecx
	pop ebx
	ret
CompareStrings ENDP

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