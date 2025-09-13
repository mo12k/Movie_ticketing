Include Irvine32.inc

Movie_MAXCount = 5
MAXShowtimes = 20
TimeSize = 7
Movie_NameSize = 30
Movie_DescSize = 45

.data

; ========== APPLICATION BANNER AND MAIN MENU ==========
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

mainMenuMsg BYTE 0dh, 0ah, "MAIN MENU:", 0dh, 0ah
            BYTE "1. Admin Login", 0dh, 0ah
            BYTE "2. User Login", 0dh, 0ah
            BYTE "3. User Registration", 0dh, 0ah
            BYTE "4. Exit", 0dh, 0ah
            BYTE "Please select an option (1-4): ", 0

; ========== AUTHENTICATION SYSTEM ==========
; Admin default credentials
adminUsername BYTE "admin", 0
adminPassword BYTE "@96iT2", 0

; Login interface messages
adminLoginHeader BYTE 0dh, 0ah, "=== ADMIN LOGIN ===", 0dh, 0ah, 0
userLoginHeader  BYTE 0dh, 0ah, "=== USER LOGIN ===", 0dh, 0ah, 0
usernamePrompt   BYTE "Username: ", 0
passwordPrompt   BYTE "Password (min 8 chars, uppercase, lowercase, number, special): ", 0

; Login attempt tracking
attempts DWORD 0
maxAttempts DWORD 3
maxAttemptsMsg BYTE "Maximum login attempts exceeded. Access denied.", 0dh, 0ah, 0

; Authentication result messages
adminLoginSuccess BYTE 0dh, 0ah, "Admin login successful! Welcome, Administrator.", 0dh, 0ah, 0
userLoginSuccess  BYTE 0dh, 0ah, "User login successful! Welcome, User.", 0dh, 0ah, 0
loginFailed       BYTE 0dh, 0ah, "Login failed! Invalid username or password.", 0dh, 0ah, 0

; Password masking constants
BACKSPACE_KEY EQU 8
ENTER_KEY EQU 13

; ========== USER REGISTRATION SYSTEM ==========
registrationHeader BYTE 0dh, 0ah, "=== USER REGISTRATION ===", 0dh, 0ah, 0
emailPrompt        BYTE "Email (must contain @): ", 0
phonePrompt        BYTE "Phone (Malaysian format 01X-XXXXXXX): ", 0

; Registration validation error messages
passwordError BYTE 0dh, 0ah, "Password must be at least 8 characters with uppercase, lowercase, number, and special character.", 0dh, 0ah, 0
emailError    BYTE 0dh, 0ah, "Email must contain @ symbol.", 0dh, 0ah, 0
phoneError    BYTE 0dh, 0ah, "Phone must be Malaysian format (01X-XXXXXXX or 01XXXXXXXXX, 10-11 digits starting with 01).", 0dh, 0ah, 0

; Registration result messages
registrationSuccess BYTE 0dh, 0ah, "Registration successful! You can now login with your credentials.", 0dh, 0ah, 0
registrationFailed  BYTE 0dh, 0ah, "Registration failed! Username already exists.", 0dh, 0ah, 0
phoneExistsMsg      BYTE 0dh, 0ah, "Registration failed! Phone number already registered.", 0dh, 0ah, 0
maxUsersReached     BYTE 0dh, 0ah, "Registration failed! Maximum number of users reached.", 0dh, 0ah, 0

; ========== USER DATABASE STRUCTURE ==========
; User record constants
MAX_USERS EQU 100
USERNAME_SIZE EQU 20
PASSWORD_SIZE EQU 20
EMAIL_SIZE EQU 30
PHONE_SIZE EQU 15
REWARD_POINTS_SIZE EQU 4
USER_RECORD_SIZE EQU USERNAME_SIZE + PASSWORD_SIZE + EMAIL_SIZE + PHONE_SIZE + REWARD_POINTS_SIZE

; User database storage
userData BYTE MAX_USERS * USER_RECORD_SIZE DUP(0)
userCount DWORD 2

; Current session tracking
currentUser BYTE USERNAME_SIZE DUP(0)
currentUserIndex DWORD -1

; Predefined users for testing
predefUser1 BYTE "user1", 0
predefPass1 BYTE "pass1", 0
predefEmail1 BYTE "user1@gmail.com",0
predefPhone1 BYTE "0123456789",0
predefReward1 WORD 100

predefUser2 BYTE "user2", 0
predefPass2 BYTE "pass2", 0
predefEmail2 BYTE "user2@gmail.com",0
predefPhone2 BYTE "0123456987",0
predefReward2 WORD 150

; ========== USER PROFILE MANAGEMENT ==========
userPortalHeader BYTE 0dh, 0ah, "=== USER PORTAL ===",0dh, 0ah
                 BYTE "1. View Profile", 0dh, 0ah
                 BYTE "2. Booking Movie Tickets", 0dh, 0ah
                 BYTE "3. Logout", 0dh, 0ah
                 BYTE "Please select an option (1-3): ", 0

; Profile display messages
profileHeader    BYTE 0dh, 0ah, "=== USER PROFILE ===", 0dh, 0ah, 0
profileUsername  BYTE "Username: ", 0
profileEmail     BYTE "Email: ", 0
profilePhone     BYTE "Phone: ", 0
profileRewards   BYTE "Reward Points: ", 0
profileNotFound  BYTE "Error: User profile not found!", 0dh, 0ah, 0
editProfilePrompt BYTE "Do you want to edit your profile? (Y/N): ", 0

; Profile editing interface
editProfileHeader BYTE 0dh, 0ah, "=== EDIT PROFILE ===", 0dh, 0ah, 0
editOption1       BYTE "1. Edit Email", 0dh, 0ah, 0
editOption2       BYTE "2. Edit Phone", 0dh, 0ah, 0
editOption3       BYTE "3. Change Password", 0dh, 0ah, 0
editOption4       BYTE "4. Back to User Portal", 0dh, 0ah, 0
editPrompt        BYTE "Select what to edit (1-4): ", 0

; Profile editing prompts
newEmailPrompt    BYTE "Enter new email: ", 0
newPhonePrompt    BYTE "Enter new phone: ", 0
currentPasswordPrompt BYTE "Enter current password: ", 0
newPasswordPrompt BYTE "Enter new password: ", 0
confirmPasswordPrompt BYTE "Confirm new password: ", 0

; Profile update result messages
updateSuccess     BYTE "Profile updated successfully!", 0dh, 0ah, 0
updateFailed      BYTE "Profile update failed!", 0dh, 0ah, 0
passwordMismatch  BYTE "Passwords do not match!", 0dh, 0ah, 0
wrongPassword     BYTE "Current password is incorrect!", 0dh, 0ah, 0
sameAsCurrentMsg  BYTE "New value is same as current value!", 0dh, 0ah, 0

; ========== MOVIE BOOKING SYSTEM ==========
; Main booking portal
bookingHeader BYTE 0dh, 0ah, "======= BOOKING MOVIE =======", 0dh, 0ah
              BYTE "1. 2D", 0dh, 0ah
              BYTE "2. IMAX", 0dh, 0ah
              BYTE "3. Back to User Portal", 0dh, 0ah
              BYTE "Select an option (1-3): ",0

; Movie selection menus - Using dynamic movie data
; Showtime selection
; Dynamic showtime menu components
showtimeMenuHeader BYTE "=========== SHOWTIMES ===========",0dh,0ah,0
showtimeOptionSuffix BYTE ". ", 0
showtimeBackOption BYTE ". Back to Movie Selection", 0dh, 0ah
                   BYTE "===================================",0dh,0ah
                   BYTE "Select a showtime (1-", 0
showtimeMenuFooter BYTE "): ",0
maxShowtimeOption DWORD ?

showtime1Text BYTE "10:00 AM", 0
showtime2Text BYTE "1:00 PM", 0
showtime3Text BYTE "4:00 PM", 0
showtime4Text BYTE "7:00 PM", 0


; ========== SEAT BOOKING SYSTEM ==========
; Seat selection menus
; Dynamic seat menu components
seatMenuHeaderStart BYTE "=========== SEAT Selection(2D) ===========",0dh,0ah,0
seatMenuIMAXHeaderStart BYTE "=========== SEAT Selection(IMAX) ===========",0dh,0ah,0

seatOption1 BYTE "1. Standard (", 0
seatOption2 BYTE "2. Premium (", 0  
seatOption3 BYTE "3. Couple (", 0
seatOptionEnd BYTE ")", 0
rmPrefix BYTE "RM", 0

seatMenuFooter BYTE "4. Back to Showtime Selection", 0dh, 0ah
               BYTE "===================================", 0dh, 0ah
               BYTE "Select a seat type (1-4): ", 0


seatSelectionPrompt BYTE "Select a seat type (1-4): ",0

; Seat pricing and availability - Updated to use admin-controlled pricing
availableSeats DWORD 50, 20, 30   ; Standard, premium, couple for 10:00 AM
               DWORD 50, 20, 30   ; Standard, premium, couple for 1:00 PM
               DWORD 50, 20, 30   ; Standard, premium, couple for 4:00 PM
               DWORD 50, 20, 30   ; Standard, premium, couple for 7:00 PM

; Dynamic menu components
movies2DHeader BYTE "============ 2D MOVIES ============", 0dh, 0ah, 0
moviesIMAXHeader BYTE "=========== IMAX MOVIES ===========", 0dh, 0ah, 0
movieOptionSuffix BYTE ". ", 0
movieBackOption BYTE ". Back to Booking Portal", 0dh, 0ah
                BYTE "===================================", 0dh, 0ah
                BYTE "Select a movie (1-", 0
movieFooter BYTE "): ", 0

; Seat type names for display
standardText BYTE "Standard", 0
premiumText  BYTE "Premium", 0
coupleText   BYTE "Couple", 0

; Seat quantity management
seatQtyPrompt BYTE "Enter number of seats to book(1-10): ",0
insufficientSeats BYTE "Sorry, not enough seats available. Please choose a smaller quantity.", 0dh, 0ah, 0
invalidQtyMsg BYTE "Invalid seat quantity. Please enter a number between 1 and 10.",0dh,0ah,0
seatsAvailable BYTE "Available seats: ", 0

; ========== COMBO MEAL SYSTEM ==========
comboPrompt BYTE 0dh, 0ah, "Do you want to purchase a combo? (Y/N): ", 0
; Dynamic combo menu components
comboMenuHeaderStart BYTE "============= COMBO MENU =============", 0dh, 0ah, 0
comboOption1 BYTE "1. Combo A - Popcorn + Soft Drink (", 0
comboOption2 BYTE "2. Combo B - Popcorn + Nachos + Soft Drink (", 0
comboOption3 BYTE "3. Combo C - Large Popcorn + 2 Soft Drinks + Candy (", 0
comboOption4 BYTE "4. No Combo", 0dh, 0ah, 0
comboMenuFooter BYTE "======================================", 0dh, 0ah, 0
comboSelectionPrompt BYTE "Select a combo (1-4): ", 0
comboQtyPrompt BYTE "How many combos do you want to purchase? ", 0

; Combo names
comboAText BYTE "Combo A - Popcorn + Soft Drink", 0
comboBText BYTE "Combo B - Popcorn + Nachos + Soft Drink", 0
comboCText BYTE "Combo C - Large Popcorn + 2 Soft Drinks + Candy", 0
noComboText BYTE "No Combo", 0

invalidComboQtyMsg BYTE "Invalid combo quantity. Please enter a number greater than 0.",0dh,0ah,0

; ========== BOOKING SUMMARY AND PAYMENT ==========
bookingSummary BYTE "============= BOOKING SUMMARY =============", 0dh, 0ah, 0
movieSelected BYTE "Movie: ", 0
showtimeSelected BYTE "Showtime: ", 0
seatTypeSelected BYTE "Seat Type: ", 0
seatsBooked BYTE "Quantity: ", 0
seatsText BYTE " seats", 0
totalPriceText BYTE "Total Price: RM", 0
comboSelectedText BYTE "Combo: ", 0
comboPriceText BYTE "Combo Price: RM", 0
comboQtyText BYTE "Combo Quantity: ", 0
subtotalText BYTE "Subtotal: RM", 0
sstText BYTE "SST (6%): RM", 0
finalTotalText BYTE "Final Total: RM", 0

confirmBookingPrompt BYTE "Confirm booking? (Y/N): ", 0
paymentPrompt BYTE "Proceed to payment? (Y/N): ", 0
bookingConfirm BYTE 0dh, 0ah, "Booking successful! Enjoy your movie.", 0dh, 0ah, 0
bookingFailed BYTE 0dh, 0ah, "Booking failed! Please try again.", 0dh, 0ah, 0

; ========== CURRENT BOOKING SESSION DATA ==========
currentMovieType DWORD ?  ; 1=2D, 2=IMAX
currentMovie DWORD ?      ; Movie index
currentShowtime DWORD ?   ; 0=10AM, 1=1PM, 2=4PM, 3=7PM
currentSeatType DWORD ?   ; 0=Standard, 1=Premium, 2=Couple
currentSeatQty DWORD ?    ; Number of seats to book
currentCombo DWORD 0      ; 0=no combo, 1=A, 2=B, 3=C
currentComboQty DWORD 0   ; Quantity of combos selected
SST_RATE EQU 6            ; 6% SST rate


; Admin Dashboard
fullBoard BYTE "=============================", 0DH, 0AH
          BYTE "|     ADMIN   DASHBOARD     |", 0DH, 0AH
          BYTE "=============================", 0DH, 0AH
          BYTE "  1. Update Movie            ", 0DH, 0AH
          BYTE "  2. Adjust Movie Pricing    ", 0DH, 0AH
          BYTE "  3. Set Movie Showtimes     ", 0DH, 0AH
          BYTE "  4. Generate Monthly Report ", 0DH, 0AH
          BYTE "  5. Back to Login Site      ", 0DH, 0AH
          BYTE "=============================", 0DH, 0AH, 0

ListHeader	byte "==============================================", 0DH, 0AH,
"|           M O V I E      L I S T           |", 0DH, 0AH,
"==============================================", 0DH, 0AH, 0

ListHeader2 byte "===============================================", 0DH, 0AH,
"|     C U R R E N T   P R I C E   L I S T     |", 0DH, 0AH,
"===============================================", 0DH, 0AH, 0

ListFooter1	byte "==============================================", 0DH, 0AH,
"Press 'Enter' to continue... ", 0DH, 0AH, 0

ListFooter2 byte "==============================================", 0DH, 0AH, 0

; Movie Data Storage
MovieShow   BYTE Movie_MAXCount * MAXShowtimes * TimeSize DUP(?)
MovieName   BYTE Movie_MAXCount * Movie_NameSize DUP(?)
MovieDesc   BYTE Movie_MAXCount * Movie_DescSize DUP(?)
MovieCount  DWORD 3
TimeCount   DWORD 4, 4, 4, 0, 0
MovieStatus DWORD Movie_MAXCount DUP(?)

; Initial Movies
initMovie1  BYTE "Avatar: The Way of Fire ", 0
initMovie2  BYTE "Avengers: End Game ", 0
initMovie3  BYTE "Titanic ", 0

initDesc1   BYTE "Epic sci-fi adventure with stunning visuals. ", 0
initDesc2   BYTE "Heroes unite to save the universe. ", 0
initDesc3   BYTE "Tragic love aboard a doomed ship. ", 0

; Pricing System - Updated to use cents for consistency
Price2D1    DWORD 1200    ; Standard 2D - RM12.00 in cents
Price2D2    DWORD 1800    ; Premium 2D - RM18.00 in cents
Price2D3    DWORD 2400    ; Couple 2D - RM24.00 in cents

PriceIM1    DWORD 2000    ; Standard IMAX - RM20.00 in cents
PriceIM2    DWORD 3000    ; Premium IMAX - RM30.00 in cents
PriceIM3    DWORD 4000    ; Couple IMAX - RM40.00 in cents

ComboA      DWORD 1095    ; Combo A - RM10.95 in cents
ComboB      DWORD 1370    ; Combo B - RM13.70 in cents
ComboC      DWORD 1888    ; Combo C - RM18.88 in cents
ComboX      DWORD 0       ; No combo

; Create arrays for easier access
seatPrices2D DWORD 1200, 1800, 2400    ; Standard, Premium, Couple (in cents)
seatPricesIMAX DWORD 2000, 3000, 4000  ; Standard, Premium, Couple (in cents)
comboPrices DWORD 1095, 1370, 1888, 0  ; Combo A, B, C, None (in cents)

; Initial showtimes
MovieTime1  BYTE "10:00", 0, 0
MovieTime2  BYTE "13:00", 0, 0
MovieTime3  BYTE "16:00", 0, 0
MovieTime4  BYTE "19:00", 0, 0
            BYTE (MAXShowtimes - 4) * TimeSize DUP(0)
            BYTE 2 * MAXShowtimes * TimeSize DUP(0)

; Status strings
status1 BYTE "[Coming Soon]", 0
status2 BYTE "[Now Showing]", 0
status3 BYTE "[Ended]", 0

; Admin Menu Systems
menu1 byte "=============================", 0DH, 0AH,
"|      Operation  Task      |", 0DH, 0AH,
"=============================", 0DH, 0AH,
"  [1] Add New Movie          ", 0DH, 0AH,
"  [2] Update Movie Status    ", 0DH, 0AH,
"  [3] Remove Movie           ", 0DH, 0AH,
"  [4] Back to Dashboard      ", 0DH, 0AH,
"=============================", 0DH, 0AH, 0

menu2 byte "=============================", 0DH, 0AH,
"|      Operation  Task      |", 0DH, 0AH,
"=============================", 0DH, 0AH,
"  [1] Adjust 2D Price        ", 0DH, 0AH,
"  [2] Adjust IMAX Price      ", 0DH, 0AH,
"  [3] Adjust Combo Price     ", 0DH, 0AH,
"  [4] Back to Dashboard      ", 0DH, 0AH,
"=============================", 0DH, 0AH, 0

menu3 byte "=============================", 0DH, 0AH,
"|      Operation  Task      |", 0DH, 0AH,
"=============================", 0DH, 0AH,
"  [1] Add New Showtime       ", 0DH, 0AH,
"  [2] Back to Dashboard      ", 0DH, 0AH,
"=============================", 0DH, 0AH, 0

menu4 byte "=============================", 0DH, 0AH,
"|      Operation  Task      |", 0DH, 0AH,
"=============================", 0DH, 0AH,
"  [1] Generate Report        ", 0DH, 0AH,
"  [2] Back to Dashboard      ", 0DH, 0AH,
"=============================", 0DH, 0AH, 0

; Pricing menus
menu10 byte "=============================", 0DH, 0AH,
"|         2D TICKET         |", 0DH, 0AH,
"=============================", 0DH, 0AH,
"  [1] STANDARD               ", 0DH, 0AH,
"  [2] PREMIUM                ", 0DH, 0AH,
"  [3] COUPLE                 ", 0DH, 0AH,
"  [4] Back to Price List     ", 0DH, 0AH,
"=============================", 0DH, 0AH, 0

menu11 byte "=============================", 0DH, 0AH,
"|        IMAX TICKET        |", 0DH, 0AH,
"=============================", 0DH, 0AH,
"  [1] STANDARD               ", 0DH, 0AH,
"  [2] PREMIUM                ", 0DH, 0AH,
"  [3] COUPLE                 ", 0DH, 0AH,
"  [4] Back to Price List     ", 0DH, 0AH,
"=============================", 0DH, 0AH, 0

menu12 byte "=============================", 0DH, 0AH,
"|        FOOD  COMBO        |", 0DH, 0AH,
"=============================", 0DH, 0AH,
"  [1] COMBO A                ", 0DH, 0AH,
"  [2] COMBO B                ", 0DH, 0AH,
"  [3] COMBO C                ", 0DH, 0AH,
"  [4] Back to Price List     ", 0DH, 0AH,
"=============================", 0DH, 0AH, 0

; Admin prompts and messages
prompt1 BYTE "Select your operation [1 - 5]: ", 0
prompt2 BYTE "Select your operation [1 - 4]: ", 0
prompt3 BYTE "Select your operation [1 - 2]: ", 0
prompt4 BYTE "Select your choice [1 - 4]: ", 0
promptX BYTE "Do you wish to continue? [7 = yes, 0 = no]: ", 0

msg0 BYTE "INVALID operation! Try again.", 0

; Movie management messages
msg101 BYTE "New Movie Name: ", 0
msg102 BYTE "New Movie Description: ", 0
msg103 BYTE "Confirm? [Y / N]: ", 0
msg104 BYTE "New movie successfully added!", 0
msg105 BYTE "Movie list is full.", 0

msg110 BYTE "Select the movie [1 - ", 0
msg111 BYTE "]: ", 0
msg112 BYTE "Confirm update from [Coming Soon] to [Now Showing]? [Y / N]: ", 0
msg113 BYTE "Confirm update from [Now Showing] to [Ended]? [Y / N]: ", 0
msg114 BYTE "The movie is already ended. ", 0
msg115 BYTE "Movie status successfully updated!", 0

msg121 BYTE "Confirm to remove this movie? [Y / N]: ", 0
msg122 BYTE "Movie successfully removed!", 0

; Pricing messages
msg201 BYTE "  2D Standard   : RM ", 0
msg202 BYTE "  2D Premium    : RM ", 0
msg203 BYTE "  2D Couple     : RM ", 0
msg204 BYTE "  IMAX Standard : RM ", 0
msg205 BYTE "  IMAX Premium  : RM ", 0
msg206 BYTE "  IMAX Couple   : RM ", 0
msg207 BYTE "  Combo A       : RM ", 0
msg208 BYTE "  Combo B       : RM ", 0
msg209 BYTE "  Combo C       : RM ", 0
msg210 BYTE "  No Combo      : RM ", 0

msg220 BYTE "Enter new price (RM): ", 0
msg221 BYTE "New price successfully updated!", 0
msg222 BYTE "INVALID input! Try again.", 0

; Showtime messages
msg301 BYTE "Enter new showtime (HH:MM): ", 0
msg302 BYTE "Showtime added successfully! ", 0
msg303 BYTE "Maximum showtimes reached!", 0
msg304 BYTE "INVALID time format! Try again. ", 0
msg305 BYTE "CONFLICTED time! Try again. ", 0

msg4 BYTE "Report generation feature coming soon!", 0

; Navigation messages
msg501 BYTE "Returning to Login site... ", 0
msg502 BYTE "Returning to Dashboard... ", 0
msg503 BYTE "Returning to Price list... ", 0

msg6 BYTE "Good Work! Thank You!", 0

; Admin input buffers
bufferName  BYTE Movie_NameSize DUP(?)
bufferName1 BYTE Movie_NameSize + 1 DUP(?)
bufferDesc  BYTE Movie_DescSize DUP(?)
intBuffer   DWORD ?
bufferTime  BYTE 16 DUP(?)
hundred     DWORD 100

; ========== INPUT BUFFERS ==========
inputUsername BYTE 20 DUP(0)
inputPassword BYTE 20 DUP(0)
inputEmail BYTE EMAIL_SIZE DUP(0)
inputPhone BYTE PHONE_SIZE DUP(0)
confirmPassword BYTE PASSWORD_SIZE DUP(0)
menuChoice BYTE ?
userChoice DWORD ?

; ========== COMMON SYSTEM MESSAGES ==========
exitMsg BYTE 0dh, 0ah, "Exiting the program. Goodbye!", 0dh, 0ah, 0
InvalidChoice BYTE 0dh, 0ah, "Invalid choice. Please select a valid option.", 0dh, 0ah, 0
continueMsg BYTE 0dh, 0ah, "Press any key to return to main menu...", 0dh, 0ah, 0
returnToPortal BYTE 0dh, 0ah, "Press any key to return to User Portal...", 0dh, 0ah, 0
emptyInputMsg BYTE 0dh, 0ah, "Input cannot be empty. Please try again.", 0dh, 0ah, 0
invalidYNMsg BYTE 0dh, 0ah, "Invalid input! Please enter Y for Yes or N for No.", 0dh, 0ah, 0
decimalPoint BYTE ".", 0

;checkout message
paymentHeader	BYTE 0dh, 0ah, "=========================================================", 0dh, 0ah
				BYTE " ____                                  _   ", 0dh, 0ah
				BYTE "|  _ \ __ _ _   _ _ __ ___   ___ _ __ | |_ ", 0dh, 0ah
				BYTE "| |_) / _` | | | | '_ ` _ \ / _ \ '_ \| __|", 0dh, 0ah
				BYTE "|  __/ (_| | |_| | | | | | |  __/ | | | |_ ", 0dh, 0ah
				BYTE "|_|   \__,_|\__, |_| |_| |_|\___|_| |_|\__|", 0dh, 0ah
				BYTE " __  __     |___/_               _         ", 0dh, 0ah
				BYTE "|  \/  | ___| |_| |__   ___   __| |        ", 0dh, 0ah
				BYTE "| |\/| |/ _ \ __| '_ \ / _ \ / _` |        ", 0dh, 0ah
				BYTE "| |  | |  __/ |_| | | | (_) | (_| |        ", 0dh, 0ah
				BYTE "|_|  |_|\___|\__|_| |_|\___/ \__,_|        ", 0dh, 0ah
				BYTE "=========================================================", 0dh, 0ah
				BYTE "1. Pay with Credit/Debit Card", 0dh, 0ah
				BYTE "2. Pay with E-Wallet", 0dh, 0ah
				BYTE "3. Pay with Online Banking", 0dh, 0ah
				BYTE "4. Pay with Reward Point", 0dh, 0ah
				BYTE "5. Cancel Payment and Return to User Portal", 0dh, 0ah
				BYTE "Please select a payment method (1-4): ", 0

	paymentSuccess BYTE 0dh, 0ah, "Payment successful! Thank you for your purchase.", 0dh, 0ah, 0
	paymentFailed BYTE 0dh, 0ah, "Payment failed! Please try again.", 0dh, 0ah, 0
	paymentChoice BYTE ?

	;E-Wallet payment option
	EwalletPrompt	BYTE "1. GrabPay", 0dh, 0ah
					BYTE "2. Touch 'n Go eWallet", 0dh, 0ah
					BYTE "3. Boost", 0dh, 0ah
					BYTE "Select an E-Wallet (1-3): ", 0

	QRPrompt BYTE "Scan the QR code with your E-Wallet app to complete the payment.", 0dh, 0ah, 0
	QRImage BYTE "+--------------------+", 0dh, 0ah
			BYTE "| ### ## ## # # ## ##|", 0dh, 0ah
			BYTE "| ##   ## ## ## ##  #|", 0dh, 0ah
			BYTE "| ## # ### # ## ## ##|", 0dh, 0ah
			BYTE "| ##  ##   ##  ##  ##|", 0dh, 0ah
			BYTE "| ##   ## ##  # # ## |", 0dh, 0ah
			BYTE "| ## # ##  # ## # ###|", 0dh, 0ah
			BYTE "| ## ## # ## #### ## |", 0dh, 0ah
			BYTE "+--------------------+", 0dh, 0ah, 0
	QRSuccess BYTE "Payment completed via E-Wallet. Thank you!", 0dh, 0ah, 0

	;Credit/Debit Card payment option
	cardNumberPrompt BYTE "Enter your card number (16 digits): ", 0
	cardExpiryPrompt BYTE "Enter card expiry date (MM/YY): ", 0
	cardCVVPrompt BYTE "Enter card CVV (3 digits): ", 0
	cardNumber BYTE 20 DUP(0)
	cardExpiry BYTE 6 DUP(0)
	cardCVV BYTE 4 DUP(0)
	cardError BYTE 0dh, 0ah, "Invalid card details. Please try again.", 0dh, 0ah, 0

	;Online Banking payment option
	bankingPrompt BYTE "Select your bank:", 0dh, 0ah
					BYTE "1. Maybank", 0dh, 0ah
					BYTE "2. CIMB", 0dh, 0ah
					BYTE "3. Public Bank", 0dh, 0ah
					BYTE "Select a bank (1-3): ", 0
	bankingUsernamePrompt BYTE "Enter your online banking username: ", 0
	bankingPasswordPrompt BYTE "Enter your online banking password: ", 0
	bankingUsername BYTE 30 DUP(0)
	bankingPassword BYTE 20 DUP(0)


	processingPayment BYTE 0dh, 0ah, "=== PROCESSING PAYMENT ===", 0dh, 0ah, 0
	cardNumberError BYTE 0dh, 0ah, "Card number must be exactly 16 digits!", 0dh, 0ah, 0
	cardExpiryError BYTE 0dh, 0ah, "Invalid expiry date format! Use MM/YY.", 0dh, 0ah, 0
	cardCVVError BYTE 0dh, 0ah, "CVV must be exactly 3 digits!", 0dh, 0ah, 0
	processingCodeMsg BYTE "Processing your payment code... Please wait.", 0dh, 0ah, 0
	selectedBankMsg BYTE "Selected Bank: ", 0
	maybank BYTE "Maybank", 0
	cimb BYTE "CIMB", 0
	publicbank BYTE "Public Bank", 0
	ewalletOptions BYTE "Selected E-Wallet: ", 0
	grabpay BYTE "GrabPay", 0
	touchngo BYTE "Touch 'n Go eWallet", 0
	boost BYTE "Boost", 0
	cardAttemptsExceeded BYTE 0dh, 0ah, "Maximum card attempts exceeded. Returning to payment method selection.", 0dh, 0ah, 0


	; ========== RECEIPT GENERATION SYSTEM ==========
	receiptHeader BYTE "===============================================", 0dh, 0ah
				  BYTE "           AFC CINEMA RECEIPT", 0dh, 0ah  
				  BYTE "===============================================", 0dh, 0ah, 0

	receiptFooter BYTE "===============================================", 0dh, 0ah
				  BYTE "      Thank you for choosing AFC Cinema!", 0dh, 0ah
				  BYTE "===============================================", 0dh, 0ah, 0

	receiptDateLabel BYTE "Date: ", 0
	receiptTimeLabel BYTE "Time: ", 0
	receiptCustomerLabel BYTE "Customer: ", 0
	slashChar BYTE "/", 0
	colonChar BYTE ":", 0

	; Date and time storage
	currentYear WORD ?
	currentMonth BYTE ?
	currentDay BYTE ?
	currentHour BYTE ?
	currentMinute BYTE ?
	currentSecond BYTE ?
	sysTime SYSTEMTIME <>

	; Add these to your receipt data section
	receiptSeparator BYTE "-----------------------------------------------", 0dh, 0ah, 0
	receiptEquals BYTE "===============================================", 0dh, 0ah, 0
	spacePadding BYTE "                    ", 0

	rewardPointsEarned BYTE 0dh, 0ah, "Congratulations! You earned ", 0
	rewardPointsText BYTE " reward points from this purchase.", 0dh, 0ah, 0
	rewardPointsBalance BYTE "Your new reward points balance: ", 0
	pointsEarnedMsg BYTE 0dh, 0ah, "=== REWARD POINTS EARNED ===", 0dh, 0ah, 0

	availableMsg         BYTE "Your Reward Points: ",0
	requiredMsg          BYTE "Required Points: ",0
	successMsg           BYTE "Payment successful! Points deducted.",0
	notEnoughPointsMsg   BYTE "Not enough reward points for this purchase!",0
	pressAnyKeyMsg       BYTE "Press any key to continue...",0
	finalTotalRM		 DWORD ?
	finalTotalCents		 DWORD ?

	;e-Ticket 
	eticketHeader	 BYTE "===============================================", 0dh, 0ah
				     BYTE "===== E - T I C K E T =====", 0dh, 0ah
					 BYTE "===============================================", 0dh, 0ah, 0
	
	eticketFooter    BYTE "Thank you for your purchase. Enjoy your movie!",0

	; ASCII
	QRImage2 BYTE " [==== QR / BARCODE ====]",0dh, 0ah
		    BYTE " |  ? ?   ? ?   ? ?   |",0dh, 0ah
		    BYTE " |  ?   ?   ?   ?   ? |",0dh, 0ah
		    BYTE " |  ? ?   ? ?   ? ?   |",0dh, 0ah
		    BYTE " |        SCAN        |",0dh, 0ah
		    BYTE " ======================",0		  

	; ========== DYNAMIC MOVIE MANAGEMENT ==========
	; Movie constants
	MAX_MOVIES EQU 10
	MOVIE_NAME_SIZE EQU 50
	MOVIE_DESC_SIZE EQU 100

	; Movie database
	movieDatabase BYTE MAX_MOVIES * MOVIE_NAME_SIZE DUP(0)    ; Movie names
	movieDescriptions BYTE MAX_MOVIES * MOVIE_DESC_SIZE DUP(0) ; Movie descriptions
	movieStatusDynamic DWORD MAX_MOVIES DUP(1)               ; 1=active, 0=inactive (renamed to avoid conflict)
	movieCountDynamic DWORD 3                                 ; Current number of movies (renamed to avoid conflict)

	; Status display strings
	activeStatus BYTE " [ACTIVE]", 0
	inactiveStatus BYTE " [INACTIVE]", 0

	; Admin menu messages
	adminMovieHeader BYTE "========== MOVIE MANAGEMENT ==========", 0dh, 0ah
					 BYTE "1. Add New Movie", 0dh, 0ah
					 BYTE "2. Remove Movie", 0dh, 0ah
					 BYTE "3. View All Movies", 0dh, 0ah
					 BYTE "4. Back to Admin Portal", 0dh, 0ah
					 BYTE "Select option (1-4): ", 0

	addMoviePrompt BYTE "Enter movie name: ", 0
	addDescPrompt BYTE "Enter movie description: ", 0
	removeMoviePrompt BYTE "Enter movie number to remove: ", 0
	movieAddedMsg BYTE "Movie added successfully!", 0dh, 0ah, 0
	movieRemovedMsg BYTE "Movie removed successfully!", 0dh, 0ah, 0
	movieNotFoundMsg BYTE "Movie not found!", 0dh, 0ah, 0
	maxMoviesReachedMsg BYTE "Maximum number of movies reached!", 0dh, 0ah, 0

	; Temporary buffers for admin input
	tempMovieName BYTE MOVIE_NAME_SIZE DUP(0)
	tempMovieDesc BYTE MOVIE_DESC_SIZE DUP(0)

	; Movie names for display
	movie1_2D BYTE "Avatar: The Way of Fire", 0
	movie2_2D BYTE "Avengers: End Game", 0
	movie3_2D BYTE "Titanic", 0

	movie1_IMAX BYTE "Avatar: The Way of Fire", 0
	movie2_IMAX BYTE "Avengers: End Game", 0
	movie3_IMAX BYTE "Titanic", 0

	movieType2D BYTE "2D", 0
	movieTypeIMAX BYTE "IMAX", 0
	
	; ========== REVENUE TRACKING SYSTEM ==========
	; Revenue counters (in cents for precision)
	totalTicketRevenue DWORD 0      ; Total ticket sales revenue
	totalComboRevenue DWORD 0       ; Total combo sales revenue
	totalSSTRevenue DWORD 0         ; Total SST collected
	totalRevenueAllTime DWORD 0     ; Grand total revenue

	; Transaction counters
	totalTicketsSold DWORD 0        ; Number of tickets sold
	totalCombosSold DWORD 0         ; Number of combos sold
	totalTransactions DWORD 0       ; Number of completed transactions

	; Movie-specific revenue tracking (by movie index)
	movieRevenue DWORD Movie_MAXCount DUP(0)    ; Revenue per movie
	movieTicketsSold DWORD Movie_MAXCount DUP(0) ; Tickets sold per movie

	; Seat type revenue tracking
	standardRevenue DWORD 0         ; Standard seat revenue
	premiumRevenue DWORD 0          ; Premium seat revenue
	coupleRevenue DWORD 0           ; Couple seat revenue

	; Report display messages
	reportHeader BYTE "===============================================", 0dh, 0ah
				 BYTE "           MONTHLY REVENUE REPORT", 0dh, 0ah
				 BYTE "===============================================", 0dh, 0ah, 0

	revenueReportFooter BYTE "===============================================", 0dh, 0ah
						BYTE "        End of Revenue Report", 0dh, 0ah
						BYTE "===============================================", 0dh, 0ah, 0

	; Revenue display labels
	ticketRevenueLabel BYTE "Total Ticket Revenue: RM", 0
	comboRevenueLabel BYTE "Total Combo Revenue: RM", 0
	sstRevenueLabel BYTE "Total SST Collected: RM", 0
	grandTotalLabel BYTE "GRAND TOTAL REVENUE: RM", 0
	ticketsSoldLabel BYTE "Total Tickets Sold: ", 0
	combosSoldLabel BYTE "Total Combos Sold: ", 0
	transactionsLabel BYTE "Total Transactions: ", 0

	; Movie revenue section
	movieRevenueHeader BYTE 0dh, 0ah, "--- REVENUE BY MOVIE ---", 0dh, 0ah, 0
	seatTypeHeader BYTE 0dh, 0ah, "--- REVENUE BY SEAT TYPE ---", 0dh, 0ah, 0
	standardRevenueLabel BYTE "Standard Seats: RM", 0
	premiumRevenueLabel BYTE "Premium Seats: RM", 0
	coupleRevenueLabel BYTE "Couple Seats: RM", 0

	; Report menu
	reportMenu BYTE "=============================", 0DH, 0AH
			   BYTE "|      REPORT  OPTIONS      |", 0DH, 0AH
			   BYTE "=============================", 0DH, 0AH
			   BYTE "  [1] Generate Revenue Report", 0DH, 0AH
			   BYTE "  [2] Reset Revenue Data     ", 0DH, 0AH
			   BYTE "  [3] Back to Dashboard      ", 0DH, 0AH
			   BYTE "=============================", 0DH, 0AH, 0

	resetConfirmMsg BYTE "Are you sure you want to reset all revenue data? (Y/N): ", 0
	resetSuccessMsg BYTE "Revenue data has been reset successfully!", 0dh, 0ah, 0
	noRevenueDataMsg BYTE "No revenue data available. Complete some transactions first.", 0dh, 0ah, 0

	; ========== COLOR CONSTANTS ==========
	RED_COLOR EQU 12        ; Bright red (4 + 8 for intensity)
	WHITE_COLOR EQU 15      ; Bright white (default)
	GRAY_COLOR EQU 7        ; Light gray (normal text)
	LIGHT_GREEN_COLOR EQU 10 ; Light green (2 + 8 for intensity)

.code
main PROC
	; Initialize admin movie data
	call InitializeMovieData
	call InitializeMovies
	; Initialize user data with predefined users
	call InitializeUserData
	call Clrscr
	call MainMenu
	exit
main ENDP

; Initialize movie database with default movies
InitializeMovies PROC
    push eax
    push ecx
    push esi
    push edi
    
    ; Clear movie database
    mov edi, OFFSET movieDatabase
    mov ecx, MAX_MOVIES * MOVIE_NAME_SIZE
    xor eax, eax
    rep stosb
    
    mov edi, OFFSET movieDescriptions  
    mov ecx, MAX_MOVIES * MOVIE_DESC_SIZE
    xor eax, eax
    rep stosb
    
    ; Add initial movies
    ; Movie 1
    mov esi, OFFSET initMovie1
    mov edi, OFFSET movieDatabase
    call CopyMovieString
    
    mov esi, OFFSET initDesc1
    mov edi, OFFSET movieDescriptions
    call CopyMovieString
    
    ; Movie 2
    mov esi, OFFSET initMovie2
    mov edi, OFFSET movieDatabase
    add edi, MOVIE_NAME_SIZE
    call CopyMovieString
    
    mov esi, OFFSET initDesc2
    mov edi, OFFSET movieDescriptions
    add edi, MOVIE_DESC_SIZE
    call CopyMovieString
    
    ; Movie 3
    mov esi, OFFSET initMovie3
    mov edi, OFFSET movieDatabase
    add edi, MOVIE_NAME_SIZE * 2
    call CopyMovieString
    
    mov esi, OFFSET initDesc3
    mov edi, OFFSET movieDescriptions
    add edi, MOVIE_DESC_SIZE * 2
    call CopyMovieString
    
    pop edi
    pop esi
    pop ecx
    pop eax
    ret
InitializeMovies ENDP

; Helper procedure to copy movie strings
CopyMovieString PROC
    push eax
    push ecx
    
    mov ecx, 0
CopyMovieLoop:
    mov al, [esi]
    cmp al, 0
    je CopyMovieDone
    mov [edi], al
    inc esi
    inc edi
    inc ecx
    cmp ecx, MOVIE_NAME_SIZE - 1  ; Leave space for null terminator
    jl CopyMovieLoop
    
CopyMovieDone:
    mov BYTE PTR [edi], 0  ; Null terminate
    pop ecx
    pop eax
    ret
CopyMovieString ENDP

; Calculate and award reward points (RM1 = 1 point)
AwardRewardPoints PROC
	push eax
	push ebx
	push ecx
	push edx
	push esi
	push edi
	
	; Calculate total purchase amount in RM (whole number only)
	call CalculateFinalTotalInRM
	mov ebx, eax  ; Store total RM in EBX (this will be the points to award)
	
	; Get current user's reward points
	mov ebx, currentUserIndex
	cmp ebx, -1
	je AwardPointsEnd  ; Exit if no valid user
	
	mov eax, 4  ; reward points field
	call GetUserField  ; EDI = pointer to reward points
	
	; Load current points and add new points
	movzx ecx, WORD PTR [edi]  ; Load current points
	call CalculateFinalTotalInRM  ; Get total RM again
	add ecx, eax  ; Add earned points to current points
	
	; Store updated points (ensure it doesn't exceed WORD limit)
	cmp ecx, 65535
	jle StorePoints
	mov ecx, 65535  ; Cap at maximum WORD value

StorePoints:
	mov WORD PTR [edi], cx  ; Store updated points
	
	; Display reward points earned message
	call CrLf
	mov edx, OFFSET pointsEarnedMsg
	call WriteString
	
	mov edx, OFFSET rewardPointsEarned
	call WriteString
	call WriteDec  ; Display points earned (still in EAX)
	mov edx, OFFSET rewardPointsText
	call WriteString
	
	; Display new balance
	mov edx, OFFSET rewardPointsBalance
	call WriteString
	mov eax, ecx  ; Move new total to EAX
	call WriteDec
	call CrLf
	call CrLf

AwardPointsEnd:
	pop edi
	pop esi
	pop edx
	pop ecx
	pop ebx
	pop eax
	ret
AwardRewardPoints ENDP

; Calculate final total in whole RM (for reward points calculation)
; FIXED: Calculate final total in whole RM (for reward points calculation)
CalculateFinalTotalInRM PROC
	push ebx
	push ecx
	push edx
	push esi
	
	; Calculate ticket price in cents
	mov eax, currentSeatType
	dec eax  ; Convert to 0-based index
	
	cmp currentMovieType, 0
	je UseRM2DPrices
	
	; Use IMAX prices
	mov ebx, OFFSET seatPricesIMAX
	jmp GetRMPrice

UseRM2DPrices:
	mov ebx, OFFSET seatPrices2D

GetRMPrice:
	mov ecx, [ebx + eax*4]  ; Get price per seat in cents
	mov eax, currentSeatQty
	mul ecx  ; Total ticket price in cents
	
	; DON'T multiply by 100 again - prices are already in cents!
	mov esi, eax  ; Store ticket price in ESI (already in cents)
	
	; Add combo price if selected
	cmp currentCombo, 0
	je NoRMComboPrice
	
	mov eax, currentCombo
	dec eax  ; Convert to 0-based index
	mov ebx, OFFSET comboPrices
	mov ecx, [ebx + eax*4]  ; Get combo price per unit in cents
	
	; Multiply by combo quantity
	mov eax, currentComboQty
	mul ecx  ; EAX = total combo price in cents
	
	add esi, eax  ; Add combo price to ticket price

NoRMComboPrice:
	; Calculate SST (6% of subtotal) and add to total
	mov eax, esi  ; Get subtotal in cents
	mov ebx, SST_RATE  ; 6%
	mul ebx  ; EAX = subtotal * 6
	mov ebx, 100
	mov edx, 0
	div ebx  ; EAX = SST amount in cents
	
	add esi, eax  ; Add SST to subtotal for final total

	; Convert total from cents to whole RM (divide by 100, ignore remainder)
	mov eax, esi  ; Get total price in cents
	mov ebx, 100
	mov edx, 0
	div ebx  ; EAX = whole RM amount (reward points to award)

	pop esi
	pop edx
	pop ecx
	pop ebx
	ret
CalculateFinalTotalInRM ENDP

; ==========================================================
; Calculate final total in cents (no truncation)
; ==========================================================
CalculateFinalTotalInCents PROC
    push ebx
    push ecx
    push edx
    push esi

    ; ---------- Ticket price ----------
    mov eax, currentSeatType
    dec eax                      ; Convert to 0-based index

    cmp currentMovieType, 0
    je Use2DPrices

    ; IMAX price table
    mov ebx, OFFSET seatPricesIMAX
    jmp GetSeatPrice

Use2DPrices:
    mov ebx, OFFSET seatPrices2D

GetSeatPrice:
    mov ecx, [ebx + eax*4]       ; Seat unit price (RM)
    mov eax, currentSeatQty
    mul ecx                      ; eax = seatQty * unit price (RM)

    ; Convert to cents
    mov ebx, 100
    mul ebx                      ; eax = subtotal in cents
    mov esi, eax                 ; esi = ticket subtotal (cents)

    ; ---------- Combo ----------
    cmp currentCombo, 0
    je SkipCombo

    mov eax, currentCombo
    dec eax
    mov ebx, OFFSET comboPrices
    mov ecx, [ebx + eax*4]       ; Single combo price (cents)

    mov eax, currentComboQty
    mul ecx                      ; eax = combo total (cents)
    add esi, eax

SkipCombo:
    ; ---------- SST (6%) ----------
    mov eax, esi
    mov ebx, SST_RATE            ; 6
    mul ebx                      ; eax = subtotal * 6
    mov ebx, 100
    xor edx, edx
    div ebx                      ; eax = SST (cents)

    add esi, eax                 ; Add SST

    mov eax, esi                 ; return final total in cents

    pop esi
    pop edx
    pop ecx
    pop ebx
    ret
CalculateFinalTotalInCents ENDP

MainMenu PROC
	call Clrscr
	
MainMenuLoop:
    mov edx, OFFSET banner
    call DisplayHeaderGreen
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

    call DisplayInvalidChoice  ; CHANGED: Use red color
    jmp MainMenuLoop

AdminLoginOption:
	mov ebx, 0  ; Admin login type
	call PerformLogin
	jmp MainMenuLoop

UserLoginOption:
	mov ebx, 1  ; User login type
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

UserPortal PROC
	push eax
	push ebx
	push edx
	push ecx
	push esi

	call Clrscr

UserPortalLoop:
    mov edx, OFFSET userPortalHeader
    call DisplayHeaderGreen
    mov edx, OFFSET menuChoice
    call WriteString
    call ReadChar
    call WriteChar
    call CrLf
    
    cmp al, '1'
    je ViewProfileOption
    cmp al, '2'
    je BookingOption
    cmp al, '3'
    je LogoutOption

    call DisplayInvalidChoice  ; CHANGED: Use red color
    jmp UserPortalLoop

ViewProfileOption:
	call ViewUserProfile
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

; ========== ADMIN PORTAL ==========
AdminPortal PROC
	push eax
	push ebx
	push edx
	push ecx
	push esi

dashboardLoop:
	call Clrscr
	mov edx, OFFSET fullBoard
	call DisplayHeaderGreen

	mov edx, OFFSET prompt1
	call WriteString

	call ReadChar
	call WriteChar
	call CrLf

	cmp al, '1'
	je AdminMovieManagement
	cmp al, '2'
	je AdminPricing
	cmp al, '3'
	je AdminShowtimes
	cmp al, '4'
	je AdminReport
	cmp al, '5'
	je AdminBackToLogin
	jmp AdminInvalid1

AdminMovieManagement:
	call displayMovieList
	jmp AdminStatusMenu

AdminStatusMenu:
	mov edx, OFFSET menu1
	call WriteString

	mov edx, OFFSET prompt2
	call WriteString

	call ReadChar
	call WriteChar
	call CrLf

	cmp al, '1'
	je AdminAddMovie
	cmp al, '2'
	je AdminUpdateMovie
	cmp al, '3'
	je AdminRemoveMovie
	cmp al, '4'
	je AdminBackDashboard
	jmp AdminInvalid2

AdminAddMovie:
	call AddNewMovie
	jmp AdminReturn

AdminUpdateMovie:
	call UpdateMovieStatus
	jmp AdminReturn

AdminRemoveMovie:
	call RemoveSelectMovie
	jmp AdminReturn

AdminPricing:
	call AdjustPricing
	cmp al, '4'
	je AdminBackDashboard
	jmp AdminReturn

AdminShowtimes:
	call SetShowtimes
	cmp al, '2'
	je AdminBackDashboard
	jmp AdminReturn

AdminReport:
    call GenerateRevenueReport
    cmp al, '3'
    je AdminBackDashboard
    jmp AdminReturn

AdminBackToLogin:
	mov edx, OFFSET msg501
	call WriteString
	call CrLf
	jmp AdminPortalEnd

AdminBackDashboard:
	mov edx, OFFSET msg502
	call WriteString
	call CrLf
	jmp dashboardLoop

AdminReturn:
	mov edx, OFFSET promptX
	call WriteString
	call ReadChar
	call WriteChar
	call CrLf

	cmp al, '7'
	je AdminBackDashboard
	cmp al, '0'
	je AdminQuit
	jmp AdminInvalidX

AdminQuit: 
	mov edx, OFFSET msg6
	call WriteString
	jmp AdminPortalEnd

AdminInvalid1:
    mov edx, OFFSET msg0
    call DisplayErrorMessage  ; CHANGED: Use red color
    call CrLf
    jmp dashboardLoop

AdminInvalid2:
    mov edx, OFFSET msg0
    call DisplayErrorMessage  ; CHANGED: Use red color
    call CrLf
    jmp AdminStatusMenu

AdminInvalidX:
    mov edx, OFFSET msg0
    call DisplayErrorMessage  ; CHANGED: Use red color
    call CrLf
    jmp AdminReturn

AdminPortalEnd:
	pop esi
	pop ecx
	pop edx
	pop ebx
	pop eax
	ret
AdminPortal ENDP

; Track revenue from completed transaction
TrackRevenue PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    
    ; Calculate ticket revenue
    mov eax, currentSeatType
    dec eax  ; Convert to 0-based index
    
    cmp currentMovieType, 0
    je TrackTicket2D
    
    ; IMAX pricing
    mov ebx, OFFSET seatPricesIMAX
    jmp GetTicketRevenue

TrackTicket2D:
    mov ebx, OFFSET seatPrices2D

GetTicketRevenue:
    mov ecx, [ebx + eax*4]  ; Price per seat in cents
    mov eax, currentSeatQty
    mul ecx  ; Total ticket revenue in cents
    
    ; Add to total ticket revenue
    add totalTicketRevenue, eax
    
    ; Track by seat type
    mov ebx, currentSeatType
    cmp ebx, 1
    je TrackStandard
    cmp ebx, 2
    je TrackPremium
    cmp ebx, 3
    je TrackCouple
    jmp TrackComboRevenue

TrackStandard:
    add standardRevenue, eax
    jmp TrackComboRevenue

TrackPremium:
    add premiumRevenue, eax
    jmp TrackComboRevenue

TrackCouple:
    add coupleRevenue, eax

TrackComboRevenue:
    ; Track combo revenue if selected
    cmp currentCombo, 0
    je TrackSST
    
    mov eax, currentCombo
    dec eax  ; Convert to 0-based
    mov ebx, OFFSET comboPrices
    mov ecx, [ebx + eax*4]  ; Price per combo in cents
    
    mov eax, currentComboQty
    mul ecx  ; Total combo revenue in cents
    add totalComboRevenue, eax
    
    ; Update combo counter
    mov eax, currentComboQty
    add totalCombosSold, eax

TrackSST:
    ; Calculate and track SST
    mov eax, totalTicketRevenue
    add eax, totalComboRevenue
    mov esi, eax  ; Store subtotal
    
    ; Calculate current transaction subtotal
    call CalculateCurrentTransactionSubtotal
    mov ebx, SST_RATE
    mul ebx
    mov ebx, 100
    xor edx, edx
    div ebx  ; EAX = SST for this transaction
    
    add totalSSTRevenue, eax

TrackMovieRevenue:
    ; Track revenue by movie
    mov eax, currentMovie
    dec eax  ; Convert to 0-based
    cmp eax, Movie_MAXCount
    jae TrackCounters
    
    ; Add ticket revenue to specific movie
    mov ebx, currentSeatType
    dec ebx
    cmp currentMovieType, 0
    je MovieTrack2D
    
    mov ecx, OFFSET seatPricesIMAX
    jmp AddMovieRevenue

MovieTrack2D:
    mov ecx, OFFSET seatPrices2D

AddMovieRevenue:
    mov edx, [ecx + ebx*4]  ; Price per seat
    push eax
    mov eax, currentSeatQty
    mul edx  ; Total for this movie
    mov edx, eax
    pop eax
    
    ; Add to movie revenue array
    shl eax, 2  ; Multiply by 4 for DWORD
    add [movieRevenue + eax], edx
    
    ; Track tickets sold per movie
    mov ebx, currentSeatQty
    add [movieTicketsSold + eax], ebx

TrackCounters:
    ; Update counters
    mov eax, currentSeatQty
    add totalTicketsSold, eax
    inc totalTransactions
    
    ; Update grand total
    call UpdateGrandTotal
    
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
TrackRevenue ENDP

; Calculate current transaction subtotal for SST calculation
CalculateCurrentTransactionSubtotal PROC
    push ebx
    push ecx
    push edx
    
    ; Get ticket price
    mov eax, currentSeatType
    dec eax
    
    cmp currentMovieType, 0
    je SubTotal2D
    mov ebx, OFFSET seatPricesIMAX
    jmp GetSubTotal

SubTotal2D:
    mov ebx, OFFSET seatPrices2D

GetSubTotal:
    mov ecx, [ebx + eax*4]
    mov eax, currentSeatQty
    mul ecx  ; Ticket subtotal
    
    ; Add combo if selected
    cmp currentCombo, 0
    je SubTotalDone
    
    push eax
    mov eax, currentCombo
    dec eax
    mov ebx, OFFSET comboPrices
    mov ecx, [ebx + eax*4]
    mov eax, currentComboQty
    mul ecx
    mov ebx, eax  ; Combo total
    pop eax
    add eax, ebx

SubTotalDone:
    pop edx
    pop ecx
    pop ebx
    ret
CalculateCurrentTransactionSubtotal ENDP

; Update grand total revenue
UpdateGrandTotal PROC
    push eax
    
    mov eax, totalTicketRevenue
    add eax, totalComboRevenue
    add eax, totalSSTRevenue
    mov totalRevenueAllTime, eax
    
    pop eax
    ret
UpdateGrandTotal ENDP

; Generate comprehensive revenue report
GenerateRevenueReport PROC
    push eax
    push ebx
    push edx
    
ReportMenuLoop:
    call Clrscr
    mov edx, OFFSET reportMenu
    call DisplayHeaderGreen
    
    mov edx, OFFSET prompt2
    call WriteString
    call ReadChar
    call WriteChar
    call CrLf
    
    cmp al, '1'
    je ShowRevenueReport
    cmp al, '2'
    je ResetRevenueData
    cmp al, '3'
    je ReportMenuEnd
    
	call DisplayInvalidChoice
    jmp ReportMenuLoop

ShowRevenueReport:
    call DisplayRevenueReport
    jmp ReportMenuLoop

ResetRevenueData:
    call ResetAllRevenueData
    jmp ReportMenuLoop

ReportMenuEnd:
    mov al, '3'  ; Return value for dashboard navigation
    
    pop edx
    pop ebx
    pop eax
    ret
GenerateRevenueReport ENDP

; Display the complete revenue report
DisplayRevenueReport PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    
    call Clrscr
    
    ; Check if there's any revenue data
    mov eax, totalRevenueAllTime
    cmp eax, 0
    je NoRevenueData
    
    ; Display report header
    mov edx, OFFSET reportHeader
    call DisplayHeaderGreen
    call CrLf
    
    ; Display current date/time
    INVOKE GetLocalTime, ADDR sysTime
    mov edx, OFFSET receiptDateLabel
    call WriteString
    movzx eax, sysTime.wMonth
    call WriteDec
    mov edx, OFFSET slashChar
    call WriteString
    movzx eax, sysTime.wDay
    call WriteDec
    mov edx, OFFSET slashChar
    call WriteString
    movzx eax, sysTime.wYear
    call WriteDec
    
    mov al, ' '
    call WriteChar
    mov edx, OFFSET receiptTimeLabel
    call WriteString
    movzx eax, sysTime.wHour
    call WriteDec
    mov edx, OFFSET colonChar
    call WriteString
    movzx eax, sysTime.wMinute
    cmp eax, 10
    jae ShowMinutes
    mov al, '0'
    call WriteChar
ShowMinutes:
    movzx eax, sysTime.wMinute
    call WriteDec
    call CrLf
    call CrLf
    
    ; Revenue breakdown
    call DisplayRevenueBreakdown
    call CrLf
    
    ; Transaction statistics
    call DisplayTransactionStats
    call CrLf
    
    ; Revenue by movie
    call DisplayMovieRevenue
    call CrLf
    
    ; Revenue by seat type
    call DisplaySeatTypeRevenue
    call CrLf
    
    ; Display footer
    mov edx, OFFSET revenueReportFooter
    call WriteString
    
    jmp ReportDisplayEnd

NoRevenueData:
    mov edx, OFFSET noRevenueDataMsg
    call WriteString

ReportDisplayEnd:
    mov edx, OFFSET pressAnyKeyMsg
    call WriteString
    call ReadChar
    
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
DisplayRevenueReport ENDP

; Display revenue breakdown section
DisplayRevenueBreakdown PROC
    push eax
    push edx
    
    ; Ticket revenue
    mov edx, OFFSET ticketRevenueLabel
    call WriteString
    mov eax, totalTicketRevenue
    call DisplayRevenueAmount
    call CrLf
    
    ; Combo revenue
    mov edx, OFFSET comboRevenueLabel
    call WriteString
    mov eax, totalComboRevenue
    call DisplayRevenueAmount
    call CrLf
    
    ; SST revenue
    mov edx, OFFSET sstRevenueLabel
    call WriteString
    mov eax, totalSSTRevenue
    call DisplayRevenueAmount
    call CrLf
    
    ; Separator
    mov al, '-'
    mov ecx, 47
PrintRevenueDashes:
    call WriteChar
    loop PrintRevenueDashes
    call CrLf
    
    ; Grand total
    mov edx, OFFSET grandTotalLabel
    call WriteString
    mov eax, totalRevenueAllTime
    call DisplayRevenueAmount
    call CrLf
    
    pop edx
    pop eax
    ret
DisplayRevenueBreakdown ENDP

; Display transaction statistics
DisplayTransactionStats PROC
    push eax
    push edx
    
    call CrLf
    mov edx, OFFSET ticketsSoldLabel
    call WriteString
    mov eax, totalTicketsSold
    call WriteDec
    call CrLf
    
    mov edx, OFFSET combosSoldLabel
    call WriteString
    mov eax, totalCombosSold
    call WriteDec
    call CrLf
    
    mov edx, OFFSET transactionsLabel
    call WriteString
    mov eax, totalTransactions
    call WriteDec
    call CrLf
    
    pop edx
    pop eax
    ret
DisplayTransactionStats ENDP

; Display revenue by movie
DisplayMovieRevenue PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    
    mov edx, OFFSET movieRevenueHeader
    call WriteString
    
    mov ecx, MovieCount
    mov ebx, 0  ; Movie index
    mov esi, OFFSET MovieName
    
MovieRevenueLoop:
    cmp ecx, 0
    je MovieRevenueEnd
    
    ; Display movie name
    mov edx, esi
    call WriteString
    mov al, ':'
    call WriteChar
    mov al, ' '
    call WriteChar
    mov al, 'R'
    call WriteChar
    mov al, 'M'
    call WriteChar
    
    ; Display revenue for this movie
    mov eax, ebx
    shl eax, 2
    mov edx, [movieRevenue + eax]
    mov eax, edx
    call DisplayRevenueAmount
    
    ; Display tickets sold
    mov al, ' '
    call WriteChar
    mov al, '('
    call WriteChar
    mov eax, ebx
    shl eax, 2
    mov edx, [movieTicketsSold + eax]
    mov eax, edx
    call WriteDec
    mov al, ' '
    call WriteChar
    mov al, 't'
    call WriteChar
    mov al, 'i'
    call WriteChar
    mov al, 'c'
    call WriteChar
    mov al, 'k'
    call WriteChar
    mov al, 'e'
    call WriteChar
    mov al, 't'
    call WriteChar
    mov al, 's'
    call WriteChar
    mov al, ')'
    call WriteChar
    call CrLf
    
    add esi, Movie_NameSize
    inc ebx
    dec ecx
    jmp MovieRevenueLoop

MovieRevenueEnd:
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
DisplayMovieRevenue ENDP

; Display revenue by seat type
DisplaySeatTypeRevenue PROC
    push eax
    push edx
    
    mov edx, OFFSET seatTypeHeader
    call WriteString
    
    mov edx, OFFSET standardRevenueLabel
    call WriteString
    mov eax, standardRevenue
    call DisplayRevenueAmount
    call CrLf
    
    mov edx, OFFSET premiumRevenueLabel
    call WriteString
    mov eax, premiumRevenue
    call DisplayRevenueAmount
    call CrLf
    
    mov edx, OFFSET coupleRevenueLabel
    call WriteString
    mov eax, coupleRevenue
    call DisplayRevenueAmount
    call CrLf
    
    pop edx
    pop eax
    ret
DisplaySeatTypeRevenue ENDP

; Display revenue amount with proper decimal formatting
DisplayRevenueAmount PROC
    push eax
    push ebx
    push edx
    
    ; Convert cents to RM
    mov ebx, 100
    xor edx, edx
    div ebx  ; EAX = whole RM, EDX = cents
    
    push edx
    call WriteDec  ; Display whole part
    
    mov edx, OFFSET decimalPoint
    call WriteString
    
    pop eax  ; Get cents
    cmp eax, 10
    jae ShowTwoCents
    mov al, '0'
    call WriteChar
    pop eax
    push eax

ShowTwoCents:
    call WriteDec
    
    pop edx
    pop ebx
    pop eax
    ret
DisplayRevenueAmount ENDP

; Reset all revenue data
ResetAllRevenueData PROC
    push eax
    push ecx
    push edx
    push edi
    
    ; Confirm reset
    mov edx, OFFSET resetConfirmMsg
    call WriteString
    call ValidateYNInput
    
    cmp al, 'Y'
    je DoReset
    cmp al, 'y'
    je DoReset
    jmp ResetEnd

DoReset:
    ; Clear all revenue counters
    mov totalTicketRevenue, 0
    mov totalComboRevenue, 0
    mov totalSSTRevenue, 0
    mov totalRevenueAllTime, 0
    mov totalTicketsSold, 0
    mov totalCombosSold, 0
    mov totalTransactions, 0
    mov standardRevenue, 0
    mov premiumRevenue, 0
    mov coupleRevenue, 0
    
    ; Clear movie revenue arrays
    mov edi, OFFSET movieRevenue
    mov ecx, Movie_MAXCount
    xor eax, eax
    rep stosd
    
    mov edi, OFFSET movieTicketsSold
    mov ecx, Movie_MAXCount
    xor eax, eax
    rep stosd
    
    mov edx, OFFSET resetSuccessMsg
    call WriteString

ResetEnd:
    mov edx, OFFSET pressAnyKeyMsg
    call WriteString
    call ReadChar
    
    pop edi
    pop edx
    pop ecx
    pop eax
    ret
ResetAllRevenueData ENDP

; Admin movie management portal
AdminMovieManagement PROC
    push eax
    push edx
    
AdminMovieLoop:
    call Clrscr
    mov edx, OFFSET adminMovieHeader
    call DisplayHeaderGreen
    call ReadChar
    call WriteChar
    call CrLf
    
    cmp al, '1'
    je AddNewMovie
    cmp al, '2'
    je RemoveMovie
    cmp al, '3'
    je ViewAllMovies
    cmp al, '4'
    je BackToAdminPortal
    
	call DisplayInvalidChoice
    jmp AdminMovieLoop

AddNewMovie:
    call AddMovieToDatabase
    jmp AdminMovieLoop

RemoveMovie:
    call RemoveMovieFromDatabase
    jmp AdminMovieLoop

ViewAllMovies:
    call DisplayAllMovies
    jmp AdminMovieLoop

BackToAdminPortal:
    jmp AdminMovieEnd

AdminMovieEnd:
    pop edx
    pop eax
    ret
AdminMovieManagement ENDP

; Add movie to database
; Add movie to database - UPDATED to use dynamic arrays
AddMovieToDatabase PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    push edi
    
    ; Check if we've reached maximum movies
    mov eax, movieCountDynamic  ; Use dynamic count
    cmp eax, MAX_MOVIES
    jae MaxMoviesReached
    
    ; Clear temp buffers
    mov edi, OFFSET tempMovieName
    mov ecx, MOVIE_NAME_SIZE
    xor eax, eax
    rep stosb
    
    mov edi, OFFSET tempMovieDesc
    mov ecx, MOVIE_DESC_SIZE
    xor eax, eax
    rep stosb
    
    ; Get movie name
    mov edx, OFFSET addMoviePrompt
    call WriteString
    mov edx, OFFSET tempMovieName
    mov ecx, MOVIE_NAME_SIZE
    call ReadString
    
    ; Get movie description
    mov edx, OFFSET addDescPrompt
    call WriteString
    mov edx, OFFSET tempMovieDesc
    mov ecx, MOVIE_DESC_SIZE
    call ReadString
    
    ; Add to database
    mov eax, movieCountDynamic
    mov ebx, MOVIE_NAME_SIZE
    mul ebx
    mov edi, OFFSET movieDatabase
    add edi, eax
    mov esi, OFFSET tempMovieName
    call CopyMovieString
    
    mov eax, movieCountDynamic
    mov ebx, MOVIE_DESC_SIZE
    mul ebx
    mov edi, OFFSET movieDescriptions
    add edi, eax
    mov esi, OFFSET tempMovieDesc
    call CopyMovieString
    
    ; Set movie as active
    mov eax, movieCountDynamic
    shl eax, 2
    mov edi, OFFSET movieStatusDynamic  ; Use dynamic status
    add edi, eax
    mov DWORD PTR [edi], 1
    
    ; Increment movie count
    inc movieCountDynamic  ; Use dynamic count
    
    mov edx, OFFSET movieAddedMsg
    call WriteString
    jmp AddMovieEnd

MaxMoviesReached:
    mov edx, OFFSET maxMoviesReachedMsg
    call WriteString

AddMovieEnd:
    call ReadChar
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
AddMovieToDatabase ENDP

; Remove movie from database (mark as inactive)
RemoveMovieFromDatabase PROC
    push eax
    push ebx
    push edx
    
    ; Display current movies
    call DisplayAllMovies
    
    ; Get movie number to remove
    mov edx, OFFSET removeMoviePrompt
    call WriteString
    call ReadInt
    
    ; Validate input
    cmp eax, 1
    jl InvalidRemoveChoice
    cmp eax, movieCount
    jg InvalidRemoveChoice
    
    ; Mark movie as inactive
    dec eax  ; Convert to 0-based
    shl eax, 2
    mov ebx, OFFSET movieStatus
    add ebx, eax
    mov DWORD PTR [ebx], 0  ; Mark as inactive
    
    mov edx, OFFSET movieRemovedMsg
    call WriteString
    jmp RemoveMovieEnd

InvalidRemoveChoice:
    mov edx, OFFSET movieNotFoundMsg
    call WriteString

RemoveMovieEnd:
    call ReadChar
    pop edx
    pop ebx
    pop eax
    ret
RemoveMovieFromDatabase ENDP

; Display all movies for admin - UPDATED to use correct status variables
DisplayAllMovies PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    
    call CrLf
    mov edx, OFFSET adminMovieHeader
    call WriteString
    
    mov ecx, movieCount
    mov esi, OFFSET movieDatabase
    mov ebx, 1
    
DisplayAllLoop:
    cmp ecx, 0
    je DisplayAllEnd
    
    ; Show movie number and name
    mov eax, ebx
    call WriteDec
    mov edx, OFFSET movieOptionSuffix
    call WriteString
    mov edx, esi
    call WriteString
    
    ; Show status - FIXED to use correct status variables
    push ecx
    mov eax, ebx
    dec eax
    shl eax, 2
    mov edx, OFFSET movieStatusDynamic  ; Use the dynamic status array
    add edx, eax
    mov eax, [edx]
    cmp eax, 1
    je ShowActive
    mov edx, OFFSET inactiveStatus
    jmp ShowStatus
ShowActive:
    mov edx, OFFSET activeStatus
ShowStatus:
    call WriteString
    pop ecx
    call CrLf
    
    add esi, MOVIE_NAME_SIZE
    inc ebx
    dec ecx
    jmp DisplayAllLoop

DisplayAllEnd:
    call CrLf
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
DisplayAllMovies ENDP
; ========== ADMIN MOVIE MANAGEMENT PROCEDURES ==========
InitializeMovieData PROC
	push eax
	push ecx
	push esi
	push edi

	mov MovieCount, 3

	; Initialize Movie 1
	mov edi, OFFSET MovieName
	mov ecx, Movie_NameSize
	xor eax, eax
	rep stosb

	mov esi, OFFSET initMovie1
	mov edi, OFFSET MovieName
	mov ecx, SIZEOF initMovie1
	rep movsb

	mov edi, OFFSET MovieDesc
	mov ecx, Movie_DescSize
	xor eax, eax
	rep stosb

	mov esi, OFFSET initDesc1
	mov edi, OFFSET MovieDesc
	mov ecx, SIZEOF initDesc1
	rep movsb

	; Initialize showtimes for Movie 1
	mov edi, OFFSET MovieShow
	mov esi, OFFSET MovieTime1
	mov ecx, SIZEOF MovieTime1
	rep movsb

	mov esi, OFFSET MovieTime2
	mov ecx, SIZEOF MovieTime2
	rep movsb

	mov esi, OFFSET MovieTime3
	mov ecx, SIZEOF MovieTime3
	rep movsb

	mov esi, OFFSET MovieTime4
	mov ecx, SIZEOF MovieTime4
	rep movsb

	mov dword ptr [MovieStatus], 1

	; Initialize Movie 2
	mov edi, OFFSET MovieName + Movie_NameSize
	mov ecx, Movie_NameSize
	xor eax, eax
	rep stosb

	mov esi, OFFSET initMovie2
	mov edi, OFFSET MovieName + Movie_NameSize
	mov ecx, SIZEOF initMovie2
	rep movsb

	mov edi, OFFSET MovieDesc + Movie_DescSize
	mov ecx, Movie_DescSize
	xor eax, eax
	rep stosb

	mov esi, OFFSET initDesc2
	mov edi, OFFSET MovieDesc + Movie_DescSize
	mov ecx, SIZEOF initDesc2
	rep movsb

	; Initialize showtimes for Movie 2
	mov edi, OFFSET MovieShow
	add edi, MAXShowtimes * TimeSize
	mov esi, OFFSET MovieTime1
	mov ecx, SIZEOF MovieTime1
	rep movsb

	mov esi, OFFSET MovieTime2
	mov ecx, SIZEOF MovieTime2
	rep movsb

	mov esi, OFFSET MovieTime3
	mov ecx, SIZEOF MovieTime3
	rep movsb

	mov esi, OFFSET MovieTime4
	mov ecx, SIZEOF MovieTime4
	rep movsb

	mov dword ptr [MovieStatus + 4], 1

	; Initialize Movie 3
	mov edi, OFFSET MovieName + (2 * Movie_NameSize)
	mov ecx, Movie_NameSize
	xor eax, eax
	rep stosb

	mov esi, OFFSET initMovie3
	mov edi, OFFSET MovieName + (2 * Movie_NameSize)
	mov ecx, SIZEOF initMovie3
	rep movsb

	mov edi, OFFSET MovieDesc + (2 * Movie_DescSize)
	mov ecx, Movie_DescSize
	xor eax, eax
	rep stosb

	mov esi, OFFSET initDesc3
	mov edi, OFFSET MovieDesc + (2 * Movie_DescSize)
	mov ecx, SIZEOF initDesc3
	rep movsb

	; Initialize showtimes for Movie 3
	mov edi, OFFSET MovieShow
	add edi, 2 * MAXShowtimes * TimeSize
	mov esi, OFFSET MovieTime1
	mov ecx, SIZEOF MovieTime1
	rep movsb

	mov esi, OFFSET MovieTime2
	mov ecx, SIZEOF MovieTime2
	rep movsb

	mov esi, OFFSET MovieTime3
	mov ecx, SIZEOF MovieTime3
	rep movsb

	mov esi, OFFSET MovieTime4
	mov ecx, SIZEOF MovieTime4
	rep movsb

	mov dword ptr [MovieStatus + 8], 1

	; Update pricing arrays from admin-controlled values
	call UpdatePricingArrays

	pop edi
	pop esi
	pop ecx
	pop eax
	ret
InitializeMovieData ENDP

; Update pricing arrays from admin variables
UpdatePricingArrays PROC
	push eax
	push esi
	push edi

	; Update 2D pricing array
	mov esi, OFFSET Price2D1
	mov edi, OFFSET seatPrices2D
	mov eax, [esi]
	mov [edi], eax
	mov eax, Price2D2
	mov [edi+4], eax
	mov eax, Price2D3
	mov [edi+8], eax

	; Update IMAX pricing array
	mov edi, OFFSET seatPricesIMAX
	mov eax, PriceIM1
	mov [edi], eax
	mov eax, PriceIM2
	mov [edi+4], eax
	mov eax, PriceIM3
	mov [edi+8], eax

	; Update combo pricing array
	mov edi, OFFSET comboPrices
	mov eax, ComboA
	mov [edi], eax
	mov eax, ComboB
	mov [edi+4], eax
	mov eax, ComboC
	mov [edi+8], eax
	mov eax, ComboX
	mov [edi+12], eax

	pop edi
	pop esi
	pop eax
	ret
UpdatePricingArrays ENDP

displayMovieList PROC
	push eax
	push ebx
	push ecx
	push edx
	push esi
	push edi

	call Clrscr
	mov edx, OFFSET ListHeader
	call DisplayHeaderGreen

	mov ecx, MovieCount
	mov esi, OFFSET MovieName
	mov edi, OFFSET MovieDesc
	mov ebx, OFFSET MovieStatus

displayMovieLoop:
	cmp ecx, 0
	je displayDone

	mov edx, esi
	call WriteString
	mov al, ' '
	call WriteChar

	mov eax, [ebx]
	cmp eax, 1
	je show1
	cmp eax, 2
	je show2
	cmp eax, 3
	je show3

show1:
	mov edx, OFFSET status1
	call WriteString
	jmp showDone

show2:
	mov edx, OFFSET status2
	call WriteString
	jmp showDone
	
show3:
	mov edx, OFFSET status3
	call WriteString

showDone:
	call CrLf

	mov edx, edi
	call WriteString
	call CrLf
	call CrLf

	add esi, Movie_NameSize
	add edi, Movie_DescSize
	add ebx, 4
	dec ecx
	jmp displayMovieLoop

displayDone:
	mov edx, OFFSET ListFooter1
	call WriteString

pressEnter:
	call ReadChar
	cmp al, 0DH
	jne pressEnter

	pop edi
	pop esi
	pop edx
	pop ecx
	pop ebx
	pop eax
	ret
displayMovieList ENDP

AddNewMovie PROC
	push eax
	push ebx
	push ecx
	push edx
	push esi
	push edi

	mov eax, MovieCount
	cmp eax, Movie_MAXCount
	jae MovieListFull
	
NewMovie:
	call Clrscr
	mov edx, OFFSET msg101
	call WriteString
	mov edx, OFFSET bufferName
	mov ecx, Movie_NameSize
	call ReadString
	call CrLf

	mov edx, OFFSET msg102
	call WriteString
	mov edx, OFFSET bufferDesc
	mov ecx, Movie_DescSize
	call ReadString

ConfirmMovie:
	mov edx, OFFSET msg103
	call WriteString
	call ReadChar
	call WriteChar
	call CrLf

	cmp al, 'y'
	je SaveMovie
	cmp al, 'Y'
	je SaveMovie
	cmp al, 'n'
	je NewMovie
	cmp al, 'N'
	je NewMovie
	jmp ConfirmMovie

SaveMovie:
	mov eax, MovieCount 
	mov esi, OFFSET bufferName 
	mov edi, OFFSET MovieName 
	mov ecx, Movie_NameSize 
	mul ecx 
	add edi, eax 
	mov ecx, Movie_NameSize 
	rep movsb

	mov eax, MovieCount
	mov esi, OFFSET bufferDesc
	mov edi, OFFSET MovieDesc
	mov ecx, Movie_DescSize
	mul ecx
	add edi, eax
	mov ecx, Movie_DescSize
	rep movsb

	mov eax, MovieCount
	shl eax, 2
	mov edi, OFFSET MovieStatus
	add edi, eax
	mov dword ptr [edi], 1

	inc MovieCount

	mov edx, OFFSET msg104
	call WriteString
	call CrLf
	jmp AddMovieEnd

MovieListFull:
	mov edx, OFFSET msg105
	call WriteString
	call CrLf

AddMovieEnd:
	pop edi
	pop esi
	pop edx
	pop ecx
	pop ebx
	pop eax
	ret
AddNewMovie ENDP

UpdateMovieStatus PROC
	push eax
	push ebx
	push ecx
	push edx
	push esi

SelectMovie:
	call Clrscr
	mov edx, OFFSET msg110
	call WriteString

	mov eax, MovieCount
	call WriteDec

	mov edx, OFFSET msg111
	call WriteString

	call ReadDec
	mov ecx, eax

	cmp ecx, 1
	jl SelectMovie
	cmp ecx, MovieCount
	jg SelectMovie
	dec ecx

	mov eax, ecx
	shl eax, 2
	mov esi, OFFSET MovieStatus
	add esi, eax

ConfirmUpdate:
	mov eax, [esi]
	cmp eax, 1
	je ask1
	cmp eax, 2
	je ask2
	cmp eax, 3
	je ask3

ask1:
	mov edx, OFFSET msg112
	call WriteString
	jmp askConfirm

ask2:
	mov edx, OFFSET msg113
	call WriteString
	jmp askConfirm

ask3:
	mov edx, OFFSET msg114
	call WriteString
	call CrLf
	jmp UpdateMovieEnd

askConfirm:
	call ReadChar
	call WriteChar
	call CrLf

	cmp al, 'Y'
	je DoUpdate
	cmp al, 'y'
	je DoUpdate
	cmp al, 'N'
	je SelectMovie
	cmp al, 'n'
	je SelectMovie
	jmp askConfirm

DoUpdate:
	inc dword ptr [esi]
	cmp dword ptr [esi], 3
	jg statusEnded
	jmp statusOK
	
statusEnded:
	mov dword ptr [esi], 3
	mov edx, OFFSET msg114
	call WriteString
	call CrLf
	jmp UpdateMovieEnd

statusOK:
	mov edx, OFFSET msg115
	call WriteString
	call CrLf

UpdateMovieEnd:
	pop esi
	pop edx
	pop ecx
	pop ebx
	pop eax
	ret
UpdateMovieStatus ENDP

RemoveSelectMovie PROC
	push eax
	push ebx
	push ecx
	push edx
	push esi
	push edi
	push ebp

SelectMovie:
	call Clrscr
	mov edx, OFFSET msg110
	call WriteString

	mov eax, MovieCount
	call WriteDec

	mov edx, OFFSET msg111
	call WriteString

	call ReadDec
	mov ecx, eax

	cmp ecx, 1
	jl SelectMovie
	cmp ecx, MovieCount
	jg SelectMovie
	dec ecx

	mov eax, ecx
	mov ebx, Movie_NameSize
	mul ebx
	mov esi, OFFSET MovieName
	add esi, eax

	mov eax, ecx
	mov ebx, Movie_DescSize
	mul ebx
	mov edi, OFFSET MovieDesc
	add edi, eax

	mov eax, ecx
	mov ebx, 4
	mul ebx
	mov ebp, OFFSET MovieStatus
	add ebp, eax

removeConfirm:
	mov edx, OFFSET msg121
	call WriteString
	call ReadChar
	call WriteChar
	call CrLf

	cmp al, 'Y'
	je DoRemove
	cmp al, 'y'
	je DoRemove
	cmp al, 'N'
	je SelectMovie
	cmp al, 'n'
	je SelectMovie
	jmp removeConfirm

DoRemove:
	mov ebx, ecx

ShiftLoop:
	cmp ebx, MovieCount
	jge ShiftDone

	; Shift movie names
	mov eax, ebx
	add eax, 1
	mov edx, Movie_NameSize
	mul edx
	mov esi, OFFSET MovieName
	add esi, eax
	
	mov eax, ebx
	mov edx, Movie_NameSize
	mul edx
	mov edi, OFFSET MovieName
	add edi, eax
	
	mov ecx, Movie_NameSize
	rep movsb

	; Shift movie descriptions
	mov eax, ebx
	add eax, 1
	mov edx, Movie_DescSize
	mul edx
	mov esi, OFFSET MovieDesc
	add esi, eax
	
	mov eax, ebx
	mov edx, Movie_DescSize
	mul edx
	mov edi, OFFSET MovieDesc
	add edi, eax
	
	mov ecx, Movie_DescSize
	rep movsb

	; Shift movie status
	mov eax, ebx
	add eax, 1
	shl eax, 2
	mov esi, OFFSET MovieStatus
	add esi, eax
	mov eax, [esi]

	mov edx, ebx
	shl edx, 2
	mov edi, OFFSET MovieStatus
	add edi, edx
	mov [edi], eax

	inc ebx
	jmp ShiftLoop

ShiftDone:
	dec MovieCount

	mov edx, OFFSET msg122
	call WriteString
	call CrLf

	pop ebp
	pop edi
	pop esi
	pop edx
	pop ecx
	pop ebx
	pop eax
	ret
RemoveSelectMovie ENDP

; Adjust pricing procedure - Main pricing adjustment handler
AdjustPricing PROC
	push eax
	push ebx
	push ecx
	push edx
	push esi
	push edi

AdjustMenu:
	call CrLf
	mov edx, OFFSET ListHeader2
	call DisplayHeaderGreen

	; Display current pricing with proper decimal formatting
	mov edx, OFFSET msg201
	call WriteString
	mov eax, Price2D1
	mov ebx, 100
	mov ecx, 2
	call TwoDecimal
	call CrLf

	mov edx, OFFSET msg202
	call WriteString
	mov eax, Price2D2
	mov ebx, 100
	mov ecx, 2
	call TwoDecimal
	call CrLf

	mov edx, OFFSET msg203
	call WriteString
	mov eax, Price2D3
	mov ebx, 100
	mov ecx, 2
	call TwoDecimal
	call CrLf

	mov edx, OFFSET msg204
	call WriteString
	mov eax, PriceIM1
	mov ebx, 100
	mov ecx, 2
	call TwoDecimal
	call CrLf

	mov edx, OFFSET msg205
	call WriteString
	mov eax, PriceIM2
	mov ebx, 100
	mov ecx, 2
	call TwoDecimal
	call CrLf

	mov edx, OFFSET msg206
	call WriteString
	mov eax, PriceIM3
	mov ebx, 100
	mov ecx, 2
	call TwoDecimal
	call CrLf

	mov edx, OFFSET msg207
	call WriteString
	mov eax, ComboA
	mov ebx, 100
	mov ecx, 2
	call TwoDecimal
	call CrLf

	mov edx, OFFSET msg208
	call WriteString
	mov eax, ComboB
	mov ebx, 100
	mov ecx, 2
	call TwoDecimal
	call CrLf

	mov edx, OFFSET msg209
	call WriteString
	mov eax, ComboC
	mov ebx, 100
	mov ecx, 2
	call TwoDecimal
	call CrLf

	mov edx, OFFSET msg210
	call WriteString
	mov eax, ComboX
	mov ebx, 100
	mov ecx, 2
	call TwoDecimal
	call CrLf

	mov edx, OFFSET ListFooter1
	call WriteString
	call CrLf

pressEnter:
	call ReadChar
	cmp al, 0DH
	jne pressEnter

PriceOperation:
	mov edx, OFFSET menu2
	call WriteString

	mov edx, OFFSET prompt2
	call WriteString
	call ReadChar
	call WriteChar
	call CrLf

	cmp al, '1'
	je Adjust2D
	cmp al, '2'
	je AdjustIMAX
	cmp al, '3'
	je AdjustCombo
	cmp al, '4'
	je backDashboard
	jmp Invalid4

Adjust2D:
	call CrLf
	mov edx, OFFSET menu10
	call WriteString

	mov edx, OFFSET prompt4
	call WriteString
	call ReadChar
	call WriteChar
	call CrLf

	cmp al, '1'
	je New2D1
	cmp al, '2'
	je New2D2
	cmp al, '3'
	je New2D3
	cmp al, '4'
	je AdjustMenu
	jmp Adjust2D

New2D1:
	call CrLf
	mov edx, OFFSET msg220
	call WriteString
	call ReadInt
	mov ebx, 100
	imul eax, ebx
	mov Price2D1, eax
	call UpdatePricingArrays  ; Update arrays after price change
	jmp NewConfirm

New2D2:
	call CrLf
	mov edx, OFFSET msg220
	call WriteString
	call ReadInt
	mov ebx, 100
	imul eax, ebx
	mov Price2D2, eax
	call UpdatePricingArrays  ; Update arrays after price change
	jmp NewConfirm

New2D3:
	call CrLf
	mov edx, OFFSET msg220
	call WriteString
	call ReadInt
	mov ebx, 100
	imul eax, ebx
	mov Price2D3, eax
	call UpdatePricingArrays  ; Update arrays after price change
	jmp NewConfirm

AdjustIMAX:
	call CrLf
	mov edx, OFFSET menu11
	call WriteString

	mov edx, OFFSET prompt4
	call WriteString
	call ReadChar
	call WriteChar
	call CrLf

	cmp al, '1'
	je NewIM1
	cmp al, '2'
	je NewIM2
	cmp al, '3'
	je NewIM3
	cmp al, '4'
	je AdjustMenu
	jmp AdjustIMAX

NewIM1:
	call CrLf
	mov edx, OFFSET msg220
	call WriteString
	call ReadInt
	mov ebx, 100
	imul eax, ebx
	mov PriceIM1, eax
	call UpdatePricingArrays  ; Update arrays after price change
	jmp NewConfirm

NewIM2:
	call CrLf
	mov edx, OFFSET msg220
	call WriteString
	call ReadInt
	mov ebx, 100
	imul eax, ebx
	mov PriceIM2, eax
	call UpdatePricingArrays  ; Update arrays after price change
	jmp NewConfirm

NewIM3:
	call CrLf
	mov edx, OFFSET msg220
	call WriteString
	call ReadInt
	mov ebx, 100
	imul eax, ebx
	mov PriceIM3, eax
	call UpdatePricingArrays  ; Update arrays after price change
	jmp NewConfirm

AdjustCombo:
	call CrLf
	mov edx, OFFSET menu12
	call WriteString

	mov edx, OFFSET prompt4
	call WriteString
	call ReadChar
	call WriteChar
	call CrLf

	cmp al, '1'
	je NewComboA
	cmp al, '2'
	je NewComboB
	cmp al, '3'
	je NewComboC
	cmp al, '4'
	je AdjustMenu
	jmp AdjustCombo

NewComboA:
	call CrLf
	mov edx, OFFSET msg220
	call WriteString
	call ReadInt
	mov ebx, 100
	imul eax, ebx
	mov ComboA, eax
	call UpdatePricingArrays  ; Update arrays after price change
	jmp NewConfirm

NewComboB:
	call CrLf
	mov edx, OFFSET msg220
	call WriteString
	call ReadInt
	mov ebx, 100
	imul eax, ebx
	mov ComboB, eax
	call UpdatePricingArrays  ; Update arrays after price change
	jmp NewConfirm

NewComboC:
	call CrLf
	mov edx, OFFSET msg220
	call WriteString
	call ReadInt
	mov ebx, 100
	imul eax, ebx
	mov ComboC, eax
	call UpdatePricingArrays  ; Update arrays after price change
	jmp NewConfirm

NewConfirm:
	mov edx, OFFSET msg103
	call WriteString
	call ReadChar
	call WriteChar
	call CrLf

	cmp al, 'y'
	je NewDone
	cmp al, 'Y'
	je NewDone
	cmp al, 'n'
	je PriceOperation
	cmp al, 'N'
	je PriceOperation
	jmp NewConfirm

NewDone:
	mov edx, OFFSET msg221
	call WriteString
	call CrLf
	jmp AdjustPricingEnd

Invalid4:
	mov edx, OFFSET msg222
	call WriteString
	call CrLf
	jmp PriceOperation

backDashboard:
	mov edx, OFFSET msg503
	mov al, '4'  ; Set return value for dashboard navigation

AdjustPricingEnd:
	pop edi
	pop esi
	pop edx
	pop ecx
	pop ebx
	pop eax
	ret
AdjustPricing ENDP

; Set showtimes procedure
SetShowtimes PROC
	push eax
	push ebx
	push ecx
	push edx
	push esi
	push edi

ShowtimesList:
	call CrLf
	call displayShowtimesList

pressEnterShowtimes:
	call ReadChar
	cmp al, 0DH
	jne pressEnterShowtimes

ShowtimesMenuLoop:
	mov edx, OFFSET menu3
	call WriteString

	mov edx, OFFSET prompt3
	call WriteString
	call ReadChar
	call WriteChar
	call CrLf

	cmp al, '1'
	je AddTime
	cmp al, '2'
	je backDashboardShowtimes
	jmp InvalidShowtimes

AddTime:
	call AddShowtime
	call CrLf
	jmp SetShowtimesEnd

backDashboardShowtimes:
	call CrLf
	mov al, '2'  ; Set return value
	jmp SetShowtimesEnd

InvalidShowtimes:
	mov edx, OFFSET msg222
	call WriteString
	call CrLf
	jmp ShowtimesMenuLoop

SetShowtimesEnd:
	pop edi
	pop esi
	pop edx
	pop ecx
	pop ebx
	pop eax
	ret
SetShowtimes ENDP

; Display showtimes list
displayShowtimesList PROC
	pushad
	mov edx, OFFSET ListHeader
	call WriteString

	mov ecx, MovieCount
	mov esi, OFFSET MovieName
	xor ebx, ebx

NextMovieShowtime:
	cmp ecx, 0
	je DoneShowtimeList

	mov edx, esi
	call WriteString
	call CrLf

	push ecx
	mov eax, ebx
	shl eax, 2
	mov edi, OFFSET TimeCount
	add edi, eax
	mov eax, [edi]
	mov ecx, eax

	mov eax, ebx
	imul eax, MAXShowtimes * TimeSize
	mov edi, OFFSET MovieShow
	add edi, eax

ShowLoopShowtime:
	cmp ecx, 0
	je ShowDoneShowtime

	mov edx, edi
	call WriteString

	mov al, ' '
	call WriteChar
	mov al, ' '
	call WriteChar
	mov al, ' '
	call WriteChar

	add edi, TimeSize
	dec ecx
	jmp ShowLoopShowtime

ShowDoneShowtime:
	call CrLf
	call CrLf
	pop ecx

	add esi, Movie_NameSize
	inc ebx
	dec ecx
	jmp NextMovieShowtime

DoneShowtimeList:
	mov edx, OFFSET ListFooter1
	call WriteString
	call CrLf

	popad
	ret
displayShowtimesList ENDP

; Add showtime procedure
AddShowtime PROC
	pushad

SelectMovieShowtime:
	call CrLf

	mov edx, OFFSET msg110
	call WriteString

	mov eax, MovieCount
	call WriteDec

	mov edx, OFFSET msg111
	call WriteString

	call ReadInt
	dec eax
	mov edi, eax

	mov eax, MovieCount
	cmp edi, 0
	jl SelectMovieShowtime
	cmp edi, eax
	jge SelectMovieShowtime

PromptTime:
	mov edx, OFFSET msg301
	call WriteString
	mov edx, OFFSET bufferTime
	mov ecx, TimeSize
	call ReadString

	mov esi, OFFSET bufferTime
	mov al, [esi]
	cmp al, '0'
	jb InvalidFormat
	cmp al, '2'
	ja InvalidFormat

	mov ah, [esi + 1]
	cmp al, '2'
	jne CheckColonShowtime
	cmp ah, '0'
	jb InvalidFormat
	cmp ah, '3'
	ja InvalidFormat

CheckColonShowtime:
	mov al, [esi + 2]
	cmp al, ':'
	jne InvalidFormat

	mov al, [esi + 3]
	cmp al, '0'
	jb InvalidFormat
	cmp al, '5'
	ja InvalidFormat

	mov al, [esi + 4]
	cmp al, '0'
	jb InvalidFormat
	cmp al, '9'
	ja InvalidFormat

ConfirmAddShowtime:
	mov edx, OFFSET msg103
	call WriteString
	call ReadChar
	call WriteChar
	call CrLf

	cmp al, 'Y'
	je SetMovieIndexShowtime
	cmp al, 'y'
	je SetMovieIndexShowtime
	cmp al, 'N'
	je PromptTime
	cmp al, 'n'
	je PromptTime
	jmp ConfirmAddShowtime

SetMovieIndexShowtime:
	mov ebx, edi
	jmp SaveTimeShowtime

SaveTimeShowtime:
	mov eax, ebx
	shl eax, 2
	mov edi, OFFSET TimeCount
	add edi, eax
	mov ecx, [edi]

	cmp ecx, MAXShowtimes
	jae MaxReachedShowtime

	mov eax, ebx
	imul eax, (MAXShowtimes * TimeSize)
	mov edi, OFFSET MovieShow
	add edi, eax
	mov eax, ecx
	imul eax, TimeSize
	add edi, eax

	mov esi, OFFSET bufferTime
	mov ecx, TimeSize
	rep movsb

	mov eax, ebx
	shl eax, 2
	mov edi, OFFSET TimeCount
	add edi, eax
	inc dword ptr [edi]

	mov edx, OFFSET msg302
	call WriteString
	call CrLf
	jmp DoneAddShowtime

InvalidFormat:
	mov edx, OFFSET msg304
	call WriteString
	call CrLf
	jmp PromptTime

MaxReachedShowtime:
	mov edx, OFFSET msg303
	call WriteString
	call CrLf
	jmp DoneAddShowtime

DoneAddShowtime:
	popad
	ret
AddShowtime ENDP

; Two decimal display procedure for pricing
TwoDecimal PROC
	pushad
	mov edi, ecx
	xor esi, esi
	test eax, eax
	jns NumOk
	neg eax
	inc esi

NumOk:
	test ebx, ebx
	jns DenOk
	neg ebx
	inc esi

DenOk:
	xor edx, edx
	div ebx

	test esi, 1
	jz NoSign
	mov al, '-'
	call WriteChar

NoSign:
	push eax
	call WriteDec
	pop eax

	cmp edi, 0
	jz Done

	mov al, '.'
	call WriteChar

DecLoop:
	cmp edi, 0
	je Done

	mov eax, edx
	xor edx, edx
	mov ecx, 10
	mul ecx
	div ebx

	add al, '0'
	call WriteChar

	dec edi
	jmp DecLoop

Done:
	popad
	ret
TwoDecimal ENDP


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

	; Copy reward points (as WORD, not string)
	add edi, PHONE_SIZE                        ; Move to reward points field
	mov ax, predefReward1                      ; Load reward points value
	mov WORD PTR [edi], ax                     ; Store as WORD

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

	; Copy reward points (as WORD, not string)
	add edi, PHONE_SIZE                        ; Move to reward points field
	mov ax, predefReward2                      ; Load reward points value
	mov WORD PTR [edi], ax                     ; Store as WORD

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
	cmp eax, 4
	je GetRewardPoints
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
	jmp GetFieldEnd

GetRewardPoints:
	add edi, USERNAME_SIZE + PASSWORD_SIZE + EMAIL_SIZE + PHONE_SIZE
	jmp GetFieldEnd

GetFieldEnd:
	pop ecx
	ret
GetUserField ENDP

; Store current logged-in user information
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
	
	; Copy username to current user buffer
	mov esi, OFFSET inputUsername
	mov edi, OFFSET currentUser
	mov ecx, USERNAME_SIZE
	call CopyStringToBuffer
	
	; Find user index in database
	mov ebx, 0

FindUserIndexLoop:
	cmp ebx, userCount
	jae UserIndexNotFound

	mov eax, 0  ; Username field
	call GetUserField
	
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

; User Registration Procedure
PerformRegistration PROC
	push eax
	push ebx
	push edx
	
	; Display registration header
	mov edx, OFFSET registrationHeader
	call DisplayHeaderGreen

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
	call DisplayHeaderGreen
	mov attempts, 0

LoginLoop:
	mov eax, attempts
	cmp eax, maxAttempts
	jae MaxAttemptsReached

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
	call ValidateCredentials
	cmp eax, 1 
	je LoginSuccessful

	; Login failed
	inc attempts
	mov edx, OFFSET loginFailed
	call WriteString
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
    
    ; Call appropriate portal based on login type
    cmp ebx, 0
    je CallAdminPortal
    cmp ebx, 1
    je CallUserPortal
    jmp LoginEnd

CallAdminPortal:
    call AdminPortal
    jmp LoginEnd

CallUserPortal:
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


; View user profile - displays current logged-in user's information
ViewUserProfile PROC
	push eax
	push ebx
	push edx
	push ecx
	push esi
	push edi
	
	call Clrscr
	
ViewProfileLoop:
	; Display profile header
	mov edx, OFFSET profileHeader
	call DisplayHeaderGreen
	
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

	; Display reward points
	mov edx, OFFSET profileRewards
	call WriteString
	mov eax, 4		; reward points field
	call GetUserField	; EDI = pointer to reward points
	movzx eax, WORD PTR [edi] ; Load reward points (WORD)
	call WriteDec
	call CrLf
	
	mov edx, OFFSET editProfilePrompt
	call WriteString
	call ValidateYNInput	; <-- FIX: Use validation for Y/N input
	cmp al, 'Y'
	je CallEditProfile
	cmp al, 'y'
	je CallEditProfile
	; Only need to check for 'N'/'n' now
	jmp ProfileDisplayComplete

CallEditProfile:
	call EditUserProfile
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
	call DisplayHeaderGreen
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
	call DisplayInvalidChoice
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

BookingPortalLoop:

	mov edx, OFFSET bookingHeader
	call DisplayHeaderGreen
	call ReadChar
	call WriteChar
	call CrLf

	cmp al, '1'
	je Select2D
	cmp al, '2'
	je SelectIMAX
	cmp al, '3'
	je BackToPortal

	; Invalid choice
	call DisplayInvalidChoice
	jmp BookingPortalLoop

Select2D:
	mov currentMovieType, 0	; 0 = 2D
	call Show2DMovies
	jmp BookingPortalLoop

SelectIMAX:
	mov currentMovieType, 1	; 1 = IMAX
	call ShowIMAXMovies
	jmp BookingPortalLoop

BackToPortal:
	mov edx, OFFSET returnToPortal
	call WriteString
	call WaitMsg
	jmp BookingPortalEnd

BookingPortalEnd:
	pop edi
	pop esi
	pop ecx
	pop edx
	pop ebx
	pop eax
	ret
BookingPortal ENDP

; Dynamic 2D Movie Menu
Show2DMovies PROC
    push eax
    push ebx
    push edx
    push ecx
    push esi
    push edi
    
    call Clrscr

Movie2DLoop:
    call DisplayDynamic2DMovies
    call ReadInt
    call WriteChar
    call CrLf
    mov userChoice, eax

    ; Validate choice
    cmp eax, 1
    jl InvalidMovie2DChoice
    mov ebx, movieCount
    inc ebx  ; Add 1 for back option
    cmp eax, ebx
    jg InvalidMovie2DChoice
    
    ; Check if it's back option
    cmp eax, ebx
    je BackToBooking

    ; Valid movie choice - check if movie is active
    dec eax  ; Convert to 0-based index
    mov ebx, eax
    shl ebx, 2  ; multiply by 4 for DWORD array
    mov ecx, OFFSET movieStatus
    add ecx, ebx
    mov edx, [ecx]
    cmp edx, 1
    jne InvalidMovie2DChoice  ; Movie is inactive
    
    inc eax  ; Convert back to 1-based
    mov currentMovie, eax
    call ShowShowtimes
    jmp Movie2DLoop

InvalidMovie2DChoice:
	call DisplayInvalidChoice
    jmp Movie2DLoop

BackToBooking:
    call WaitMsg
    call Clrscr
    jmp Show2DMovieEnd

Show2DMovieEnd:
    pop edi
    pop esi
    pop ecx
    pop edx
    pop ebx
    pop eax
    ret
Show2DMovies ENDP

; Display dynamic 2D movies - FIXED to show complete range
DisplayDynamic2DMovies PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    
    ; Display header
    mov edx, OFFSET movies2DHeader
    call DisplayHeaderGreen
    
    ; Display each active movie
    mov ecx, movieCountDynamic  ; Use dynamic count
    mov esi, OFFSET movieDatabase
    mov ebx, 1  ; Option counter
    
DisplayMovieLoop:
    cmp ecx, 0
    je DisplayBackOption
    
    ; Check if movie is active
    push ecx
    mov eax, ebx
    dec eax  ; Convert to 0-based
    shl eax, 2  ; multiply by 4
    mov edx, OFFSET movieStatusDynamic  ; Use dynamic status
    add edx, eax
    mov eax, [edx]
    pop ecx
    
    cmp eax, 1
    jne SkipInactiveMovie
    
    ; Display movie option
    mov eax, ebx
    call WriteDec
    mov edx, OFFSET movieOptionSuffix
    call WriteString
    mov edx, esi
    call WriteString
    call CrLf
    
SkipInactiveMovie:
    add esi, MOVIE_NAME_SIZE
    inc ebx
    dec ecx
    jmp DisplayMovieLoop
    
DisplayBackOption:
    ; FIXED: Display complete range
    mov eax, ebx
    call WriteDec
    mov edx, OFFSET movieOptionSuffix
    call WriteString
    mov al, 'B'
    call WriteChar
    mov al, 'a'
    call WriteChar
    mov al, 'c'
    call WriteChar
    mov al, 'k'
    call WriteChar
    mov al, ' '
    call WriteChar
    mov al, 't'
    call WriteChar
    mov al, 'o'
    call WriteChar
    mov al, ' '
    call WriteChar
    mov al, 'B'
    call WriteChar
    mov al, 'o'
    call WriteChar
    mov al, 'o'
    call WriteChar
    mov al, 'k'
    call WriteChar
    mov al, 'i'
    call WriteChar
    mov al, 'n'
    call WriteChar
    mov al, 'g'
    call WriteChar
    mov al, ' '
    call WriteChar
    mov al, 'P'
    call WriteChar
    mov al, 'o'
    call WriteChar
    mov al, 'r'
    call WriteChar
    mov al, 't'
    call WriteChar
    mov al, 'a'
    call WriteChar
    mov al, 'l'
    call WriteChar
    call CrLf
    
    ; FIXED: Display complete footer with range
    mov al, '='
    mov ecx, 35
PrintEquals2D:
    call WriteChar
    loop PrintEquals2D
    call CrLf
    
    mov al, 'S'
    call WriteChar
    mov al, 'e'
    call WriteChar
    mov al, 'l'
    call WriteChar
    mov al, 'e'
    call WriteChar
    mov al, 'c'
    call WriteChar
    mov al, 't'
    call WriteChar
    mov al, ' '
    call WriteChar
    mov al, 'a'
    call WriteChar
    mov al, ' '
    call WriteChar
    mov al, 'm'
    call WriteChar
    mov al, 'o'
    call WriteChar
    mov al, 'v'
    call WriteChar
    mov al, 'i'
    call WriteChar
    mov al, 'e'
    call WriteChar
    mov al, ' '
    call WriteChar
    mov al, '('
    call WriteChar
    mov al, '1'
    call WriteChar
    mov al, '-'
    call WriteChar
    mov eax, ebx  ; Show the maximum option
    call WriteDec
    mov al, ')'
    call WriteChar
    mov al, ':'  ; FIXED: Complete the incomplete mov instruction
    call WriteChar
    mov al, ' '
    call WriteChar
    
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
DisplayDynamic2DMovies ENDP

; Similar procedure for IMAX movies
ShowIMAXMovies PROC
    push eax
    push ebx
    push edx
    push ecx
    push esi
    push edi
    
    call Clrscr

MovieIMAXLoop:
    call DisplayDynamicIMAXMovies
    call ReadInt
    call WriteChar
    call CrLf
    mov userChoice, eax
    
    ; Validate choice (same logic as 2D movies)
    cmp eax, 1
    jl InvalidMovieIMAXChoice
    mov ebx, movieCount
    inc ebx
    cmp eax, ebx
    jg InvalidMovieIMAXChoice
    
    cmp eax, ebx
    je BackToBookingIMAX

    ; Valid movie choice
    dec eax
    mov ebx, eax
    shl ebx, 2
    mov ecx, OFFSET movieStatus
    add ecx, ebx
    mov edx, [ecx]
    cmp edx, 1
    jne InvalidMovieIMAXChoice
    
    inc eax
    mov currentMovie, eax
    call ShowShowtimes
    jmp MovieIMAXLoop

InvalidMovieIMAXChoice:
	call DisplayInvalidChoice
    jmp MovieIMAXLoop

BackToBookingIMAX:
    call WaitMsg
    call Clrscr
    jmp ShowIMAXMovieEnd

ShowIMAXMovieEnd:
    pop edi
    pop esi
    pop ecx
    pop edx
    pop ebx
    pop eax
    ret
ShowIMAXMovies ENDP

; Display dynamic IMAX movies - FIXED to show complete range
DisplayDynamicIMAXMovies PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    
    ; Display header
    mov edx, OFFSET moviesIMAXHeader
    call DisplayHeaderGreen
    
    ; Display each active movie
    mov ecx, movieCountDynamic  ; Use dynamic count
    mov esi, OFFSET movieDatabase
    mov ebx, 1  ; Option counter
    
DisplayIMAXMovieLoop:
    cmp ecx, 0
    je DisplayIMAXBackOption
    
    ; Check if movie is active
    push ecx
    mov eax, ebx
    dec eax  ; Convert to 0-based
    shl eax, 2  ; multiply by 4
    mov edx, OFFSET movieStatusDynamic
    add edx, eax
    mov eax, [edx]
    pop ecx
    
    cmp eax, 1
    jne SkipInactiveIMAXMovie
    
    ; Display movie option
    mov eax, ebx
    call WriteDec
    mov edx, OFFSET movieOptionSuffix
    call WriteString
    mov edx, esi
    call WriteString
    mov al, ' '
    call WriteChar
    mov al, 'I'
    call WriteChar
    mov al, 'M'
    call WriteChar
    mov al, 'A'
    call WriteChar
    mov al, 'X'
    call WriteChar
    call CrLf
    
SkipInactiveIMAXMovie:
    add esi, MOVIE_NAME_SIZE
    inc ebx
    dec ecx
    jmp DisplayIMAXMovieLoop
    
DisplayIMAXBackOption:
    ; FIXED: Display complete range
    mov eax, ebx
    call WriteDec
    mov edx, OFFSET movieOptionSuffix
    call WriteString
    mov al, 'B'
    call WriteChar
    mov al, 'a'
    call WriteChar
    mov al, 'c'
    call WriteChar
    mov al, 'k'
    call WriteChar
    mov al, ' '
    call WriteChar
    mov al, 't'
    call WriteChar
    mov al, 'o'
    call WriteChar
    mov al, ' '
    call WriteChar
    mov al, 'B'
    call WriteChar
    mov al, 'o'
    call WriteChar
    mov al, 'o'
    call WriteChar
    mov al, 'k'
    call WriteChar
    mov al, 'i'
    call WriteChar
    mov al, 'n'
    call WriteChar
    mov al, 'g'
    call WriteChar
    mov al, ' '
    call WriteChar
    mov al, 'P'
    call WriteChar
    mov al, 'o'
    call WriteChar
    mov al, 'r'
    call WriteChar
    mov al, 't'
    call WriteChar
    mov al, 'a'
    call WriteChar
    mov al, 'l'
    call WriteChar
    call CrLf
    
    ; FIXED: Display complete footer with range
    mov al, '='
    mov ecx, 35
PrintEqualsIMAX:
    call WriteChar
    loop PrintEqualsIMAX
    call CrLf
    
    mov al, 'S'
    call WriteChar
    mov al, 'e'
    call WriteChar
    mov al, 'l'
    call WriteChar
    mov al, 'e'
    call WriteChar
    mov al, 'c'
    call WriteChar
    mov al, 't'
    call WriteChar
    mov al, ' '
    call WriteChar
    mov al, 'a'
    call WriteChar
    mov al, ' '
    call WriteChar
    mov al, 'm'
    call WriteChar
    mov al, 'o'
    call WriteChar
    mov al, 'v'
    call WriteChar
    mov al, 'i'
    call WriteChar
    mov al, 'e'
    call WriteChar
    mov al, ' '
    call WriteChar
    mov al, '('
    call WriteChar
    mov al, '1'
    call WriteChar
    mov al, '-'
    call WriteChar
    mov eax, ebx  ; Show the maximum option
    call WriteDec
    mov al, ')'
    call WriteChar
    mov al, ':'
    call WriteChar
    mov al, ' '
    call WriteChar
    
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
DisplayDynamicIMAXMovies ENDP

;Show showtimes for selected movie - UPDATED for dynamic display
ShowShowtimes PROC
    push eax
    push ebx
    push edx
    push ecx
    push esi
    push edi

    call Clrscr

ShowtimesLoop:
    ; Display dynamic showtimes
    call DisplayDynamicShowtimes
    
    call ReadInt
    call WriteChar
    call CrLf
    mov userChoice, eax

    ; Validate choice range
    cmp eax, 1
    jl InvalidShowtimeChoice
    cmp eax, maxShowtimeOption
    jg InvalidShowtimeChoice
    
    ; Check if it's the back option
    mov ebx, maxShowtimeOption
    cmp eax, ebx
    je BackToMovies

    ; Valid showtime choice
    mov currentShowtime, eax
    call ShowSeatSelection
    jmp ShowtimesLoop

InvalidShowtimeChoice:
	call DisplayInvalidChoice
    jmp ShowtimesLoop

BackToMovies:
    call WaitMsg
    call Clrscr
    jmp ShowShowtimesEnd

ShowShowtimesEnd:
    pop edi
    pop esi
    pop ecx
    pop edx
    pop ebx
    pop eax
    ret
ShowShowtimes ENDP

; Dynamic showtime display procedure - FIXED to show complete range
DisplayDynamicShowtimes PROC
    pushad
    
    ; Get current movie index (1-based to 0-based)
    mov eax, currentMovie
    dec eax
    mov ebx, eax
    
    ; Display header
    mov edx, OFFSET showtimeMenuHeader
    call DisplayHeaderGreen
    
    ; Get number of showtimes for this movie
    mov eax, ebx
    shl eax, 2  ; multiply by 4 for DWORD array
    mov esi, OFFSET TimeCount
    add esi, eax
    mov ecx, [esi]  ; ECX = number of showtimes for this movie
    
    ; Calculate starting position in MovieShow array
    mov eax, ebx
    imul eax, MAXShowtimes * TimeSize
    mov edi, OFFSET MovieShow
    add edi, eax
    
    ; Display each showtime with option number
    mov ebx, 1  ; Option counter
    
DisplayShowtimeLoop:
    cmp ecx, 0
    je DisplayBackOption
    
    ; Display option number
    mov eax, ebx
    call WriteDec
    mov edx, OFFSET showtimeOptionSuffix
    call WriteString
    
    ; Display showtime
    mov edx, edi
    call WriteString
    call CrLf
    
    ; Move to next showtime
    add edi, TimeSize
    inc ebx
    dec ecx
    jmp DisplayShowtimeLoop
    
DisplayBackOption:
    ; Display back option
    mov eax, ebx
    call WriteDec
    mov edx, OFFSET showtimeOptionSuffix
    call WriteString
    mov al, 'B'
    call WriteChar
    mov al, 'a'
    call WriteChar
    mov al, 'c'
    call WriteChar
    mov al, 'k'
    call WriteChar
    mov al, ' '
    call WriteChar
    mov al, 't'
    call WriteChar
    mov al, 'o'
    call WriteChar
    mov al, ' '
    call WriteChar
    mov al, 'M'
    call WriteChar
    mov al, 'o'
    call WriteChar
    mov al, 'v'
    call WriteChar
    mov al, 'i'
    call WriteChar
    mov al, 'e'
    call WriteChar
    mov al, ' '
    call WriteChar
    mov al, 'S'
    call WriteChar
    mov al, 'e'
    call WriteChar
    mov al, 'l'
    call WriteChar
    mov al, 'e'
    call WriteChar
    mov al, 'c'
    call WriteChar
    mov al, 't'
    call WriteChar
    mov al, 'i'
    call WriteChar
    mov al, 'o'
    call WriteChar
    mov al, 'n'
    call WriteChar
    call CrLf
    
    ; FIXED: Display complete footer with range
    mov al, '='
    mov ecx, 35
PrintEqualsShowtime:
    call WriteChar
    loop PrintEqualsShowtime
    call CrLf
    
    mov al, 'S'
    call WriteChar
    mov al, 'e'
    call WriteChar
    mov al, 'l'
    call WriteChar
    mov al, 'e'
    call WriteChar
    mov al, 'c'
    call WriteChar
    mov al, 't'
    call WriteChar
    mov al, ' '
    call WriteChar
    mov al, 'a'
    call WriteChar
    mov al, ' '
    call WriteChar
    mov al, 's'
    call WriteChar
    mov al, 'h'
    call WriteChar
    mov al, 'o'
    call WriteChar
    mov al, 'w'
    call WriteChar
    mov al, 't'
    call WriteChar
    mov al, 'i'
    call WriteChar
    mov al, 'm'
    call WriteChar
    mov al, 'e'
    call WriteChar
    mov al, ' '
    call WriteChar
    mov al, '('
    call WriteChar
    mov al, '1'
    call WriteChar
    mov al, '-'
    call WriteChar
    mov eax, ebx  ; Show the maximum option
    call WriteDec
    mov al, ')'
    call WriteChar
    mov al, ':'
    call WriteChar
    mov al, ' '
    call WriteChar
    
    ; Store max option number for validation
    mov maxShowtimeOption, ebx
    
    popad
    ret
DisplayDynamicShowtimes ENDP

; Replace the static headers with dynamic procedures
Display2DSeatMenu PROC
    push eax
    push ebx
    push edx
    
    ; Display header
    mov edx, OFFSET seatMenuHeaderStart
    call DisplayHeaderGreen
    
    ; Display Standard option with current price
    mov edx, OFFSET seatOption1
    call WriteString
    mov eax, Price2D1
    call DisplayPriceInRM
    mov edx, OFFSET seatOptionEnd
    call WriteString
    call CrLf
    
    ; Display Premium option with current price
    mov edx, OFFSET seatOption2
    call WriteString
    mov eax, Price2D2
    call DisplayPriceInRM
    mov edx, OFFSET seatOptionEnd
    call WriteString
    call CrLf
    
    ; Display Couple option with current price
    mov edx, OFFSET seatOption3
    call WriteString
    mov eax, Price2D3
    call DisplayPriceInRM
    mov edx, OFFSET seatOptionEnd
    call WriteString
    call CrLf
    
    ; Display back option and footer
    mov edx, OFFSET seatMenuFooter
    call WriteString
    
    pop edx
    pop ebx
    pop eax
    ret
Display2DSeatMenu ENDP

DisplayIMAXSeatMenu PROC
    push eax
    push ebx
    push edx
    
    ; Display header
    mov edx, OFFSET seatMenuIMAXHeaderStart
    call DisplayHeaderGreen
    
    ; Display Standard option with current price
    mov edx, OFFSET seatOption1
    call WriteString
    mov eax, PriceIM1
    call DisplayPriceInRM
    mov edx, OFFSET seatOptionEnd
    call WriteString
    call CrLf
    
    ; Display Premium option with current price
    mov edx, OFFSET seatOption2
    call WriteString
    mov eax, PriceIM2
    call DisplayPriceInRM
    mov edx, OFFSET seatOptionEnd
    call WriteString
    call CrLf
    
    ; Display Couple option with current price
    mov edx, OFFSET seatOption3
    call WriteString
    mov eax, PriceIM3
    call DisplayPriceInRM
    mov edx, OFFSET seatOptionEnd
    call WriteString
    call CrLf
    
    ; Display back option and footer
    mov edx, OFFSET seatMenuFooter
    call WriteString
    
    pop edx
    pop ebx
    pop eax
    ret
DisplayIMAXSeatMenu ENDP

; Helper procedure to display price in RM format - COMPLETELY FIXED
DisplayPriceInRM PROC
    push eax
    push ebx
    push ecx
    push edx
    
    mov edx, OFFSET rmPrefix
    call WriteString
    
    ; Convert cents to RM and display with decimal
    mov ebx, 100
    mov edx, 0
    div ebx  ; EAX = whole RM, EDX = cents remainder
    
    mov ecx, edx  ; Store cents remainder in ECX (safe register)
    call WriteDec  ; Display whole part (EAX)
    
    mov edx, OFFSET decimalPoint
    call WriteString
    
    ; Display cents part
    mov eax, ecx  ; Get cents remainder from ECX
    cmp eax, 10
    jae TwoDigitCents
    
    ; Single digit, add leading zero
    push eax
    mov al, '0'
    call WriteChar
    pop eax

TwoDigitCents:
    call WriteDec  ; Display the cents
    
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
DisplayPriceInRM ENDP

; Show seat selection with quantity input - FIXED to handle invalid choices
ShowSeatSelection PROC
	push eax
	push ebx
	push edx
	push ecx
	push esi
	push edi
	
	call Clrscr

SeatLoop:
	; Display dynamic seat menu based on movie type
	cmp currentMovieType, 0
	je Show2DSeats
	
	; FIXED: Use the correct symbol name that exists in your data section
	call DisplayIMAXSeatMenu
	jmp ContinueSeatSelection

Show2DSeats:
	; FIXED: Use the correct symbol name that exists in your data section
	call Display2DSeatMenu

ContinueSeatSelection:
	; Show available seats for each type
	call DisplayAvailableSeats
	
	; MOVED: Now display the selection prompt AFTER the available seats
	mov edx, OFFSET seatSelectionPrompt
	call WriteString

	call ReadInt
	mov userChoice, eax

	cmp eax, 1
	je ValidSeatChoice
	cmp eax, 2
	je ValidSeatChoice
	cmp eax, 3
	je ValidSeatChoice
	cmp eax, 4
	je BackToShowtimes
	
	; FIXED: Handle invalid choices properly
	call DisplayInvalidChoice
	jmp SeatLoop

ValidSeatChoice:
	mov currentSeatType, eax
	
	; Get seat quantity from user
	call GetSeatQuantity
	cmp eax, 0
	je SeatLoop  ; If quantity selection failed, go back to seat selection

	;Check if enough seats are available
	call CheckSeatAvailability
	mov ebx, currentSeatQty

	cmp eax, ebx  ; Compare available seats with requested quantity
	jl NotEnoughSeats  ; Fixed: renamed label to avoid conflict
	
	; After quantity selection and availability check, ask for combo
	call SelectCombo
	
	call ShowBookingSummary
	jmp SeatLoop

BackToShowtimes:
	call WaitMsg
	call Clrscr
	jmp ShowSeatSelectionEnd

NotEnoughSeats:  ; Fixed: renamed from InsufficientSeats
	mov edx, OFFSET insufficientSeats
	call WriteString
	call WaitMsg
	jmp SeatLoop

ShowSeatSelectionEnd:
	pop edi
	pop esi
	pop ecx
	pop edx
	pop ebx
	pop eax
	ret
ShowSeatSelection ENDP

; Get seat quantity from user
; Output: EAX = 1 if successful, 0 if failed
GetSeatQuantity PROC
	push ebx
	push ecx
	push edx

GetQuantityLoop:
	call CrLf
	mov edx, OFFSET seatQtyPrompt
	call WriteString
	call ReadInt
	
	; Validate quantity (1-10)
	cmp eax, 1
	jl InvalidQuantity
	cmp eax, 10
	jg InvalidQuantity
	
	; Store valid quantity
	mov currentSeatQty, eax
	mov eax, 1  ; Success
	jmp GetQuantityEnd

InvalidQuantity:
	mov edx, OFFSET invalidQtyMsg
	call WriteString
	call WaitMsg
	jmp GetQuantityLoop

GetQuantityEnd:
	pop edx
	pop ecx
	pop ebx
	ret
GetSeatQuantity ENDP

; Display available seats for current showtime
DisplayAvailableSeats PROC
    pushad
    
    ; Calculate base index for current showtime
    mov eax, currentShowtime
    dec eax                     ; Convert to 0-based index
    mov ebx, 3                  ; 3 seat types per showtime
    mul ebx                     ; eax = showtime_index * 3
    mov ebx, eax               ; Store base index
    
	call crlf

    ; Display Standard seats
    mov edx, OFFSET seatsAvailable
    call WriteString
    mov eax, OFFSET availableSeats
    mov ecx, ebx
    mov eax, [eax + ecx*4]      ; Get standard seats count
    call WriteDec
    mov al, ' '                 ; Add space character
    call WriteChar
    mov edx, OFFSET standardText
    call WriteString

	call crlf

    
    ; Display Premium seats  
    mov edx, OFFSET seatsAvailable
    call WriteString
    mov eax, OFFSET availableSeats
    mov ecx, ebx
    inc ecx                     ; Move to premium seats
    mov eax, [eax + ecx*4]
    call WriteDec
    mov al, ' '                 ; Add space character
    call WriteChar
    mov edx, OFFSET premiumText
    call WriteString

	call crlf
    
    ; Display Couple seats
    mov edx, OFFSET seatsAvailable
    call WriteString
    mov eax, OFFSET availableSeats
    mov ecx, ebx
    add ecx, 2                  ; Move to couple seats
    mov eax, [eax + ecx*4]
    call WriteDec
    mov al, ' '                 ; Add space character
    call WriteChar
    mov edx, OFFSET coupleText
    call WriteString
	call crlf
	call crlf
    
    popad
    ret
DisplayAvailableSeats ENDP

; Check if selected seat type has availability
CheckSeatAvailability PROC
    push ebx
    push ecx
    push edx
    
    ; Calculate seat index
    mov eax, currentShowtime
    dec eax                     ; Convert to 0-based
    mov ebx, 3
    mul ebx                     ; eax = showtime_index * 3
    add eax, currentSeatType
    dec eax                     ; Add seat type offset (0-based)
    
	; testing
	;push eax
	;push edx
	;mov edx, OFFSET debugIndexMsg  ; 
	;call WriteString
	;mov edx, eax
	;call WriteDec
	;call CrLf
	;pop edx
	;pop eax

     ;Check availability
    mov ebx, OFFSET availableSeats
    mov eax, [ebx + eax*4]      ; store EAX
    pop edx
    pop ecx
    pop ebx
    ret                         ;
CheckSeatAvailability ENDP


ShowBookingSummary PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    push edi

    call Clrscr

    ; Display booking summary header
    mov edx, OFFSET bookingSummary
    call DisplayHeaderGreen
    call CrLf

    ; Display selected movie name only
    mov edx, OFFSET movieSelected
    call WriteString
    call DisplayMovieName
    call CrLf

    ; Display showtime
    mov edx, OFFSET showtimeSelected
    call WriteString
    mov eax, currentShowtime
    call DisplayShowtimeName
    call CrLf

    ; Display seat type and quantity
    mov edx, OFFSET seatTypeSelected
    call WriteString
    call DisplaySeatTypeName
    call CrLf

    ; Display quantity
    mov edx, OFFSET seatsBooked
    call WriteString
    mov eax, currentSeatQty
    call WriteDec
    mov edx, OFFSET seatsText
    call WriteString
    call CrLf

    ; Display ticket price
    mov edx, OFFSET totalPriceText
    call WriteString
    call CalculateAndDisplayPrice
    call CrLf

    ; Display combo information if selected (combo was already selected earlier)
    cmp currentCombo, 0
    je NoComboSelected

    mov edx, OFFSET comboSelectedText
    call WriteString
    call DisplayComboName
    call CrLf

    ; Display combo quantity
    mov edx, OFFSET comboQtyText
    call WriteString
    mov eax, currentComboQty
    call WriteDec
    call CrLf

    mov edx, OFFSET comboPriceText
    call WriteString
    call DisplayComboPrice
    call CrLf

NoComboSelected:
    ; Display subtotal (before tax)
    mov edx, OFFSET subtotalText
    call WriteString
    call CalculateAndDisplaySubtotal
    call CrLf

    ; Display SST amount
    mov edx, OFFSET sstText
    call WriteString
    call CalculateAndDisplaySST
    call CrLf

    ; Display final total (including SST)
    mov edx, OFFSET finalTotalText
    call WriteString
    call CalculateAndDisplayFinalTotal
    call CrLf
    call CrLf

    ; 1. Confirm booking first
    mov edx, OFFSET confirmBookingPrompt
    call WriteString
    call ValidateYNInput    ; Wait for user input

    cmp al, 'Y'
    je AskPayment
    cmp al, 'y'
    je AskPayment
    ; If not confirmed, return to user portal
    call UserPortal
    jmp BookingSummaryExit

AskPayment:
    ; 2. Proceed to payment
    mov edx, OFFSET paymentPrompt
    call WriteString
    call ValidateYNInput    ; Wait for user input

    cmp al, 'Y'
    je CheckoutPayment
    cmp al, 'y'
    je CheckoutPayment
    jmp BookingSummaryExit

BookingSummaryExit:
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
ShowBookingSummary ENDP

; FIXED: Calculate subtotal correctly 
CalculateAndDisplaySubtotal PROC
	push eax
	push ebx
	push ecx
	push edx
	push esi
	
	; Calculate ticket price in cents
	mov eax, currentSeatType
	dec eax  ; Convert to 0-based index
	
	cmp currentMovieType, 0
	je UseSubtotal2DPrices
	
	; Use IMAX prices
	mov ebx, OFFSET seatPricesIMAX
	jmp GetSubtotalPrice

UseSubtotal2DPrices:
	mov ebx, OFFSET seatPrices2D

GetSubtotalPrice:
	mov ecx, [ebx + eax*4]  ; Get price per seat in cents
	mov eax, currentSeatQty
	mul ecx  ; Total ticket price in cents
	
	; DON'T multiply by 100 again - prices are already in cents!
	mov esi, eax  ; Store ticket price in ESI (already in cents)
	
	; Add combo price if selected
	cmp currentCombo, 0
	je NoSubtotalComboPrice
	
	mov eax, currentCombo
	dec eax  ; Convert to 0-based index
	mov ebx, OFFSET comboPrices
	mov ecx, [ebx + eax*4]  ; Get combo price per unit in cents
	
	; Multiply by combo quantity
	mov eax, currentComboQty
	mul ecx  ; EAX = total combo price in cents
	
	add esi, eax  ; Add combo price to ticket price

NoSubtotalComboPrice:
	; Display subtotal with decimal
	mov eax, esi  ; Get subtotal price in cents
	mov ebx, 100
	mov edx, 0
	div ebx  ; EAX = whole part, EDX = remainder
	
	push edx  ; Save remainder
	call WriteDec  ; Display whole part
	
	; Display decimal point
	push edx
	mov edx, OFFSET decimalPoint
	call WriteString
	pop edx
	
	; Display decimal part
	pop eax  ; Restore remainder
	cmp eax, 10
	jae DisplaySubtotalTwoDigits
	
	; Single digit, add leading zero
	push eax
	mov al, '0'
	call WriteChar
	pop eax

DisplaySubtotalTwoDigits:
	call WriteDec
	
	pop esi
	pop edx
	pop ecx
	pop ebx
	pop eax
	ret
CalculateAndDisplaySubtotal ENDP

; Calculate and display SST amount (6% of subtotal)
; FIXED: Calculate and display SST amount (6% of subtotal)
CalculateAndDisplaySST PROC
	push eax
	push ebx
	push ecx
	push edx
	push esi
	
	; Calculate subtotal in cents first
	mov eax, currentSeatType
	dec eax  ; Convert to 0-based index
	
	cmp currentMovieType, 0
	je UseSST2DPrices
	
	; Use IMAX prices
	mov ebx, OFFSET seatPricesIMAX
	jmp GetSSTPrice

UseSST2DPrices:
	mov ebx, OFFSET seatPrices2D

GetSSTPrice:
	mov ecx, [ebx + eax*4]  ; Get price per seat in cents
	mov eax, currentSeatQty
	mul ecx  ; Total ticket price in cents
	
	; DON'T multiply by 100 again - prices are already in cents!
	mov esi, eax  ; Store ticket price in ESI (already in cents)
	
	; Add combo price if selected
	cmp currentCombo, 0
	je NoSSTComboPrice
	
	mov eax, currentCombo
	dec eax  ; Convert to 0-based index
	mov ebx, OFFSET comboPrices
	mov ecx, [ebx + eax*4]  ; Get combo price per unit in cents
	
	; Multiply by combo quantity
	mov eax, currentComboQty
	mul ecx  ; EAX = total combo price in cents
	
	add esi, eax  ; Add combo price to ticket price

NoSSTComboPrice:
	; Calculate SST (6% of subtotal)
	mov eax, esi  ; Get subtotal in cents
	mov ebx, SST_RATE  ; 6%
	mul ebx  ; EAX = subtotal * 6
	mov ebx, 100
	mov edx, 0
	div ebx  ; EAX = SST amount in cents
	
	; Display SST with decimal
	mov ebx, 100
	mov edx, 0
	div ebx  ; EAX = whole part, EDX = remainder
	
	push edx  ; Save remainder
	call WriteDec  ; Display whole part
	
	; Display decimal point
	push edx
	mov edx, OFFSET decimalPoint
	call WriteString
	pop edx
	
	; Display decimal part
	pop eax  ; Restore remainder
	cmp eax, 10
	jae DisplaySSTTwoDigits
	
	; Single digit, add leading zero
	push eax
	mov al, '0'
	call WriteChar
	pop eax

DisplaySSTTwoDigits:
	call WriteDec
	
	pop esi
	pop edx
	pop ecx
	pop ebx
	pop eax
	ret
CalculateAndDisplaySST ENDP

;Checkout and payment method selection
CheckoutPayment PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    push edi
    call Clrscr

CheckoutLoop:
	call Clrscr
    mov edx, OFFSET paymentHeader
    call DisplayHeaderGreen
    call ReadInt
    call CrLf
	call DisplayFinalTotalFormatted
	call CrLf

    cmp eax, 1
    je PaywithCard
    cmp eax, 2
    je PaywithEWallet
    cmp eax, 3
    je PaywithOnlineBanking
    cmp eax, 4
    je PaywithRewardPoints
    cmp eax, 5
    je CancelPayment
    
    ; Invalid choice
	call DisplayInvalidChoice
    jmp CheckoutLoop

PaywithCard:
    call ProcessCardPayment
    jmp PaymentEnd

PaywithEWallet:
    call ProcessEWalletPayment
    jmp PaymentEnd

PaywithOnlineBanking:
    call ProcessOnlineBankingPayment
    jmp PaymentEnd

PaywithRewardPoints:
    ; Calculate final total in cents
    call CalculateFinalTotalInCents   ; EAX = total (cents)
    mov finalTotalCents, eax          ; Store total (cents)

    ; Calculate required points = total (cents) ÷ 10
    mov eax, finalTotalCents
    mov ebx, 10
    xor edx, edx
    div ebx                           ; EAX = required points
    mov ecx, eax                      ; ECX = required points

    call ProcessRewardPointsPayment   ; EAX = 1 success, 0 fail
    cmp eax, 1
    jne CheckoutLoop


CancelPayment:
    call UserPortal
    jmp PaymentEnd

PaymentEnd:
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
CheckoutPayment ENDP

; Update ProcessCardPayment procedure to include reward points
ProcessCardPayment PROC
	push eax
	push ebx
	push ecx
	push edx
	push esi

	call Clrscr
	mov attempts, 0  ; Reset existing attempts counter for card validation
	
CardPaymentLoop:
	; Check if maximum attempts exceeded using existing maxAttempts
	mov eax, attempts
	cmp eax, maxAttempts
	jae MaxCardAttemptsReached

	; Get card number with validation
	call GetCardNumber
	cmp eax, 0
	je CardValidationFailed ; If validation failed, increment attempts

	; Get expiry date with validation  
	call GetCardExpiry
	cmp eax, 0
	je CardValidationFailed ; If validation failed, increment attempts

	; Get CVV with validation
	call GetCardCVV
	cmp eax, 0
	je CardValidationFailed ; If validation failed, increment attempts

	; All validations passed - process payment immediately (no delay)
	call CrLf
	
	; Payment successful
	mov edx, OFFSET paymentSuccess
	call WriteString
	call ProcessSeatBooking ; Update seat availability
	
	; Award reward points
	call AwardRewardPoints
	
	call ReadChar

	; Generate receipt
	call GenerateReceipt
	call CrLf
	call GenerateETicket
	call UserPortal

	jmp ProcessCardEnd

CardValidationFailed:
	; Increment existing attempt counter
	inc attempts
	jmp CardPaymentLoop

MaxCardAttemptsReached:
	; Display message and return to payment method selection
	mov edx, OFFSET cardAttemptsExceeded
	call WriteString
	call ReadChar
	call CheckoutPayment  ; Return to payment method selection
	jmp ProcessCardEnd

ProcessCardEnd:
	call TrackRevenue
	pop esi
	pop edx
	pop ecx
	pop ebx
	pop eax
	ret
ProcessCardPayment ENDP

; Update the GetCardNumber procedure to not loop internally:
; Get and validate card number (must be 16 digits) - Single attempt version
GetCardNumber PROC
	push ebx
	push ecx
	push esi

	; Clear buffer
	mov ecx, 20
	mov esi, OFFSET cardNumber
	call ClearBuffer

	mov edx, OFFSET cardNumberPrompt
	call WriteString
	mov edx, OFFSET cardNumber
	mov ecx, 20
	call ReadString

	; Validate card number (must be exactly 16 digits)
	mov esi, OFFSET cardNumber
	call ValidateCardNumber
	cmp eax, 1
	je CardNumberValid

	mov edx, OFFSET cardNumberError
	call WriteString
	mov eax, 0  ; Return failure
	jmp GetCardNumberEnd

CardNumberValid:
	mov eax, 1 ; Return success

GetCardNumberEnd:
	pop esi
	pop ecx
	pop ebx
	ret
GetCardNumber ENDP

; Update the GetCardExpiry procedure to not loop internally:
; Get and validate card expiry date - Single attempt version
GetCardExpiry PROC
	push ebx
	push ecx
	push esi

	; Clear buffer
	mov ecx, 6
	mov esi, OFFSET cardExpiry
	call ClearBuffer

	mov edx, OFFSET cardExpiryPrompt
	call WriteString
	mov edx, OFFSET cardExpiry
	mov ecx, 6
	call ReadString

	; Validate expiry format (MM/YY)
	mov esi, OFFSET cardExpiry
	call ValidateCardExpiry
	cmp eax, 1
	je ExpiryValid

	mov edx, OFFSET cardExpiryError
	call WriteString
	mov eax, 0  ; Return failure
	jmp GetCardExpiryEnd

ExpiryValid:
	mov eax, 1  ; Return success

GetCardExpiryEnd:
	pop esi
	pop ecx
	pop ebx
	ret
GetCardExpiry ENDP

; Update the GetCardCVV procedure to not loop internally:
; Get and validate CVV - Single attempt version
GetCardCVV PROC
	push ebx
	push ecx
	push esi

	; Clear buffer
	mov ecx, 4
	mov esi, OFFSET cardCVV
	call ClearBuffer

	mov edx, OFFSET cardCVVPrompt
	call WriteString
	mov edx, OFFSET cardCVV
	mov ecx, 4
	call ReadString

	; Validate CVV (must be exactly 3 digits)
	mov esi, OFFSET cardCVV
	call ValidateCardCVV
	cmp eax, 1
	je CVVValid

	mov edx, OFFSET cardCVVError
	call WriteString
	mov eax, 0  ; Return failure
	jmp GetCardCVVEnd

CVVValid:
	mov eax, 1  ; Return success

GetCardCVVEnd:
	pop esi
	pop ecx
	pop ebx
	ret
GetCardCVV ENDP

; Validate card number (16 digits only)
ValidateCardNumber PROC
	push ebx
	push ecx
	push esi

	mov ecx, 0 ; Counter

ValidateCardLoop:
	mov al, [esi]
	cmp al, 0
	je CheckCardLength

	; Check if character is digit
	cmp al, '0'
	jl CardNumberInvalid
	cmp al, '9'
	jg CardNumberInvalid

	inc ecx
	inc esi
	jmp ValidateCardLoop

CheckCardLength:
	; Must be exactly 16 digits
	cmp ecx, 16
	je CardNumberValidResult

CardNumberInvalid:
	mov eax, 0
	jmp ValidateCardEnd

CardNumberValidResult:
	mov eax, 1

ValidateCardEnd:
	pop esi
	pop ecx
	pop ebx
	ret
ValidateCardNumber ENDP

; Validate expiry date format (MM/YY)
ValidateCardExpiry PROC
	push ebx
	push ecx
	push esi

	; Check format: XX/XX (5 characters)
	mov ecx, 0

CountExpiryChars:
	mov al, [esi]
	cmp al, 0
	je CheckExpiryFormat
	inc ecx
	inc esi
	jmp CountExpiryChars

CheckExpiryFormat:
	; Must be exactly 5 characters
	cmp ecx, 5
	jne ExpiryInvalid

	; Reset pointer
	mov esi, OFFSET cardExpiry

	; Check positions: digit, digit, slash, digit, digit
	mov al, [esi]
	cmp al, '0'
	jl ExpiryInvalid
	cmp al, '9'
	jg ExpiryInvalid

	inc esi
	mov al, [esi]
	cmp al, '0'
	jl ExpiryInvalid
	cmp al, '9'
	jg ExpiryInvalid

	inc esi
	mov al, [esi]
	cmp al, '/'
	jne ExpiryInvalid

	inc esi
	mov al, [esi]
	cmp al, '0'
	jl ExpiryInvalid
	cmp al, '9'
	jg ExpiryInvalid

	inc esi
	mov al, [esi]
	cmp al, '0'
	jl ExpiryInvalid
	cmp al, '9'
	jg ExpiryInvalid

	mov eax, 1
	jmp ValidateExpiryEnd

ExpiryInvalid:
	mov eax, 0

ValidateExpiryEnd:
	pop esi
	pop ecx
	pop ebx
	ret
ValidateCardExpiry ENDP

; Validate CVV (3 digits only)
ValidateCardCVV PROC
	push ebx
	push ecx
	push esi

	mov ecx, 0

ValidateCVVLoop:
	mov al, [esi]
	cmp al, 0
	je CheckCVVLength

	; Check if character is digit
	cmp al, '0'
	jl CVVInvalid
	cmp al, '9'
	jg CVVInvalid

	inc ecx
	inc esi
	jmp ValidateCVVLoop

CheckCVVLength:
	; Must be exactly 3 digits
	cmp ecx, 3
	je CVVValidResult

CVVInvalid:
	mov eax, 0
	jmp ValidateCVVEnd

CVVValidResult:
	mov eax, 1

ValidateCVVEnd:
	pop esi
	pop ecx
	pop ebx
	ret
ValidateCardCVV ENDP

; Update ProcessEWalletPayment procedure to include reward points
ProcessEWalletPayment PROC
	push eax
	push edx

	call Clrscr

EWalletLoop:
	mov edx, OFFSET EwalletPrompt
	call WriteString
	call ReadInt
	call CrLf

	cmp eax, 1
	je GrabPaySelected
	cmp eax, 2
	je TouchNGoSelected
	cmp eax, 3
	je BoostSelected

	call DisplayInvalidChoice
	jmp EWalletLoop

GrabPaySelected:
	mov edx, OFFSET ewalletOptions
	call WriteString
	mov edx, OFFSET grabpay
	call WriteString
	call CrLf
	jmp ShowQRCode

TouchNGoSelected:
	mov edx, OFFSET ewalletOptions
	call WriteString
	mov edx, OFFSET touchngo
	call WriteString
	call CrLf
	jmp ShowQRCode

BoostSelected:
	mov edx, OFFSET ewalletOptions
	call WriteString
	mov edx, OFFSET boost
	call WriteString
	call CrLf
	jmp ShowQRCode

ShowQRCode:
	call CrLf
	mov edx, OFFSET QRPrompt
	call WriteString
	call CrLf
	mov edx, OFFSET QRImage
	call WriteString
	call CrLf

	; Keep 10 second delay only for QR code scanning simulation
	mov edx, OFFSET processingCodeMsg
	call WriteString
	mov eax, 10000
	call Delay

	mov edx, OFFSET QRSuccess
	call WriteString
	call ProcessSeatBooking ; Update seat availability
	
	; Award reward points
	call AwardRewardPoints
	
	call ReadChar

	; Generate receipt
	call GenerateReceipt
	call CrLf
	call GenerateETicket
	call UserPortal

	call TrackRevenue
	pop edx
	pop eax
	ret
ProcessEWalletPayment ENDP

; Update ProcessOnlineBankingPayment procedure to include reward points
ProcessOnlineBankingPayment PROC
	push eax
	push edx

	call Clrscr

BankingLoop:
	mov edx, OFFSET bankingPrompt
	call WriteString
	call ReadInt
	call CrLf

	cmp eax, 1
	je MaybankSelected
	cmp eax, 2
	je CIMBSelected
	cmp eax, 3
	je PublicBankSelected

	call DisplayInvalidChoice
	jmp BankingLoop

MaybankSelected:
	mov edx, OFFSET selectedBankMsg
	call WriteString
	mov edx, OFFSET maybank
	call WriteString
	call CrLf
	jmp GetBankingCredentials

CIMBSelected:
	mov edx, OFFSET selectedBankMsg
	call WriteString
	mov edx, OFFSET cimb
	call WriteString
	call CrLf
	jmp GetBankingCredentials

PublicBankSelected:
	mov edx, OFFSET selectedBankMsg
	call WriteString
	mov edx, OFFSET publicbank
	call WriteString
	call CrLf
	jmp GetBankingCredentials

GetBankingCredentials:
	call CrLf

	; Clear buffers
	mov ecx, 30
	mov esi, OFFSET bankingUsername
	call ClearBuffer

	mov ecx, 20
	mov esi, OFFSET bankingPassword
	call ClearBuffer

	; Get username
	mov edx, OFFSET bankingUsernamePrompt
	call WriteString
	mov edx, OFFSET bankingUsername
	mov ecx, 30
	call ReadString

	; Get password (masked)
	mov edx, OFFSET bankingPasswordPrompt
	call WriteString
	mov edx, OFFSET bankingPassword
	mov ecx, 20
	call ReadPasswordMasked

	; Process payment immediately (no delay)
	call CrLf

	mov edx, OFFSET paymentSuccess
	call WriteString
	call ProcessSeatBooking ; Update seat availability
	
	; Award reward points
	call AwardRewardPoints
	
	call ReadChar

	; Generate receipt
	call GenerateReceipt
	call CrLf
	call GenerateETicket
	call UserPortal

	call TrackRevenue
	pop edx
	pop eax
	ret
ProcessOnlineBankingPayment ENDP

; ProcessRewardPointsPayment
ProcessRewardPointsPayment PROC
    ; Input: ECX = required points for this purchase
    push ebx
    push ecx
    push edx
    push esi
    push edi

    ; Get current user's reward points
    mov eax, 4                        ; field index for reward points
    mov ebx, currentUserIndex
    call GetUserField                 ; EDI = pointer to reward points
    movzx eax, WORD PTR [edi]         ; EAX = current reward points (WORD)
    mov ebx, eax                      ; EBX = available points

    ; Show available points
    mov edx, OFFSET availableMsg
    call WriteString
    mov eax, ebx
    call WriteDec
    call CrLf

    ; Show required points
    mov edx, OFFSET requiredMsg
    call WriteString
    mov eax, ecx                      ; ECX = required points
    call WriteDec
    call CrLf

    ; Compare available vs required
    cmp ebx, ecx
    jb NotEnoughPoints                ; if available < required

    ; Confirm payment with reward points
    mov edx, OFFSET confirmBookingPrompt
    call WriteString
    call ValidateYNInput
    
    cmp al, 'Y'
    je ConfirmRewardPayment
    cmp al, 'y'
    je ConfirmRewardPayment
    
    ; User cancelled
    mov eax, 0
    jmp EndProcessRewardPointsPayment

ConfirmRewardPayment:
    ; Deduct required points
    sub ebx, ecx
    mov WORD PTR [edi], bx           ; Store updated points (WORD)

    ; Success
    mov edx, OFFSET successMsg
    call WriteString
    call CrLf
	call ProcessSeatBooking
	call GenerateReceipt
	call CrLf

	call GenerateETicket
	call UserPortal

    mov eax, 1                        ; success flag
    jmp EndProcessRewardPointsPayment

NotEnoughPoints:
    mov edx, OFFSET notEnoughPointsMsg
    call WriteString
    call CrLf

    ; Show "press any key to continue"
    mov edx, OFFSET pressAnyKeyMsg
    call WriteString
    call ReadChar
    call CrLf

    mov eax, 0                        ; fail flag

EndProcessRewardPointsPayment:
	call TrackRevenue
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    ret
ProcessRewardPointsPayment ENDP

; Generate receipt after successful payment
GenerateReceipt PROC
	push eax
	push ebx
	push ecx
	push edx
	push esi
	push edi

	call Clrscr

	; Display receipt header
	mov edx, OFFSET receiptHeader
	call DisplayHeaderGreen
	call CrLf

	; Get current system time
	INVOKE GetLocalTime, ADDR sysTime

	; Display actual date and time
	call DisplayReceiptDateTime
	call CrLf

	; Display customer name
	mov edx, OFFSET receiptCustomerLabel
	call WriteString
	mov edx, OFFSET currentUser
	call WriteString
	call CrLf
	call CrLf

	; Display transaction details with proper spacing
	mov al, '-'
	mov ecx, 47
PrintDashes1:
	call WriteChar
	loop PrintDashes1
	call CrLf

	; Display movie information with padding
	mov edx, OFFSET movieSelected
	call WriteString
	call DisplayMovieName
	call CrLf

	; Display showtime with padding
	mov edx, OFFSET showtimeSelected
	call WriteString
	mov eax, currentShowtime
	call DisplayShowtimeName
	call CrLf

	; Display seat information with padding
	mov edx, OFFSET seatTypeSelected
	call WriteString
	call DisplaySeatTypeName
	call CrLf

	; Display quantity with proper formatting
	mov edx, OFFSET seatsBooked
	call WriteString
	mov eax, currentSeatQty
	call WriteDec
	mov edx, OFFSET seatsText
	call WriteString
	call CrLf

	call CrLf

	; Ticket pricing section
	call DisplayTicketPricing
	call CrLf

	; Display combo information if selected
	cmp currentCombo, 0
	je NoReceiptCombo

	call DisplayComboPricing

NoReceiptCombo:
	; Display separator line
	mov al, '-'
	mov ecx, 47
PrintDashes2:
	call WriteChar
	loop PrintDashes2
	call CrLf

	; Display final total with emphasis
	call DisplayFinalTotalFormatted
	call CrLf

	; Display separator line
	mov al, '='
	mov ecx, 47
PrintEquals:
	call WriteChar
	loop PrintEquals
	call CrLf
	call CrLf

	; Display receipt footer
	mov edx, OFFSET receiptFooter
	call WriteString

	; Wait for user to continue
	mov edx, OFFSET pressAnyKeyMsg
	call WriteString
	call ReadChar

	pop edi
	pop esi
	pop edx
	pop ecx
	pop ebx
	pop eax
	ret
GenerateReceipt ENDP

GenerateETicket PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    push edi

    call Clrscr

    ;header
    mov edx, OFFSET eticketHeader
    call DisplayHeaderGreen
    call CrLf

    ;time/date
    INVOKE GetLocalTime, ADDR sysTime

    mov edx, OFFSET receiptDateLabel
    call WriteString
    movzx eax, sysTime.wYear
    call WriteDec
    mov edx, OFFSET slashChar
    call WriteString
    movzx eax, sysTime.wMonth
    call WriteDec
    mov edx, OFFSET slashChar
    call WriteString
    movzx eax, sysTime.wDay
    call WriteDec
    call CrLf

    mov edx, OFFSET receiptTimeLabel
    call WriteString
    movzx eax, sysTime.wHour
    call WriteDec
    mov edx, OFFSET colonChar
    call WriteString
    movzx eax, sysTime.wMinute
    cmp eax, 10
    jae SkipLead0Min
    mov al, '0'
    call WriteChar

SkipLead0Min:
    movzx eax, sysTime.wMinute
    call WriteDec
    call CrLf
    call CrLf

    ;user
    mov edx, OFFSET receiptCustomerLabel
    call WriteString
    mov edx, OFFSET currentUser
    call WriteString
    call CrLf
    call CrLf

    ;movie
    mov edx, OFFSET movieSelected
    call WriteString
    mov eax, currentMovie
    call DisplayMovieName
    call CrLf

    mov edx, OFFSET showtimeSelected
    call WriteString
    mov eax, currentShowtime
    call DisplayShowtimeName
    call CrLf

    mov edx, OFFSET seatTypeSelected
    call WriteString
    call DisplaySeatTypeName
    call CrLf

    mov edx, OFFSET seatsBooked
    call WriteString
    mov eax, currentSeatQty
    call WriteDec
    mov edx, OFFSET seatsText
    call WriteString
    call CrLf

    ;combo
    cmp currentCombo, 0
    je NoComboET
    mov edx, OFFSET comboSelectedText
    call WriteString
    call DisplayComboName
    call CrLf

    mov edx, OFFSET comboQtyText
    call WriteString
    mov eax, currentComboQty
    call WriteDec
    call CrLf
NoComboET:

    call CrLf

    ;price
    mov edx, OFFSET finalTotalText
    call WriteString
    call CalculateAndDisplayFinalTotal
    call CrLf
    call CrLf

    ;QR
    mov edx, OFFSET QRImage2
    call WriteString
    call CrLf

    ;footer
    mov edx, OFFSET eticketFooter
    call WriteString
    call CrLf

    mov edx, OFFSET returnToPortal
    call WriteString
    call ReadChar

    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
GenerateETicket ENDP

; Display ticket pricing with proper alignment
DisplayTicketPricing PROC
	push eax
	push ebx
	push ecx
	push edx

	; Display ticket line item
	mov eax, currentSeatQty
	call WriteDec
	mov al, 'x'
	call WriteChar
	mov al, ' '
	call WriteChar
	
	call DisplaySeatTypeName
	mov al, ' '
	call WriteChar
	mov al, '('
	call WriteChar
	
	; Display movie type
	cmp currentMovieType, 0
	je Display2DType
	mov edx, OFFSET movieTypeIMAX
	jmp DisplayType
Display2DType:
	mov edx, OFFSET movieType2D
DisplayType:
	call WriteString
	mov al, ')'
	call WriteChar
	
	; Add spacing and display price
	call DisplayRightAlignedPrice
	call CrLf

	pop edx
	pop ecx
	pop ebx
	pop eax
	ret
DisplayTicketPricing ENDP


; Display combo pricing with proper alignment
DisplayComboPricing PROC
	push eax
	push edx

	; Display combo line item
	mov eax, currentComboQty
	call WriteDec
	mov al, 'x'
	call WriteChar
	mov al, ' '
	call WriteChar
	
	call DisplayComboName
	call CrLf
	
	; Display combo price with right alignment
	mov al, ' '
	mov ecx, 25
PrintSpaces:
	call WriteChar
	loop PrintSpaces
	
	mov edx, OFFSET comboPriceText
	call WriteString
	call DisplayComboPrice
	call CrLf
	call CrLf

	pop edx
	pop eax
	ret
DisplayComboPricing ENDP

; Display right-aligned price for tickets
DisplayRightAlignedPrice PROC
	push eax
	push edx

	; Add spacing for right alignment
	mov al, ' '
	mov ecx, 15
AlignSpaces:
	call WriteChar
	loop AlignSpaces

	mov edx, OFFSET totalPriceText
	call WriteString
	call CalculateAndDisplayPrice

	pop edx
	pop eax
	ret
DisplayRightAlignedPrice ENDP

; Display formatted final total with emphasis
DisplayFinalTotalFormatted PROC
	push eax
	push edx

	; Display subtotal first
	mov al, ' '
	mov ecx, 10
SubtotalSpaces:
	call WriteChar
	loop SubtotalSpaces
	mov edx, OFFSET subtotalText
	call WriteString
	call CalculateAndDisplaySubtotal
	call CrLf

	; Display SST
	mov al, ' '
	mov ecx, 10
SSTSpaces:
	call WriteChar
	loop SSTSpaces
	mov edx, OFFSET sstText
	call WriteString
	call CalculateAndDisplaySST
	call CrLf

	; Display separator line
	mov al, '-'
	mov ecx, 47
PrintDashes:
	call WriteChar
	loop PrintDashes
	call CrLf

	; Display "TOTAL:" with emphasis
	mov al, ' '
	mov ecx, 10
TotalSpaces:
	call WriteChar
	loop TotalSpaces

	mov edx, OFFSET finalTotalText
	call WriteString
	call CalculateAndDisplayFinalTotal

	pop edx
	pop eax
	ret
DisplayFinalTotalFormatted ENDP
; Display formatted date and time on receipt using actual system time
DisplayReceiptDateTime PROC
	push eax
	push ebx
	push edx

	; Display date label
	mov edx, OFFSET receiptDateLabel
	call WriteString
	
	; Display month
	movzx eax, sysTime.wMonth
	call WriteDec
	mov edx, OFFSET slashChar
	call WriteString
	
	; Display day
	movzx eax, sysTime.wDay
	call WriteDec
	mov edx, OFFSET slashChar
	call WriteString
	
	; Display year
	movzx eax, sysTime.wYear
	call WriteDec

	; Add spaces between date and time
	mov al, ' '
	call WriteChar
	call WriteChar
	call WriteChar

	; Display time label
	mov edx, OFFSET receiptTimeLabel
	call WriteString
	
	; Display hours
	movzx eax, sysTime.wHour
	call WriteDec
	mov edx, OFFSET colonChar
	call WriteString
	
	; Display minutes with leading zero if needed
	movzx eax, sysTime.wMinute
	cmp eax, 10
	jae DisplayMinutes
	mov al, '0'
	call WriteChar
	movzx eax, sysTime.wMinute

DisplayMinutes:
	call WriteDec
	mov edx, OFFSET colonChar
	call WriteString
	
	; Display seconds with leading zero if needed
	movzx eax, sysTime.wSecond
	cmp eax, 10
	jae DisplaySeconds
	mov al, '0'
	call WriteChar
	movzx eax, sysTime.wSecond

DisplaySeconds:
	call WriteDec

	pop edx
	pop ebx
	pop eax
	ret
DisplayReceiptDateTime ENDP

DisplayMovieName PROC
	push eax
	push edx
	
	; Display movie type first
	cmp currentMovieType, 0
	je Display2DMovie
	
	; IMAX movie
	mov edx, OFFSET movie1_IMAX
	mov eax, currentMovie
	cmp eax, 1
	je DisplaySelectedMovie
	
	mov edx, OFFSET movie2_IMAX
	cmp eax, 2
	je DisplaySelectedMovie
	
	mov edx, OFFSET movie3_IMAX
	cmp eax, 3
	je DisplaySelectedMovie
	jmp DisplayMovieEnd

Display2DMovie:
	; 2D movie
	mov edx, OFFSET movie1_2D
	mov eax, currentMovie
	cmp eax, 1
	je DisplaySelectedMovie
	
	mov edx, OFFSET movie2_2D
	cmp eax, 2
	je DisplaySelectedMovie
	
	mov edx, OFFSET movie3_2D
	cmp eax, 3
	je DisplaySelectedMovie
	jmp DisplayMovieEnd

DisplaySelectedMovie:
	call WriteString
	mov al, ' '
	call WriteChar
	mov al, '('
	call WriteChar
	cmp currentMovieType, 0
	je Display2DLabel
	mov edx, OFFSET movieTypeIMAX
	jmp DisplayLabel
Display2DLabel:
	mov edx, OFFSET movieType2D
DisplayLabel:
	call WriteString
	mov al, ')'
	call WriteChar

DisplayMovieEnd:
	pop edx
	pop eax
	ret
DisplayMovieName ENDP

; Display showtime name based on currentShowtime - UPDATED for dynamic
DisplayShowtimeName PROC
    push eax
    push ebx
    push edx
    push esi
    
    ; Get current movie index (1-based to 0-based)
    mov ebx, currentMovie
    dec ebx
    
    ; Calculate starting position in MovieShow array for this movie
    mov eax, ebx
    imul eax, MAXShowtimes * TimeSize
    mov esi, OFFSET MovieShow
    add esi, eax
    
    ; Move to the specific showtime (currentShowtime is 1-based)
    mov eax, currentShowtime
    dec eax  ; Convert to 0-based
    imul eax, TimeSize
    add esi, eax
    
    ; Display the showtime
    mov edx, esi
    call WriteString

    pop esi
    pop edx
    pop ebx
    pop eax
    ret
DisplayShowtimeName ENDP

; Display seat type name
DisplaySeatTypeName PROC
	push eax
	push edx
	
	mov eax, currentSeatType
	cmp eax, 1
	je SeatStandard
	cmp eax, 2
	je SeatPremium
	cmp eax, 3
	je SeatCouple
	jmp SeatTypeEnd

SeatStandard:
	mov edx, OFFSET standardText
	jmp DisplaySeatType
SeatPremium:
	mov edx, OFFSET premiumText
	jmp DisplaySeatType
SeatCouple:
	mov edx, OFFSET coupleText
DisplaySeatType:
	call WriteString

SeatTypeEnd:
	pop edx
	pop eax
	ret
DisplaySeatTypeName ENDP

; Calculate and display total price
; FIXED: Calculate and display total price with proper decimal formatting
CalculateAndDisplayPrice PROC
	push eax
	push ebx
	push ecx
	push edx
	
	; Get price per seat in cents
	mov eax, currentSeatType
	dec eax  ; Convert to 0-based index
	
	cmp currentMovieType, 0
	je Use2DPrices
	
	; Use IMAX prices
	mov ebx, OFFSET seatPricesIMAX
	jmp GetPrice

Use2DPrices:
	mov ebx, OFFSET seatPrices2D

GetPrice:
	mov ecx, [ebx + eax*4]  ; Get price per seat in cents
	mov eax, currentSeatQty
	mul ecx  ; Total price in cents = quantity * price per seat (cents)
	
	; Convert from cents to RM with decimal display
	mov ebx, 100
	mov edx, 0
	div ebx  ; EAX = whole RM, EDX = cents remainder
	
	push edx  ; Save remainder
	call WriteDec  ; Display whole RM part
	
	; Display decimal point
	push edx
	mov edx, OFFSET decimalPoint
	call WriteString
	pop edx
	
	; Display decimal part
	pop eax  ; Restore remainder (cents)
	cmp eax, 10
	jae DisplayTwoDigits
	
	; Single digit, add leading zero
	push eax
	mov al, '0'
	call WriteChar
	pop eax

DisplayTwoDigits:
	call WriteDec
	
	pop edx
	pop ecx
	pop ebx
	pop eax
	ret
CalculateAndDisplayPrice ENDP

; Process the actual seat booking (update available seats)
ProcessSeatBooking PROC
	push eax
	push ebx
	push ecx
	push edx
	
	; Calculate seat index in availableSeats array
	mov eax, currentShowtime
	dec eax  ; Convert to 0-based
	mov ebx, 3
	mul ebx  ; eax = showtime_index * 3
	add eax, currentSeatType
	dec eax  ; Add seat type offset (0-based)
	
	; Update available seats
	mov ebx, OFFSET availableSeats
	mov ecx, [ebx + eax*4]  ; Get current available seats
	sub ecx, currentSeatQty  ; Subtract booked seats
	mov [ebx + eax*4], ecx  ; Store updated count
	
	pop edx
	pop ecx
	pop ebx
	pop eax
	ret
ProcessSeatBooking ENDP

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
	; ESI = first string, EDI = second string
	; Returns 0 if equal, non-zero if not
	push ebx
	push ecx
	push esi
	push edi
	
	; Safety check for null pointers
	cmp esi, 0
	je NotEqual
	cmp edi, 0
	je NotEqual

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
	pop edi
	pop esi
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

; Select combo procedure - UPDATED to use dynamic menu
SelectCombo PROC
	push eax
	push edx
	
	; Initialize combo values to safe defaults
	mov currentCombo, 0
	mov currentComboQty, 0
	
	; Ask if user wants combo
	mov edx, OFFSET comboPrompt
	call WriteString
	call ValidateYNInput
	
	cmp al, 'Y'
	je ShowComboMenu
	cmp al, 'y'
	je ShowComboMenu
	
	; User doesn't want combo - values already set to 0
	jmp SelectComboEnd

ShowComboMenu:
	call CrLf
	; UPDATED: Use dynamic combo menu instead of static header
	call DisplayComboMenu
	mov edx, OFFSET comboSelectionPrompt
	call WriteString
	
	call ReadInt
	
	; Validate combo choice
	cmp eax, 1
	jl InvalidComboChoice
	cmp eax, 4
	jg InvalidComboChoice
	
	; Valid choice
	cmp eax, 4
	je NoComboChoice
	mov currentCombo, eax
	
	; Ask for combo quantity
	call GetComboQuantity
	jmp SelectComboEnd

NoComboChoice:
	mov currentCombo, 0
	mov currentComboQty, 0
	jmp SelectComboEnd

InvalidComboChoice:
	call DisplayInvalidChoice
	jmp ShowComboMenu

SelectComboEnd:
	pop edx
	pop eax
	ret
SelectCombo ENDP

; Display dynamic combo menu with current admin-controlled prices
DisplayComboMenu PROC
    push eax
    push ebx
    push edx
    
    ; Display header
    mov edx, OFFSET comboMenuHeaderStart
    call DisplayHeaderGreen
    
    ; Display Combo A with current price
    mov edx, OFFSET comboOption1
    call WriteString
    mov eax, ComboA
    call DisplayPriceInRM
    mov edx, OFFSET seatOptionEnd  ; Reuse the ")" character
    call WriteString
    call CrLf
    
    ; Display Combo B with current price
    mov edx, OFFSET comboOption2
    call WriteString
    mov eax, ComboB
    call DisplayPriceInRM
    mov edx, OFFSET seatOptionEnd
    call WriteString
    call CrLf
    
    ; Display Combo C with current price
    mov edx, OFFSET comboOption3
    call WriteString
    mov eax, ComboC
    call DisplayPriceInRM
    mov edx, OFFSET seatOptionEnd
    call WriteString
    call CrLf
    
    ; Display No Combo option and footer
    mov edx, OFFSET comboOption4
    call WriteString
    mov edx, OFFSET comboMenuFooter
    call WriteString
    
    pop edx
    pop ebx
    pop eax
    ret
DisplayComboMenu ENDP

; Get combo quantity from user
; Output: Sets currentComboQty
GetComboQuantity PROC
	push eax
	push edx

GetComboQtyLoop:
	call CrLf
	mov edx, OFFSET comboQtyPrompt
	call WriteString
	call ReadInt
	
	; Validate quantity (minimum 1, no maximum limit)
	cmp eax, 1
	jl InvalidComboQty
	
	; Store valid quantity (no upper limit check)
	mov currentComboQty, eax
	jmp GetComboQtyEnd

InvalidComboQty:
	mov edx, OFFSET invalidQtyMsg
	call WriteString
	call WaitMsg
	jmp GetComboQtyLoop

GetComboQtyEnd:
	pop edx
	pop eax
	ret
GetComboQuantity ENDP

; Display combo name based on currentCombo
DisplayComboName PROC
	push eax
	push edx
	
	mov eax, currentCombo
	cmp eax, 1
	je DisplayComboA
	cmp eax, 2
	je DisplayComboB
	cmp eax, 3
	je DisplayComboC
	jmp DisplayComboEnd

DisplayComboA:
	mov edx, OFFSET comboAText
	jmp DisplayCombo
DisplayComboB:
	mov edx, OFFSET comboBText
	jmp DisplayCombo
DisplayComboC:
	mov edx, OFFSET comboCText
DisplayCombo:
	call WriteString

DisplayComboEnd:
	pop edx
	pop eax
	ret
DisplayComboName ENDP

; Remove these duplicate procedures (lines near the end of the file):

; Display combo price with decimal places
DisplayComboPrice PROC
	push eax
	push ebx
	push ecx
	push edx
	
	mov eax, currentCombo
	cmp eax, 0
	je DisplayComboPriceEnd
	
	dec eax  ; Convert to 0-based index
	mov ebx, OFFSET comboPrices
	mov ecx, [ebx + eax*4]  ; Get price per combo in cents
	
	; Multiply by quantity
	mov eax, currentComboQty
	cmp eax, 0
	je DisplayComboPriceEnd  ; Safety check
	
	; Use 16-bit multiplication to prevent overflow
	cmp eax, 65535
	jae DisplayComboPriceEnd  ; Prevent overflow
	
	mul ecx  ; EAX = total combo price in cents
	
	; Display whole part (divide by 100)
	mov ebx, 100
	mov edx, 0
	div ebx  ; EAX = whole part, EDX = remainder (cents)
	
	push edx  ; Save remainder
	call WriteDec  ; Display whole part
	
	; Display decimal point
	push edx
	mov edx, OFFSET decimalPoint
	call WriteString
	pop edx
	
	; Display decimal part
	pop eax  ; Restore remainder
	cmp eax, 10
	jae DisplayTwoDigits
	
	; Single digit, add leading zero
	push eax
	mov al, '0'
	call WriteChar
	pop eax

DisplayTwoDigits:
	call WriteDec

DisplayComboPriceEnd:
	pop edx
	pop ecx
	pop ebx
	pop eax
	ret
DisplayComboPrice ENDP

; Calculate and display final total (tickets + combo)
; FIXED: Calculate and display final total (tickets + combo)
CalculateAndDisplayFinalTotal PROC
	push eax
	push ebx
	push ecx
	push edx
	push esi
	
	; Calculate ticket price in cents
	mov eax, currentSeatType
	dec eax  ; Convert to 0-based index
	
	cmp currentMovieType, 0
	je UseFinal2DPrices
	
	; Use IMAX prices
	mov ebx, OFFSET seatPricesIMAX
	jmp GetFinalPrice

UseFinal2DPrices:
	mov ebx, OFFSET seatPrices2D

GetFinalPrice:
	mov ecx, [ebx + eax*4]  ; Get price per seat in cents
	mov eax, currentSeatQty
	mul ecx  ; Total ticket price in cents
	
	; DON'T multiply by 100 again - prices are already in cents!
	mov esi, eax  ; Store ticket price in ESI (already in cents)
	
	; Add combo price if selected
	cmp currentCombo, 0
	je NoComboPrice
	
	mov eax, currentCombo
	dec eax  ; Convert to 0-based index
	mov ebx, OFFSET comboPrices
	mov ecx, [ebx + eax*4]  ; Get combo price per unit in cents
	
	; Multiply by combo quantity
	mov eax, currentComboQty
	mul ecx  ; EAX = total combo price in cents
	
	add esi, eax  ; Add combo price to ticket price

NoComboPrice:
	; Calculate SST (6% of subtotal) and add to total
	mov eax, esi  ; Get subtotal in cents
	mov ebx, SST_RATE  ; 6%
	mul ebx  ; EAX = subtotal * 6
	mov ebx, 100
	mov edx, 0
	div ebx  ; EAX = SST amount in cents
	
	add esi, eax  ; Add SST to subtotal for final total

	; Display final total with decimal
	mov eax, esi  ; Get total price (including SST)
	mov ebx, 100
	mov edx, 0
	div ebx  ; EAX = whole part, EDX = remainder
	
	push edx  ; Save remainder
	call WriteDec  ; Display whole part
	
	; Display decimal point
	push edx
	mov edx, OFFSET decimalPoint
	call WriteString
	pop edx
	
	; Display decimal part
	pop eax  ; Restore remainder
	cmp eax, 10
	jae DisplayFinalTwoDigits
	
	; Single digit, add leading zero
	push eax
	mov al, '0'
	call WriteChar
	pop eax

DisplayFinalTwoDigits:
	call WriteDec
	
	pop esi
	pop edx
	pop ecx
	pop ebx
	pop eax
	ret
CalculateAndDisplayFinalTotal ENDP
ValidateYNInput PROC
    push edx

ValidateYNLoop:
    call ReadChar
    call WriteChar
    call CrLf

    ; Check for valid Y/N responses
    cmp al, 'Y'
    je ValidYNInput
    cmp al, 'y'
    je ValidYNInput
    cmp al, 'N'
    je ValidYNInput
    cmp al, 'n'
    je ValidYNInput

    ; Invalid input - show error and retry
    mov edx, OFFSET invalidYNMsg
    call WriteString
    jmp ValidateYNLoop

ValidYNInput:
    pop edx
    ret
ValidateYNInput ENDP

; Display text in red color
WriteStringRed PROC
    push eax
    
    ; Save current color and set to red
    mov eax, RED_COLOR
    call SetTextColor
    
    ; Display the string
    call WriteString
    
    ; Restore normal color
    mov eax, WHITE_COLOR
    call SetTextColor
    
    pop eax
    ret
WriteStringRed ENDP

; Display invalid choice message in red
DisplayInvalidChoice PROC
    push edx
    
    ; Display the message in red
    mov edx, OFFSET InvalidChoice
    call WriteStringRed
    
    pop edx
    ret
DisplayInvalidChoice ENDP

; Display any error message in red
DisplayErrorMessage PROC
    ; Input: EDX = pointer to error message string
    push eax
    
    ; Set red color
    mov eax, RED_COLOR
    call SetTextColor
    
    ; Display the message
    call WriteString
    
    ; Restore normal color
    mov eax, WHITE_COLOR
    call SetTextColor
    
    pop eax
    ret
DisplayErrorMessage ENDP

; Display text in light green color
WriteStringLightGreen PROC
    push eax
    
    ; Save current color and set to light green
    mov eax, LIGHT_GREEN_COLOR
    call SetTextColor
    
    ; Display the string
    call WriteString
    
    ; Restore normal color
    mov eax, WHITE_COLOR
    call SetTextColor
    
    pop eax
    ret
WriteStringLightGreen ENDP

; Display header/banner message in light green
DisplayHeaderGreen PROC
    ; Input: EDX = pointer to header message string
    push eax
    
    ; Set light green color
    mov eax, LIGHT_GREEN_COLOR
    call SetTextColor
    
    ; Display the message
    call WriteString
    
    ; Restore normal color
    mov eax, WHITE_COLOR
    call SetTextColor
    
    pop eax
    ret
DisplayHeaderGreen ENDP

End main