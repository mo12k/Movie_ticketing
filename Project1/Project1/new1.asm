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
	passwordPrompt   BYTE "Password (min 8 chars, uppercase, lowercase, number, special): ", 0

	;Registration messages
	registrationHeader BYTE 0dh, 0ah, "=== USER REGISTRATION ===", 0dh, 0ah, 0
	emailPrompt        BYTE "Email (must contain @): ", 0
	phonePrompt        BYTE "Phone (Malaysian format 01X-XXXXXXX): ", 0
	registrationSuccess BYTE 0dh, 0ah, "Registration successful! You can now login with your credentials.", 0dh, 0ah, 0
	registrationFailed  BYTE 0dh, 0ah, "Registration failed! Username already exists.", 0dh, 0ah, 0
	phoneExistsMsg      BYTE 0dh, 0ah, "Registration failed! Phone number already registered.", 0dh, 0ah, 0
	maxUsersReached     BYTE 0dh, 0ah, "Registration failed! Maximum number of users reached.", 0dh, 0ah, 0

	;Validation error messages
	passwordError BYTE 0dh, 0ah, "Password must be at least 8 characters with uppercase, lowercase, number, and special character.", 0dh, 0ah, 0
	emailError    BYTE 0dh, 0ah, "Email must contain @ symbol.", 0dh, 0ah, 0
	phoneError    BYTE 0dh, 0ah, "Phone must be Malaysian format (01X-XXXXXXX or 01XXXXXXXXX, 10-11 digits starting with 01).", 0dh, 0ah, 0

	;Success messages
	adminLoginSuccess BYTE 0dh, 0ah, "Admin login successful! Welcome, Administrator.", 0dh, 0ah, 0
	userLoginSuccess  BYTE 0dh, 0ah, "User login successful! Welcome, User.", 0dh, 0ah, 0

	;Failure messages
	loginFailed     BYTE 0dh, 0ah, "Login failed! Invalid username or password.", 0dh, 0ah, 0
	maxAttemptsMsg  BYTE "Maximum login attempts exceeded. Access denied.", 0dh, 0ah, 0

	;User portal messages
	userPortalHeader BYTE 0dh, 0ah, "=== USER PORTAL ===",0dh, 0ah,0
	portalOption1    BYTE "1. View Profile", 0dh, 0ah, 0
	portalOption2    BYTE "2. Edit Profile", 0dh, 0ah, 0
	portalOption3    BYTE "3. Booking Movie Tickets", 0dh, 0ah, 0
	portalOption4    BYTE "4. Logout", 0dh, 0ah,

	;Profile display messages
	profileHeader    BYTE 0dh, 0ah, "=== USER PROFILE ===", 0dh, 0ah, 0
	profileUsername  BYTE "Username: ", 0
	profileEmail     BYTE "Email: ", 0
	profilePhone     BYTE "Phone: ", 0
	profileNotFound  BYTE "Error: User profile not found!", 0dh, 0ah, 0
	returnToPortal   BYTE 0dh, 0ah, "Press any key to return to User Portal...", 0dh, 0ah, 0

	;Profile editing messages
	editProfileHeader BYTE 0dh, 0ah, "=== EDIT PROFILE ===", 0dh, 0ah, 0
	editOption1       BYTE "1. Edit Email", 0dh, 0ah, 0
	editOption2       BYTE "2. Edit Phone", 0dh, 0ah, 0
	editOption3       BYTE "3. Change Password", 0dh, 0ah, 0
	editOption4       BYTE "4. Back to User Portal", 0dh, 0ah, 0
	editPrompt        BYTE "Select what to edit (1-4): ", 0
	
	newEmailPrompt    BYTE "Enter new email: ", 0
	newPhonePrompt    BYTE "Enter new phone: ", 0
	currentPasswordPrompt BYTE "Enter current password: ", 0
	newPasswordPrompt BYTE "Enter new password: ", 0
	confirmPasswordPrompt BYTE "Confirm new password: ", 0
	
	updateSuccess     BYTE "Profile updated successfully!", 0dh, 0ah, 0
	updateFailed      BYTE "Profile update failed!", 0dh, 0ah, 0
	passwordMismatch  BYTE "Passwords do not match!", 0dh, 0ah, 0
	wrongPassword     BYTE "Current password is incorrect!", 0dh, 0ah, 0
	sameAsCurrentMsg  BYTE "New value is same as current value!", 0dh, 0ah, 0

	;Booking portal messages
	bookingHeader    BYTE 0dh, 0ah, "=== BOOKING MOVIE ===", 0dh, 0ah, 0
	bookingOption1   BYTE "1. 2D", 0dh, 0ah, 0
	bookingOption2   BYTE "2. IMAX", 0dh, 0ah, 0
	bookingOption3   BYTE "3. Back to User Portal", 0dh, 0ah, 0

	;Ticket type messages
	ticketTypePrompt BYTE "Select an option: ", 0
	ticketType1      BYTE "1. Standard (RM12)", 0dh, 0ah, 0
	ticketType2      BYTE "2. Premium (RM20)", 0dh, 0ah, 0
	ticketType3      BYTE "3. Couple (RM24)", 0dh,0

	;Ticket quantity messages
	ticketQtyPrompt BYTE "Enter number of tickets: ", 0
	ticketQtyError  BYTE 0dh, 0ah, "Invalid quantity. Please enter a positive number.", 0dh, 0ah, 0

	;Movie selection messages
	movieSelectPrompt BYTE "Select Movie (1-3): ", 0
	movie             BYTE "1. Tatanic", 0dh, 0ah
					  BYTE "2. Engers", 0dh, 0ah
					  BYTE "3. Avatai", 0dh, 0ah, 0


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
	currentUser BYTE USERNAME_SIZE DUP(0) ; Buffer for current logged-in user
	currentUserIndex DWORD -1 ; Index of current user in userData array

	;Input for registration and editing
	inputEmail BYTE EMAIL_SIZE DUP(0) 
	inputPhone BYTE PHONE_SIZE DUP(0)
	confirmPassword BYTE PASSWORD_SIZE DUP(0)

	;Input buffers for credentials
	inputUsername BYTE 20 DUP(0) ; Buffer for username input
	inputPassword BYTE 20 DUP(0) ; Buffer for password input

	;Attempt counter
	attempts DWORD 0
	maxAttempts DWORD 3

	; Password masking constants
	BACKSPACE_KEY EQU 8
	ENTER_KEY EQU 13

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
	call PerformRegistration
	jmp MainMenuLoop

ExitProgram:
	mov edx, OFFSET exitMsg
	call WriteString
	ret

MainMenu ENDP

; User Registration Procedure
PerformRegistration PROC
	push eax
	push ebx
	push edx
	
	; Display registration header
	mov edx, OFFSET registrationHeader
	call WriteString

RegistrationLoop:
	; Check if maximum users reached
	mov eax, userCount
	cmp eax, MAX_USERS
	jae MaxUsersError

	; Get registration input
	call GetRegistrationInput

	; Check for empty inputs
	mov esi, OFFSET inputUsername
	call IsEmptyString
	cmp eax, 1
	je EmptyRegistrationInput

	mov esi, OFFSET inputPassword
	call IsEmptyString
	cmp eax, 1
	je EmptyRegistrationInput

	mov esi, OFFSET inputEmail
	call IsEmptyString
	cmp eax, 1
	je EmptyRegistrationInput

	mov esi, OFFSET inputPhone
	call IsEmptyString
	cmp eax, 1
	je EmptyRegistrationInput

	; Validate password strength
	mov esi, OFFSET inputPassword
	call ValidatePassword
	cmp eax, 0
	je PasswordValidationFailed

	; Validate email format
	mov esi, OFFSET inputEmail
	call ValidateEmail
	cmp eax, 0
	je EmailValidationFailed

	; Validate phone number
	mov esi, OFFSET inputPhone
	call ValidatePhone
	cmp eax, 0
	je PhoneValidationFailed

	; Check if username already exists
	call CheckUsernameExists
	cmp eax, 1
	je UsernameExistsError

	; Check if phone number already exists
	call CheckPhoneExists
	cmp eax, 1
	jne AddUser
	jmp PhoneAlreadyExists

AddUser:
	; Add new user
	call AddNewUser
	cmp eax, 1
	je RegistrationSuccessful

	; Registration failed for unknown reason
	jmp RegistrationEnd

EmptyRegistrationInput:
	mov edx, OFFSET emptyInputMsg
	call WriteString
	jmp RegistrationLoop

PasswordValidationFailed:
	mov edx, OFFSET passwordError
	call WriteString
	jmp RegistrationLoop

EmailValidationFailed:
	mov edx, OFFSET emailError
	call WriteString
	jmp RegistrationLoop

PhoneValidationFailed:
	mov edx, OFFSET phoneError
	call WriteString
	jmp RegistrationLoop

MaxUsersError:
	mov edx, OFFSET maxUsersReached
	call WriteString
	jmp RegistrationEnd

UsernameExistsError:
	mov edx, OFFSET registrationFailed
	call WriteString
	jmp RegistrationLoop

PhoneAlreadyExists:
	mov edx, OFFSET phoneExistsMsg
	call WriteString
	jmp RegistrationLoop

RegistrationSuccessful:
	mov edx, OFFSET registrationSuccess
	call WriteString

RegistrationEnd:
	mov edx, OFFSET continueMsg
	call WriteString
	call ReadChar
	call Clrscr
	
	pop edx
	pop ebx
	pop eax
	ret
PerformRegistration ENDP

; Validate password strength
; Input: ESI = password string
; Output: EAX = 1 if valid, 0 if invalid
ValidatePassword PROC
	push ebx
	push ecx
	push edx
	push esi
	
	mov ecx, 0          ; Length counter
	mov ebx, 0          ; Flags: bit 0=uppercase, bit 1=lowercase, bit 2=digit, bit 3=special
	
ValidatePasswordLoop:
	mov al, [esi]
	cmp al, 0
	je CheckPasswordRequirements
	
	inc ecx             ; Increment length
	
	; Check for uppercase (A-Z)
	cmp al, 'A'
	jl CheckLowercase
	cmp al, 'Z'
	jg CheckLowercase
	or ebx, 1           ; Set uppercase flag
	jmp NextPasswordChar

CheckLowercase:
	; Check for lowercase (a-z)
	cmp al, 'a'
	jl CheckDigit
	cmp al, 'z'
	jg CheckDigit
	or ebx, 2           ; Set lowercase flag
	jmp NextPasswordChar

CheckDigit:
	; Check for digit (0-9)
	cmp al, '0'
	jl CheckSpecial
	cmp al, '9'
	jg CheckSpecial
	or ebx, 4           ; Set digit flag
	jmp NextPasswordChar

CheckSpecial:
	; Check for special characters
	cmp al, '!'
	je SetSpecialFlag
	cmp al, '@'
	je SetSpecialFlag
	cmp al, '#'
	je SetSpecialFlag
	cmp al, '$'
	je SetSpecialFlag
	cmp al, '%'
	je SetSpecialFlag
	cmp al, '^'
	je SetSpecialFlag
	cmp al, '&'
	je SetSpecialFlag
	cmp al, '*'
	je SetSpecialFlag
	cmp al, '('
	je SetSpecialFlag
	cmp al, ')'
	je SetSpecialFlag
	cmp al, '-'
	je SetSpecialFlag
	cmp al, '_'
	je SetSpecialFlag
	cmp al, '+'
	je SetSpecialFlag
	cmp al, '='
	je SetSpecialFlag
	jmp NextPasswordChar

SetSpecialFlag:
	or ebx, 8           ; Set special character flag

NextPasswordChar:
	inc esi
	jmp ValidatePasswordLoop

CheckPasswordRequirements:
	; Check minimum length (8 characters)
	cmp ecx, 8
	jl PasswordInvalid
	
	; Check all requirements are met (all 4 bits should be set)
	cmp ebx, 15         ; 15 = 1111 in binary (all flags set)
	je PasswordValid

PasswordInvalid:
	mov eax, 0
	jmp ValidatePasswordEnd

PasswordValid:
	mov eax, 1

ValidatePasswordEnd:
	pop esi
	pop edx
	pop ecx
	pop ebx
	ret
ValidatePassword ENDP

; Validate email format (must contain @)
; Input: ESI = email string
; Output: EAX = 1 if valid, 0 if invalid
ValidateEmail PROC
	push esi
	
ValidateEmailLoop:
	mov al, [esi]
	cmp al, 0
	je EmailInvalid     ; Reached end without finding @
	
	cmp al, '@'
	je EmailValid
	
	inc esi
	jmp ValidateEmailLoop

EmailValid:
	mov eax, 1
	jmp ValidateEmailEnd

EmailInvalid:
	mov eax, 0

ValidateEmailEnd:
	pop esi
	ret
ValidateEmail ENDP

; Validate Malaysian phone number format
; Input: ESI = phone string
; Output: EAX = 1 if valid, 0 if invalid
ValidatePhone PROC
	push ebx
	push ecx
	push esi
	
	mov ecx, 0          ; Length counter
	
	; Check if string is empty
	mov al, [esi]
	cmp al, 0
	je PhoneInvalid

	; Check if starts with '0'
	cmp al, '0'
	jne PhoneInvalid
	inc esi
	inc ecx

	; Check if second character is '1'
	mov al, [esi]
	cmp al, '1'
	jne PhoneInvalid
	inc esi
	inc ecx

CountDigitsLoop:
	mov al, [esi]
	cmp al, 0
	je CheckPhoneLength
	
	; Skip hyphen if present
	cmp al, '-'
	je SkipHyphen
	
	; Check if character is a digit (0-9)
	cmp al, '0'
	jl PhoneInvalid
	cmp al, '9'
	jg PhoneInvalid
	
	inc ecx
	inc esi
	jmp CountDigitsLoop

SkipHyphen:
	inc esi
	jmp CountDigitsLoop

CheckPhoneLength:
	; Malaysian phone numbers: 10-11 digits total
	cmp ecx, 10
	jl PhoneInvalid
	cmp ecx, 11
	jg PhoneInvalid

PhoneValid:
	mov eax, 1
	jmp ValidatePhoneEnd

PhoneInvalid:
	mov eax, 0

ValidatePhoneEnd:
	pop esi
	pop ecx
	pop ebx
	ret
ValidatePhone ENDP

; Check if phone number already exists (excluding current user)
; Output: EAX = 1 if exists, 0 if not
CheckPhoneExists PROC
	push ebx
	push edi
	
	mov ebx, 0		; Start from first user

CheckPhoneLoop:
	cmp ebx, userCount
	jae PhoneNotExists

	; Skip current user when editing
	cmp ebx, currentUserIndex
	je SkipCurrentUser

	; Get phone field for current user
	mov eax, 3		; 3 = phone field
	call GetUserField	; EDI = pointer to phone
	
	; Compare with input phone
	mov esi, OFFSET inputPhone
	call CompareStrings
	cmp eax, 0
	je PhoneExists

SkipCurrentUser:
	inc ebx
	jmp CheckPhoneLoop

PhoneExists:
	mov eax, 1
	jmp CheckPhoneEnd

PhoneNotExists:
	mov eax, 0

CheckPhoneEnd:
	pop edi
	pop ebx
	ret
CheckPhoneExists ENDP

; Get registration input from user
GetRegistrationInput PROC
	; Clear all input buffers
	mov ecx, USERNAME_SIZE
	mov esi, OFFSET inputUsername
	call ClearBuffer

	mov ecx, PASSWORD_SIZE
	mov esi, OFFSET inputPassword
	call ClearBuffer

	mov ecx, EMAIL_SIZE
	mov esi, OFFSET inputEmail
	call ClearBuffer

	mov ecx, PHONE_SIZE
	mov esi, OFFSET inputPhone
	call ClearBuffer

	; Get username
	call Crlf
	mov edx, OFFSET usernamePrompt
	call WriteString
	mov edx, OFFSET inputUsername
	mov ecx, USERNAME_SIZE
	call ReadString

	; Get password with masking
	mov edx, OFFSET passwordPrompt
	call WriteString
	mov edx, OFFSET inputPassword
	mov ecx, PASSWORD_SIZE
	call ReadPasswordMasked

	; Get email
	mov edx, OFFSET emailPrompt
	call WriteString
	mov edx, OFFSET inputEmail
	mov ecx, EMAIL_SIZE
	call ReadString

	; Get phone
	mov edx, OFFSET phonePrompt
	call WriteString
	mov edx, OFFSET inputPhone
	mov ecx, PHONE_SIZE
	call ReadString

	ret
GetRegistrationInput ENDP

; Check if username already exists
; Output: EAX = 1 if exists, 0 if not
CheckUsernameExists PROC
	push ebx
	push edi
	
	mov ebx, 0		; Start from first user

CheckUsernameLoop:
	cmp ebx, userCount
	jae UsernameNotExists

	; Get username field for current user
	mov eax, 0		; 0 = username field
	call GetUserField	; EDI = pointer to username
	
	; Compare with input username
	mov esi, OFFSET inputUsername
	call CompareStrings
	cmp eax, 0
	je UsernameExists

	inc ebx
	jmp CheckUsernameLoop

UsernameExists:
	mov eax, 1
	jmp CheckUsernameEnd

UsernameNotExists:
	mov eax, 0

CheckUsernameEnd:
	pop edi
	pop ebx
	ret
CheckUsernameExists ENDP

; Add new user to userData array
; Output: EAX = 1 if successful, 0 if failed
AddNewUser PROC
	push ebx
	push ecx
	push esi
	push edi
	
	; Get pointer to new user record
	mov ebx, userCount
	call GetUserData		; EDI = pointer to new user record
	
	; Copy username
	mov esi, OFFSET inputUsername
	mov ecx, USERNAME_SIZE
	call CopyStringToBuffer
	
	; Copy password
	add edi, USERNAME_SIZE
	mov esi, OFFSET inputPassword
	mov ecx, PASSWORD_SIZE
	call CopyStringToBuffer
	
	; Copy email
	add edi, PASSWORD_SIZE
	mov esi, OFFSET inputEmail
	mov ecx, EMAIL_SIZE
	call CopyStringToBuffer
	
	; Copy phone
	add edi, EMAIL_SIZE
	mov esi, OFFSET inputPhone
	mov ecx, PHONE_SIZE
	call CopyStringToBuffer
	
	; Increment user count
	inc userCount
	
	mov eax, 1		; Success
	
	pop edi
	pop esi
	pop ecx
	pop ebx
	ret
AddNewUser ENDP

; Store current user's username and index after successful login
; Input: None (uses inputUsername)
StoreCurrentUser PROC
	push eax
	push ebx
	push ecx
	push esi
	push edi
	
	; Clear current user buffer
	mov ecx, USERNAME_SIZE
	mov esi, OFFSET currentUser
	call ClearBuffer
	
	; Copy logged-in username to currentUser
	mov esi, OFFSET inputUsername
	mov edi, OFFSET currentUser
	mov ecx, USERNAME_SIZE
	call CopyStringToBuffer
	
	; Find and store user index
	mov ebx, 0		; Start from first user
	
FindUserIndexLoop:
	cmp ebx, userCount
	jae UserIndexNotFound

	; Get username field for current user
	mov eax, 0		; 0 = username field
	call GetUserField	; EDI = pointer to username
	
	; Compare with current user
	mov esi, OFFSET currentUser
	call CompareStrings
	cmp eax, 0
	je UserIndexFound
	
	inc ebx
	jmp FindUserIndexLoop

UserIndexFound:
	mov currentUserIndex, ebx
	jmp StoreCurrentUserEnd

UserIndexNotFound:
	mov currentUserIndex, -1

StoreCurrentUserEnd:
	pop edi
	pop esi
	pop ecx
	pop ebx
	pop eax
	ret
StoreCurrentUser ENDP

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
	jae MaxAttemptsReached		; Check max attempts at the beginning

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
	
	; Jump back to check attempts at the beginning of the loop
	jmp LoginLoop

EmptyInput:
	mov edx, OFFSET emptyInputMsg
	call WriteString
	jmp LoginLoop

LoginSuccessful:
	; Store current user for profile viewing (only for user login)
	cmp ebx, 1
	jne SkipStoreUser
	call StoreCurrentUser

SkipStoreUser:
	; Display appropriate success message
	cmp ebx, 0
	je DisplayAdminSuccess
	mov edx, OFFSET userLoginSuccess
	jmp DisplaySuccess
DisplayAdminSuccess:
	mov edx, OFFSET adminLoginSuccess
DisplaySuccess:
	call WriteString
	
	; Only call UserPortal for user login
	cmp ebx, 1
	jne LoginEnd
	call UserPortal
	jmp LoginEnd

MaxAttemptsReached:
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

UserPortal PROC
	push eax
	push ebx
	push edx
	push ecx
	push esi

UserPortalLoop:
	call Clrscr
	mov edx, OFFSET userPortalHeader
	call WriteString
	mov edx, OFFSET portalOption1
	call WriteString
	mov edx, OFFSET portalOption2
	call WriteString
	mov edx, OFFSET portalOption3
	call WriteString
	mov edx, OFFSET portalOption4
	call WriteString
	mov edx, OFFSET ticketTypePrompt
	call WriteString
	call ReadChar
	call WriteChar
	call CrLf
	cmp al, '1'
	je ViewProfileOption
	cmp al, '2'
	je EditProfileOption
	cmp al, '3'
	je BookingOption
	cmp al, '4'
	je LogoutOption
	; Invalid choice handling
	mov edx, OFFSET InvalidChoice
	call WriteString
	jmp UserPortalLoop

ViewProfileOption:
	; Display user profile
	call ViewUserProfile
	jmp UserPortalLoop

EditProfileOption:
	; Edit user profile
	call EditUserProfile
	jmp UserPortalLoop

BookingOption:
	call BookingPortal
	jmp UserPortalLoop

LogoutOption:
	jmp UserPortalEnd

UserPortalEnd:
	pop esi
	pop ecx
	pop edx
	pop ebx
	pop eax
	ret

UserPortal ENDP

; View user profile - displays current logged-in user's information
ViewUserProfile PROC
	push eax
	push ebx
	push edx
	push ecx
	push esi
	push edi
	
	call Clrscr
	
	; Display profile header
	mov edx, OFFSET profileHeader
	call WriteString
	
	; Use stored user index
	mov ebx, currentUserIndex
	cmp ebx, -1
	je UserNotFound

	; Display username
	mov edx, OFFSET profileUsername
	call WriteString
	mov eax, 0		; username field
	call GetUserField	; EDI = pointer to username
	mov edx, edi
	call WriteString
	call CrLf
	
	; Display email
	mov edx, OFFSET profileEmail
	call WriteString
	mov eax, 2		; email field
	call GetUserField	; EDI = pointer to email
	mov edx, edi
	call WriteString
	call CrLf
	
	; Display phone
	mov edx, OFFSET profilePhone
	call WriteString
	mov eax, 3		; phone field
	call GetUserField	; EDI = pointer to phone
	mov edx, edi
	call WriteString
	call CrLf
	
	jmp ProfileDisplayComplete

UserNotFound:
	mov edx, OFFSET profileNotFound
	call WriteString

ProfileDisplayComplete:
	mov edx, OFFSET returnToPortal
	call WriteString
	call ReadChar

	pop edi
	pop esi
	pop ecx
	pop edx
	pop ebx
	pop eax
	ret
ViewUserProfile ENDP

; Edit user profile - allows editing of email, phone, and password
EditUserProfile PROC
	push eax
	push ebx
	push edx
	push ecx
	push esi
	push edi

EditProfileLoop:
	call Clrscr
	
	; Display edit profile header
	mov edx, OFFSET editProfileHeader
	call WriteString
	mov edx, OFFSET editOption1
	call WriteString
	mov edx, OFFSET editOption2
	call WriteString
	mov edx, OFFSET editOption3
	call WriteString
	mov edx, OFFSET editOption4
	call WriteString
	mov edx, OFFSET editPrompt
	call WriteString
	
	call ReadChar
	call WriteChar
	call CrLf
	
	cmp al, '1'
	je EditEmailOption
	cmp al, '2'
	je EditPhoneOption
	cmp al, '3'
	je ChangePasswordOption
	cmp al, '4'
	je EditProfileEnd
	
	; Invalid choice
	mov edx, OFFSET InvalidChoice
	call WriteString
	jmp EditProfileLoop

EditEmailOption:
	call EditEmail
	jmp EditProfileLoop

EditPhoneOption:
	call EditPhone
	jmp EditProfileLoop

ChangePasswordOption:
	call ChangePassword
	jmp EditProfileLoop

EditProfileEnd:
	pop edi
	pop esi
	pop ecx
	pop edx
	pop ebx
	pop eax
	ret
EditUserProfile ENDP

; Edit email procedure
EditEmail PROC
	push eax
	push ebx
	push ecx
	push esi
	push edi
	
	call Clrscr
	
	; Show current email
	mov ebx, currentUserIndex
	mov edx, OFFSET profileEmail
	call WriteString
	mov eax, 2		; email field
	call GetUserField	; EDI = pointer to email
	mov edx, edi
	call WriteString
	call CrLf
	call CrLf
	
	; Get new email
	mov edx, OFFSET newEmailPrompt
	call WriteString
	mov edx, OFFSET inputEmail
	mov ecx, EMAIL_SIZE
	call ReadString
	
	; Validate new email
	mov esi, OFFSET inputEmail
	call IsEmptyString
	cmp eax, 1
	je EditEmailEnd
	
	call ValidateEmail
	cmp eax, 0
	je EmailValidationFailed
	
	; Check if same as current
	mov ebx, currentUserIndex
	mov eax, 2		; email field
	call GetUserField	; EDI = pointer to current email
	mov esi, OFFSET inputEmail
	call CompareStrings
	cmp eax, 0
	je SameEmailValue
	
	; Update email
	mov ebx, currentUserIndex
	mov eax, 2		; email field
	call GetUserField	; EDI = pointer to email
	mov esi, OFFSET inputEmail
	mov ecx, EMAIL_SIZE
	call CopyStringToBuffer
	
	mov edx, OFFSET updateSuccess
	call WriteString
	jmp EditEmailEnd

EmailValidationFailed:
	mov edx, OFFSET emailError
	call WriteString
	jmp EditEmailEnd

SameEmailValue:
	mov edx, OFFSET sameAsCurrentMsg
	call WriteString

EditEmailEnd:
	mov edx, OFFSET returnToPortal
	call WriteString
	call ReadChar
	
	pop edi
	pop esi
	pop ecx
	pop ebx
	pop eax
	ret
EditEmail ENDP

; Edit phone procedure
EditPhone PROC
	push eax
	push ebx
	push ecx
	push esi
	push edi
	
	call Clrscr
	
	; Show current phone
	mov ebx, currentUserIndex
	mov edx, OFFSET profilePhone
	call WriteString
	mov eax, 3		; phone field
	call GetUserField	; EDI = pointer to phone
	mov edx, edi
	call WriteString
	call CrLf
	call CrLf
	
	; Get new phone
	mov edx, OFFSET newPhonePrompt
	call WriteString
	mov edx, OFFSET inputPhone
	mov ecx, PHONE_SIZE
	call ReadString
	
	; Validate new phone
	mov esi, OFFSET inputPhone
	call IsEmptyString
	cmp eax, 1
	je EditPhoneEnd
	
	call ValidatePhone
	cmp eax, 0
	je PhoneValidationFailed
	
	; Check if same as current
	mov ebx, currentUserIndex
	mov eax, 3		; phone field
	call GetUserField	; EDI = pointer to current phone
	mov esi, OFFSET inputPhone
	call CompareStrings
	cmp eax, 0
	je SamePhoneValue
	
	; Check if phone already exists for other users
	call CheckPhoneExists
	cmp eax, 1
	je PhoneAlreadyExists
	
	; Update phone
	mov ebx, currentUserIndex
	mov eax, 3		; phone field
	call GetUserField	; EDI = pointer to phone
	mov esi, OFFSET inputPhone
	mov ecx, PHONE_SIZE
	call CopyStringToBuffer
	
	mov edx, OFFSET updateSuccess
	call WriteString
	jmp EditPhoneEnd

PhoneValidationFailed:
	mov edx, OFFSET phoneError
	call WriteString
	jmp EditPhoneEnd

PhoneAlreadyExists:
	mov edx, OFFSET phoneExistsMsg
	call WriteString
	jmp EditPhoneEnd

SamePhoneValue:
	mov edx, OFFSET sameAsCurrentMsg
	call WriteString

EditPhoneEnd:
	mov edx, OFFSET returnToPortal
	call WriteString
	call ReadChar
	
	pop edi
	pop esi
	pop ecx
	pop ebx
	pop eax
	ret
EditPhone ENDP

; Change password procedure
ChangePassword PROC
	push eax
	push ebx
	push ecx
	push esi
	push edi
	
	call Clrscr
	
	; Get current password for verification
	mov edx, OFFSET currentPasswordPrompt
	call WriteString
	mov edx, OFFSET inputPassword
	mov ecx, PASSWORD_SIZE
	call ReadPasswordMasked
	
	; Verify current password
	mov ebx, currentUserIndex
	mov eax, 1		; password field
	call GetUserField	; EDI = pointer to current password
	mov esi, OFFSET inputPassword
	call CompareStrings
	cmp eax, 0
	jne WrongCurrentPassword
	
	; Get new password
	mov edx, OFFSET newPasswordPrompt
	call WriteString
	mov edx, OFFSET inputPassword
	mov ecx, PASSWORD_SIZE
	call ReadPasswordMasked
	
	; Validate new password
	mov esi, OFFSET inputPassword
	call ValidatePassword
	cmp eax, 0
	je PasswordValidationFailed
	
	; Get password confirmation
	mov edx, OFFSET confirmPasswordPrompt
	call WriteString
	mov edx, OFFSET confirmPassword
	mov ecx, PASSWORD_SIZE
	call ReadPasswordMasked
	
	; Compare passwords
	mov esi, OFFSET inputPassword
	mov edi, OFFSET confirmPassword
	call CompareStrings
	cmp eax, 0
	jne PasswordsDontMatch
	
	; Update password
	mov ebx, currentUserIndex
	mov eax, 1		; password field
	call GetUserField	; EDI = pointer to password
	mov esi, OFFSET inputPassword
	mov ecx, PASSWORD_SIZE
	call CopyStringToBuffer
	
	mov edx, OFFSET updateSuccess
	call WriteString
	jmp ChangePasswordEnd

WrongCurrentPassword:
	mov edx, OFFSET wrongPassword
	call WriteString
	jmp ChangePasswordEnd

PasswordValidationFailed:
	mov edx, OFFSET passwordError
	call WriteString
	jmp ChangePasswordEnd

PasswordsDontMatch:
	mov edx, OFFSET passwordMismatch
	call WriteString

ChangePasswordEnd:
	mov edx, OFFSET returnToPortal
	call WriteString
	call ReadChar
	
	pop edi
	pop esi
	pop ecx
	pop ebx
	pop eax
	ret
ChangePassword ENDP

; Booking portal
BookingPortal PROC
	push eax
	push ebx
	push edx
	push ecx
	push esi
	push edi

	call Clrscr
	mov edx, OFFSET bookingHeader
	call WriteString
	; Add booking implementation here
	mov edx, OFFSET returnToPortal
	call WriteString
	call ReadChar
	
	pop edi
	pop esi
	pop ecx
	pop edx
	pop ebx
	pop eax
	ret
BookingPortal ENDP

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
	call ReadPasswordMasked
	ret
GetCredentials ENDP

; Read password with masking (shows asterisks)
; Input: EDX = buffer address, ECX = buffer size
; Output: Password stored in buffer
ReadPasswordMasked PROC
	push eax
	push ebx
	push ecx
	push edx
	push esi
	
	mov esi, edx		; ESI = buffer address
	mov ebx, 0			; EBX = character count
	dec ecx				; Leave space for null terminator

ReadPasswordLoop:
	call ReadChar		; Read character without echo
	
	; Check for Enter key
	cmp al, ENTER_KEY
	je PasswordComplete
	
	; Check for Backspace
	cmp al, BACKSPACE_KEY
	je HandleBackspace
	
	; Check if buffer is full
	cmp ebx, ecx
	jae ReadPasswordLoop	; Skip if buffer full
	
	; Store character in buffer
	mov [esi + ebx], al
	inc ebx
	
	; Display asterisk
	mov al, '*'
	call WriteChar
	jmp ReadPasswordLoop

HandleBackspace:
	; Check if there are characters to delete
	cmp ebx, 0
	je ReadPasswordLoop
	
	; Remove character from buffer
	dec ebx
	mov al, 0
	mov [esi + ebx], al
	
	; Move cursor back and overwrite asterisk
	mov al, BACKSPACE_KEY
	call WriteChar
	mov al, ' '
	call WriteChar
	mov al, BACKSPACE_KEY
	call WriteChar
	jmp ReadPasswordLoop

PasswordComplete:
	; Null-terminate the string
	mov al, 0
	mov [esi + ebx], al
	call CrLf			; Move to next line
	
	pop esi
	pop edx
	pop ecx
	pop ebx
	pop eax
	ret
ReadPasswordMasked ENDP

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