Include Irvine32.inc

.data
    ; Cinema hall configuration
    HALL_ROWS EQU 10
    HALL_COLS EQU 15
    TOTAL_SEATS EQU HALL_ROWS * HALL_COLS
    
    ; Seat status constants
    SEAT_AVAILABLE EQU 0
    SEAT_OCCUPIED EQU 1
    SEAT_SELECTED EQU 2
    
    ; Seat category constants
    STANDARD_SEAT EQU 0
    PREMIUM_SEAT EQU 1
    COUPLE_SEAT EQU 2
    
    ; Cinema hall layout (2D array simulation)
    cinemaHall BYTE TOTAL_SEATS DUP(SEAT_AVAILABLE)
    
    ; Seat categories layout (same size as cinemaHall)
    seatCategories BYTE TOTAL_SEATS DUP(STANDARD_SEAT)
    
    ; Selected seats tracking
    selectedSeats BYTE TOTAL_SEATS DUP(0)
    selectedCount DWORD 0
    maxSelections DWORD 8  ; Maximum seats that can be selected
    
    ; Pricing for different categories
    standardPrice DWORD 12    ; RM12
    premiumPrice DWORD 20     ; RM20
    couplePrice DWORD 24      ; RM24 (for pair)
    
    ; Display messages
    hallHeader BYTE "=== CINEMA HALL LAYOUT ===", 0Dh, 0Ah
               BYTE "Screen", 0Dh, 0Ah
               BYTE "========================", 0Dh, 0Ah, 0Dh, 0Ah, 0
    
    rowLabels BYTE "ABCDEFGHIJ"  ; Row labels A-J
    
    legendMsg BYTE 0Dh, 0Ah, "Legend:", 0Dh, 0Ah
              BYTE "Standard Seats:", 0Dh, 0Ah
              BYTE "  [ ] - Available (RM12)", 0Dh, 0Ah
              BYTE "  [X] - Occupied", 0Dh, 0Ah
              BYTE "  [S] - Selected", 0Dh, 0Ah
              BYTE "Premium Seats:", 0Dh, 0Ah
              BYTE "  {P} - Available (RM20)", 0Dh, 0Ah
              BYTE "  {X} - Occupied", 0Dh, 0Ah
              BYTE "  {S} - Selected", 0Dh, 0Ah
              BYTE "Couple Seats:", 0Dh, 0Ah
              BYTE "  <C> - Available (RM24/pair)", 0Dh, 0Ah
              BYTE "  <X> - Occupied", 0Dh, 0Ah
              BYTE "  <S> - Selected", 0Dh, 0Ah, 0Dh, 0Ah, 0
    
    instructionMsg BYTE "Enter seat (e.g., A5) or 'DONE' to confirm: ", 0
    seatInput BYTE 10 DUP(0)
    
    invalidSeatMsg BYTE "Invalid seat selection!", 0Dh, 0Ah, 0
    seatOccupiedMsg BYTE "Seat is already occupied!", 0Dh, 0Ah, 0
    seatSelectedMsg BYTE "Seat already selected!", 0Dh, 0Ah, 0
    maxSeatsMsg BYTE "Maximum seats reached!", 0Dh, 0Ah, 0
    confirmationMsg BYTE "Selected seats: ", 0
    totalPriceMsg BYTE "Total price: RM", 0
    
    ; Category names for display
    standardName BYTE "Standard", 0
    premiumName BYTE "Premium", 0
    coupleName BYTE "Couple", 0

    ; Helper string for "DONE" comparison
    doneString BYTE "DONE", 0

.code

; Compare two null-terminated strings
; Input: ESI = first string, EDI = second string
; Output: EAX = 0 if equal, non-zero if different
CompareStrings PROC
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

; Initialize seat categories layout
InitializeSeatCategories PROC
    push eax
    push ebx
    push ecx
    
    ; Set rows A-C as Standard seats (rows 0-2)
    mov ebx, 0
    mov ecx, 45  ; 3 rows * 15 cols
StandardLoop:
    cmp ecx, 0
    je SetPremium
    mov seatCategories[ebx], STANDARD_SEAT
    inc ebx
    dec ecx
    jmp StandardLoop
    
SetPremium:
    ; Set rows D-G as Premium seats (rows 3-6) 
    mov ecx, 60  ; 4 rows * 15 cols
PremiumLoop:
    cmp ecx, 0
    je SetCouple
    mov seatCategories[ebx], PREMIUM_SEAT
    inc ebx
    dec ecx
    jmp PremiumLoop
    
SetCouple:
    ; Set rows H-J as Couple seats (rows 7-9)
    mov ecx, 45  ; 3 rows * 15 cols
CoupleLoop:
    cmp ecx, 0
    je InitComplete
    mov seatCategories[ebx], COUPLE_SEAT
    inc ebx
    dec ecx
    jmp CoupleLoop
    
InitComplete:
    pop ecx
    pop ebx
    pop eax
    ret
InitializeSeatCategories ENDP

; Main seat selection procedure
SeatSelection PROC
    ; Initialize seat categories and some occupied seats
    call InitializeSeatCategories
    call InitializeDemoOccupiedSeats
    
SeatSelectionLoop:
    call Clrscr
    call DisplayCinemaHall
    call DisplayLegend
    call DisplaySelectedSeats
    call DisplayTotalPrice
    
    ; Get user input
    mov edx, OFFSET instructionMsg
    call WriteString
    mov edx, OFFSET seatInput
    mov ecx, SIZEOF seatInput
    call ReadString
    
    ; Check if user wants to finish
    call CheckDoneInput
    cmp eax, 1
    je SeatSelectionComplete
    
    ; Process seat selection
    call ProcessSeatSelection
    
    jmp SeatSelectionLoop
    
SeatSelectionComplete:
    call DisplayFinalSelection
    ret
SeatSelection ENDP

; Display the cinema hall layout with different seat categories
DisplayCinemaHall PROC
    push eax
    push ebx
    push ecx
    push edx
    
    ; Display header
    mov edx, OFFSET hallHeader
    call WriteString
    
    ; Display column numbers header
    mov al, ' '
    call WriteChar
    call WriteChar
    mov ecx, HALL_COLS
    mov ebx, 1
    
ColumnHeaderLoop:
    cmp ebx, 10
    jl SingleDigit
    ; Two digits
    mov eax, ebx
    mov edx, 0
    mov ecx, 10
    div ecx
    add al, '0'
    call WriteChar
    mov al, dl
    add al, '0'
    call WriteChar
    jmp NextColumnHeader
    
SingleDigit:
    mov al, ' '
    call WriteChar
    mov eax, ebx
    add al, '0'
    call WriteChar
    
NextColumnHeader:
    mov al, ' '
    call WriteChar
    inc ebx
    cmp ebx, HALL_COLS + 1
    jl ColumnHeaderLoop
    
    call CrLf
    call CrLf
    
    ; Display rows
    mov ebx, 0  ; Row index
    
RowLoop:
    cmp ebx, HALL_ROWS
    jae DisplayComplete
    
    ; Display row label
    mov eax, ebx
    mov al, rowLabels[eax]
    call WriteChar
    mov al, ' '
    call WriteChar
    
    ; Display seats in this row
    mov ecx, HALL_COLS
    push ebx
    mov eax, HALL_COLS
    mul ebx
    mov ebx, eax  ; EBX = starting seat index for this row
    
SeatLoop:
    call DisplaySeatWithCategory  ; EBX = seat index
    mov al, ' '
    call WriteChar
    inc ebx
    loop SeatLoop
    
    pop ebx
    call CrLf
    inc ebx
    jmp RowLoop
    
DisplayComplete:
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
DisplayCinemaHall ENDP

; Display a single seat with category-specific symbols
; Input: EBX = seat index
DisplaySeatWithCategory PROC
    push eax
    push edx
    
    ; Get seat category
    mov al, seatCategories[ebx]
    
    ; Display opening bracket based on category
    cmp al, STANDARD_SEAT
    je DisplayStandardBracket
    cmp al, PREMIUM_SEAT
    je DisplayPremiumBracket
    ; Must be couple seat
    mov al, '<'
    call WriteChar
    jmp DisplaySeatContent
    
DisplayStandardBracket:
    mov al, '['
    call WriteChar
    jmp DisplaySeatContent
    
DisplayPremiumBracket:
    mov al, '{'
    call WriteChar
    
DisplaySeatContent:
    ; Display seat status symbol
    mov al, cinemaHall[ebx]
    cmp al, SEAT_AVAILABLE
    je DisplayAvailable
    cmp al, SEAT_OCCUPIED
    je DisplayOccupied
    
    ; Selected seat
    mov al, 'S'
    call WriteChar
    jmp DisplaySeatEnd
    
DisplayAvailable:
    ; Show category letter for available seats
    mov al, seatCategories[ebx]
    cmp al, STANDARD_SEAT
    je DisplayStandardSymbol
    cmp al, PREMIUM_SEAT
    je DisplayPremiumSymbol
    ; Couple seat
    mov al, 'C'
    call WriteChar
    jmp DisplaySeatEnd
    
DisplayStandardSymbol:
    mov al, ' '
    call WriteChar
    jmp DisplaySeatEnd
    
DisplayPremiumSymbol:
    mov al, 'P'
    call WriteChar
    jmp DisplaySeatEnd
    
DisplayOccupied:
    mov al, 'X'
    call WriteChar
    
DisplaySeatEnd:
    ; Display closing bracket based on category
    mov al, seatCategories[ebx]
    cmp al, STANDARD_SEAT
    je DisplayStandardClosing
    cmp al, PREMIUM_SEAT
    je DisplayPremiumClosing
    ; Couple seat
    mov al, '>'
    call WriteChar
    jmp DisplaySeatComplete
    
DisplayStandardClosing:
    mov al, ']'
    call WriteChar
    jmp DisplaySeatComplete
    
DisplayPremiumClosing:
    mov al, '}'
    call WriteChar
    
DisplaySeatComplete:
    pop edx
    pop eax
    ret
DisplaySeatWithCategory ENDP

; Calculate and display total price for selected seats
DisplayTotalPrice PROC
    push eax
    push ebx
    push ecx
    push edx
    
    mov eax, selectedCount
    cmp eax, 0
    je NoSeatsForPrice
    
    ; Calculate total price
    mov eax, 0  ; Total price accumulator
    mov ebx, 0  ; Seat index
    mov ecx, TOTAL_SEATS
    
PriceCalculationLoop:
    cmp ecx, 0
    je DisplayPrice
    
    ; Check if seat is selected
    cmp cinemaHall[ebx], SEAT_SELECTED
    jne NextSeatPrice
    
    ; Add price based on category
    mov dl, seatCategories[ebx]
    cmp dl, STANDARD_SEAT
    je AddStandardPrice
    cmp dl, PREMIUM_SEAT
    je AddPremiumPrice
    ; Must be couple seat
    add eax, couplePrice
    jmp NextSeatPrice
    
AddStandardPrice:
    add eax, standardPrice
    jmp NextSeatPrice
    
AddPremiumPrice:
    add eax, premiumPrice
    
NextSeatPrice:
    inc ebx
    dec ecx
    jmp PriceCalculationLoop
    
DisplayPrice:
    mov edx, OFFSET totalPriceMsg
    call WriteString
    call WriteDec
    call CrLf
    jmp PriceComplete
    
NoSeatsForPrice:
    ; Don't display price if no seats selected
    
PriceComplete:
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
DisplayTotalPrice ENDP

; Process seat selection input
ProcessSeatSelection PROC
    push eax
    push ebx
    push ecx
    
    ; Parse seat input (e.g., "A5" -> row 0, col 4)
    call ParseSeatInput
    cmp eax, -1
    je InvalidSeat
    
    ; EAX = seat index
    mov ebx, eax
    
    ; Check if seat is occupied
    cmp cinemaHall[ebx], SEAT_OCCUPIED
    je SeatOccupied
    
    ; Check if seat is already selected
    cmp cinemaHall[ebx], SEAT_SELECTED
    je SeatAlreadySelected
    
    ; Check maximum selections
    mov eax, selectedCount
    cmp eax, maxSelections
    jae MaxSeatsReached
    
    ; Select the seat
    mov cinemaHall[ebx], SEAT_SELECTED
    inc selectedCount
    jmp ProcessComplete
    
InvalidSeat:
    mov edx, OFFSET invalidSeatMsg
    call WriteString
    call WaitForKey
    jmp ProcessComplete
    
SeatOccupied:
    mov edx, OFFSET seatOccupiedMsg
    call WriteString
    call WaitForKey
    jmp ProcessComplete
    
SeatAlreadySelected:
    mov edx, OFFSET seatSelectedMsg
    call WriteString
    call WaitForKey
    jmp ProcessComplete
    
MaxSeatsReached:
    mov edx, OFFSET maxSeatsMsg
    call WriteString
    call WaitForKey
    
ProcessComplete:
    pop ecx
    pop ebx
    pop eax
    ret
ProcessSeatSelection ENDP

; Parse seat input (e.g., "A5" -> seat index)
; Output: EAX = seat index, or -1 if invalid
ParseSeatInput PROC
    push ebx
    push ecx
    push edx
    
    ; Check if input is at least 2 characters
    mov esi, OFFSET seatInput
    mov al, [esi]
    cmp al, 0
    je InvalidInput
    
    ; Parse row (A-J)
    mov al, [esi]
    cmp al, 'A'
    jl CheckLowercase
    cmp al, 'J'
    jg CheckLowercase
    sub al, 'A'
    mov bl, al  ; BL = row (0-9)
    jmp ParseColumn
    
CheckLowercase:
    cmp al, 'a'
    jl InvalidInput
    cmp al, 'j'
    jg InvalidInput
    sub al, 'a'
    mov bl, al  ; BL = row (0-9)
    
ParseColumn:
    ; Parse column number
    inc esi
    mov al, [esi]
    cmp al, '0'
    jl InvalidInput
    cmp al, '9'
    jg CheckTwoDigit
    
    ; Single digit column
    sub al, '0'
    cmp al, 0
    je InvalidInput  ; Column can't be 0
    dec al  ; Convert to 0-based
    mov bh, al  ; BH = column (0-14)
    
    ; Check if column is within range
    cmp bh, HALL_COLS
    jae InvalidInput
    jmp CalculateIndex
    
CheckTwoDigit:
    ; Check for two-digit column number
    mov al, [esi]
    cmp al, '1'
    jne InvalidInput
    inc esi
    mov al, [esi]
    cmp al, '0'
    jl InvalidInput
    cmp al, '5'
    jg InvalidInput
    
    ; Calculate two-digit number (10-15)
    sub al, '0'
    add al, 10
    dec al  ; Convert to 0-based
    mov bh, al
    
CalculateIndex:
    ; Calculate seat index: row * HALL_COLS + column
    movzx eax, bl
    mov ecx, HALL_COLS
    mul ecx
    movzx ecx, bh
    add eax, ecx
    jmp ParseComplete
    
InvalidInput:
    mov eax, -1
    
ParseComplete:
    pop edx
    pop ecx
    pop ebx
    ret
ParseSeatInput ENDP

; Check if input is "DONE"
; Output: EAX = 1 if done, 0 if not
CheckDoneInput PROC
    push esi
    push edi
    
    mov esi, OFFSET seatInput
    mov edi, OFFSET doneString
    call CompareStrings
    ; CompareStrings returns 0 if equal
    cmp eax, 0
    je InputIsDone
    
    mov eax, 0
    jmp CheckDoneComplete
    
InputIsDone:
    mov eax, 1
    
CheckDoneComplete:
    pop edi
    pop esi
    ret
CheckDoneInput ENDP

; Display legend
DisplayLegend PROC
    mov edx, OFFSET legendMsg
    call WriteString
    ret
DisplayLegend ENDP

; Display currently selected seats with categories and individual prices
DisplaySelectedSeats PROC
    push eax
    push ebx
    push ecx
    
    mov eax, selectedCount
    cmp eax, 0
    je NoSeatsSelected
    
    mov edx, OFFSET confirmationMsg
    call WriteString
    call CrLf
    
    ; Display selected seat numbers with categories
    mov ebx, 0
    mov ecx, TOTAL_SEATS
    
DisplaySelectedLoop:
    cmp ecx, 0
    je DisplaySelectedComplete
    
    cmp cinemaHall[ebx], SEAT_SELECTED
    jne NextSeat
    
    ; Convert index to seat notation and show category
    call DisplaySeatWithDetails  ; EBX = index
    
NextSeat:
    inc ebx
    dec ecx
    jmp DisplaySelectedLoop
    
NoSeatsSelected:
    call CrLf
    jmp DisplaySelectedComplete
    
DisplaySelectedComplete:
    pop ecx
    pop ebx
    pop eax
    ret
DisplaySelectedSeats ENDP

; Display seat details with category and price
; Input: EBX = seat index
DisplaySeatWithDetails PROC
    push eax
    push edx
    push ecx
    
    ; Display seat notation
    call IndexToSeatNotation  ; EBX = index
    
    ; Display category and price
    mov al, seatCategories[ebx]
    cmp al, STANDARD_SEAT
    je DisplayStandardDetails
    cmp al, PREMIUM_SEAT
    je DisplayPremiumDetails
    
    ; Couple seat
    mov edx, OFFSET coupleName
    call WriteString
    mov al, ' '
    call WriteChar
    mov al, '('
    call WriteChar
    mov al, 'R'
    call WriteChar
    mov al, 'M'
    call WriteChar
    mov eax, couplePrice
    call WriteDec
    mov al, ')'
    call WriteChar
    call CrLf
    jmp DetailsComplete
    
DisplayStandardDetails:
    mov edx, OFFSET standardName
    call WriteString
    mov al, ' '
    call WriteChar
    mov al, '('
    call WriteChar
    mov al, 'R'
    call WriteChar
    mov al, 'M'
    call WriteChar
    mov eax, standardPrice
    call WriteDec
    mov al, ')'
    call WriteChar
    call CrLf
    jmp DetailsComplete
    
DisplayPremiumDetails:
    mov edx, OFFSET premiumName
    call WriteString
    mov al, ' '
    call WriteChar
    mov al, '('
    call WriteChar
    mov al, 'R'
    call WriteChar
    mov al, 'M'
    call WriteChar
    mov eax, premiumPrice
    call WriteDec
    mov al, ')'
    call WriteChar
    call CrLf
    
DetailsComplete:
    pop ecx
    pop edx
    pop eax
    ret
DisplaySeatWithDetails ENDP

; Convert seat index to notation (e.g., 4 -> "A5")
; Input: EBX = seat index
IndexToSeatNotation PROC
    push eax
    push edx
    push ecx
    
    ; Calculate row and column
    mov eax, ebx
    mov edx, 0
    mov ecx, HALL_COLS
    div ecx
    ; EAX = row, EDX = column
    
    ; Display row letter
    add al, 'A'
    call WriteChar
    
    ; Display column number
    inc edx  ; Convert to 1-based
    cmp edx, 10
    jl SingleDigitColumn
    
    mov eax, edx
    mov ecx, 10
    mov edx, 0
    div ecx
    add al, '0'
    call WriteChar
    mov al, dl
    add al, '0'
    call WriteChar
    jmp NotationComplete
    
SingleDigitColumn:
    mov al, dl
    add al, '0'
    call WriteChar
    
NotationComplete:
    mov al, ' '
    call WriteChar
    mov al, '-'
    call WriteChar
    mov al, ' '
    call WriteChar
    
    pop ecx
    pop edx
    pop eax
    ret
IndexToSeatNotation ENDP

; Initialize some demo occupied seats
InitializeDemoOccupiedSeats PROC
    ; Mark some seats as occupied for demonstration
    mov cinemaHall[22], SEAT_OCCUPIED  ; B8 (Standard)
    mov cinemaHall[23], SEAT_OCCUPIED  ; B9 (Standard)
    mov cinemaHall[45], SEAT_OCCUPIED  ; D1 (Premium)
    mov cinemaHall[67], SEAT_OCCUPIED  ; E8 (Premium)
    mov cinemaHall[134], SEAT_OCCUPIED ; I5 (Couple)
    ret
InitializeDemoOccupiedSeats ENDP

; Wait for key press
WaitForKey PROC
    call ReadChar
    ret
WaitForKey ENDP

; Display final selection
DisplayFinalSelection PROC
    call Clrscr
    call DisplaySelectedSeats
    call DisplayTotalPrice
    ret
DisplayFinalSelection ENDP

main PROC
    call SeatSelection
    exit
main ENDP

End main