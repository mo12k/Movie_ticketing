INCLUDE Irvine32.inc

Movie_MAXCount = 5
MAXShowtimes   = 20
TimeSize       = 7
Movie_NameSize = 30
Movie_DescSize = 45

.data
fullBoard	byte "=============================", 0DH, 0AH,
				 "|     ADMIN   DASHBOARD     |", 0DH, 0AH,
				 "=============================", 0DH, 0AH,
				 "  1. Update Movie            ", 0DH, 0AH,
				 "  2. Adjust Movie Pricing    ", 0DH, 0AH,
				 "  3. Set Movie Showtimes     ", 0DH, 0AH,
				 "  4. Generate Monthly Report ", 0DH, 0AH,
				 "  5. Back to Login Site      ", 0DH, 0AH,
				 "=============================", 0DH, 0AH, 0

ListHeader	byte "==============================================", 0DH, 0AH,
				 "|           M O V I E      L I S T           |", 0DH, 0AH,
				 "==============================================", 0DH, 0AH, 0
				 
ListHeader2 byte "===============================================", 0DH, 0AH,
                 "|     C U R R E N T   P R I C E   L I S T     |", 0DH, 0AH,
                 "===============================================", 0DH, 0AH, 0

ListFooter1	byte "==============================================", 0DH, 0AH,
				 "Press 'Enter' to continue... ", 0DH, 0AH, 0

ListFooter2 byte "==============================================", 0DH, 0AH, 0

MovieShow   byte Movie_MAXCount * MAXShowtimes * TimeSize DUP(?)
MovieName	byte Movie_MAXCount * Movie_NameSize DUP(?)
MovieDesc	byte Movie_MAXCount * Movie_DescSize DUP(?)
MovieCount	dword 3
TimeCount   dword 4, 4, 4, 0, 0
MovieStatus dword Movie_MAXCount DUP(?)

initMovie1  byte "Avatar: The Way of Fire ", 0
initMovie2  byte "Evengers: End Game ", 0
initMovie3  byte "Tatanic ", 0

initDesc1   byte "Epic sci-fi adventure with stunning visuals. ", 0
initDesc2   byte "Heroes unite to save the universe. ", 0
initDesc3   byte "Tragic love aboard a doomed ship. ", 0

Price2D1    dword 1200
Price2D2    dword 1800
Price2D3    dword 2400

PriceIM1    dword 2000
PriceIM2    dword 3000
PriceIM3    dword 4000

ComboA      dword 1095
ComboB      dword 1370
ComboC      dword 1888
ComboX      dword 0

MovieTime1  byte "10:00", 0, 0
MovieTime2  byte "13:00", 0, 0
MovieTime3  byte "16:00", 0, 0
MovieTime4  byte "19:00", 0, 0
            byte (MAXShowtimes - 4) * TimeSize DUP(0)


            byte 2 * MAXShowtimes * TimeSize DUP(0)

status1		byte "[Coming Soon]", 0
status2		byte "[Now Showing]", 0
status3		byte "[Ended]", 0

menu1		byte "=============================", 0DH, 0AH,
				 "|      Operation  Task      |", 0DH, 0AH,
				 "=============================", 0DH, 0AH,
				 "  [1] Add New Movie          ", 0DH, 0AH,
				 "  [2] Update Movie Status    ", 0DH, 0AH,
				 "  [3] Remove Movie           ", 0DH, 0AH,
				 "  [4] Back to Dashboard      ", 0DH, 0AH,
				 "=============================", 0DH, 0AH, 0

menu2		byte "=============================", 0DH, 0AH,
                 "|      Operation  Task      |", 0DH, 0AH,
                 "=============================", 0DH, 0AH,
                 "  [1] Adjust 2D Price        ", 0DH, 0AH,
                 "  [2] Adjust IMAX Price      ", 0DH, 0AH,
                 "  [3] Adjust Combo Price     ", 0DH, 0AH,
                 "  [4] Back to Dashboard      ", 0DH, 0AH,
                 "=============================", 0DH, 0AH, 0

menu3		byte "=============================", 0DH, 0AH,
				 "|      Operation  Task      |", 0DH, 0AH,
				 "=============================", 0DH, 0AH,
				 "  [1] Add New Showtime       ", 0DH, 0AH,
                 "  [2] Back to Dashboard      ", 0DH, 0AH,
				 "=============================", 0DH, 0AH, 0

menu4		byte "=============================", 0DH, 0AH,
                 "|      Operation  Task      |", 0DH, 0AH,
                 "=============================", 0DH, 0AH,
                 "  [1] Generate Report        ", 0DH, 0AH,
                 "  [2] Back to Dashboard      ", 0DH, 0AH,
                 "=============================", 0DH, 0AH, 0

prompt1		byte "Select your operation [1 - 5]: ", 0
prompt2		byte "Select your operation [1 - 4]: ", 0
prompt3		byte "Select your operation [1 - 2]: ", 0
prompt4		byte "Select your choice [1 - 4]: ", 0
promptX		byte "Do you wish to continue? [7 = yes, 0 = no]: ", 0

msg0		byte "INVALID operation! Try again.", 0

msg101		byte "New Movie Name: ", 0
msg102		byte "New Movie Description: ", 0
msg103		byte "Confirm? [Y / N]: ", 0
msg104		byte "New movie successfully added!", 0
msg105		byte "Movie list is full.", 0

msg110		byte "Select the movie [1 - ", 0
msg111		byte "]: ", 0
msg112		byte "Confirm update from [Coming Soon] to [Now Showing]? [Y / N]: ", 0
msg113		byte "Confirm update from [Now Showing] to [Ended]? [Y / N]: ", 0
msg114		byte "The movie is already ended. ", 0
msg115		byte "Movie status successfully updated!", 0

msg121		byte "Confirm to remove this movie? [Y / N]: ", 0
msg122		byte "Movie successfully removed!", 0

msg201      byte "  2D Standard   : RM ", 0
msg202      byte "  2D Premium    : RM ", 0
msg203      byte "  2D Couple     : RM ", 0
msg204      byte "  IMAX Standard : RM ", 0
msg205      byte "  IMAX Premium  : RM ", 0
msg206      byte "  IMAX Couple   : RM ", 0
msg207      byte "  Combo A       : RM ", 0
msg208      byte "  Combo B       : RM ", 0
msg209      byte "  Combo C       : RM ", 0
msg210      byte "  No Combo      : RM ", 0

menu10      byte "=============================", 0DH, 0AH,
                 "|         2D TICKET         |", 0DH, 0AH,
                 "=============================", 0DH, 0AH,
                 "  [1] STANDARD               ", 0DH, 0AH,
                 "  [2] PREMIUM                ", 0DH, 0AH,
                 "  [3] COUPLE                 ", 0DH, 0AH,
                 "  [4] Back to Price List     ", 0DH, 0AH,
                 "=============================", 0DH, 0AH, 0

menu11      byte "=============================", 0DH, 0AH,
                 "|        IMAX TICKET        |", 0DH, 0AH,
                 "=============================", 0DH, 0AH,
                 "  [1] STANDARD               ", 0DH, 0AH,
                 "  [2] PREMIUM                ", 0DH, 0AH,
                 "  [3] COUPLE                 ", 0DH, 0AH,
                 "  [4] Back to Price List     ", 0DH, 0AH,
                 "=============================", 0DH, 0AH, 0

menu12      byte "=============================", 0DH, 0AH,
                 "|        FOOD  COMBO        |", 0DH, 0AH,
                 "=============================", 0DH, 0AH,
                 "  [1] COMBO A                ", 0DH, 0AH,
                 "  [2] COMBO B                ", 0DH, 0AH,
                 "  [3] COMBO C                ", 0DH, 0AH,
                 "  [4] Back to Price List     ", 0DH, 0AH,
                 "=============================", 0DH, 0AH, 0

msg220      byte "Enter new price (RM): ", 0
msg221      byte "New price successfully updated!", 0
msg222      byte "INVALID input! Try again.", 0

msg301      byte "Enter new showtime (HH:MM): ", 0
msg302      byte "Showtime added successfully! ", 0
msg303      byte "Maximum showtimes reached!", 0
msg304      byte "INVALID time format! Try again. ", 0
msg305      byte "CONFLICTED time! Try again. ", 0

msg4        byte "????", 0

msg501		byte "Returning to Login site... ", 0
msg502		byte "Returning to Dashboard... ", 0
msg503		byte "Returning to Price list... ", 0

msg6		byte "Good Work! Thank You!", 0

bufferName	byte Movie_NameSize DUP(?)
bufferName1 byte Movie_NameSize + 1 DUP(?)
bufferDesc	byte Movie_DescSize DUP(?)
intBuffer   dword ?
bufferTime  byte 16 DUP(?)

userChoice  dword ?
hundred dword 100


.code
main PROC

call Movie

dashboardLoop:
	mov edx, OFFSET fullBoard
	call WriteString

	mov edx, OFFSET prompt1
	call WriteString

	call ReadChar
	call WriteChar
	call Crlf

	cmp al, '1'
	je Status
	cmp al, '2'
	je Pricing
	cmp al, '3'
	je Showtimes
	cmp al, '4'
	je Report
	cmp al, '5'
	je BackLogin
	jmp Invalid1

Status:
	call displayMovieList
	jmp StatusMenu

StatusMenu:
	mov edx, OFFSET menu1
	call WriteString

	mov edx, OFFSET prompt2
	call WriteString

	call ReadChar
	call WriteChar
	call Crlf

	cmp al, '1'
	je AddMovie
	cmp al, '2'
	je UpdateMovie
    cmp al, '3'
    je RemoveMovie
	cmp al, '4'
	je BackDashboard
	jmp Invalid2

AddMovie:
	call AddNewMovie
    jmp Return

UpdateMovie:
	call UpdateMovieStatus
	jmp Return

RemoveMovie:
    call RemoveSelectMovie
    jmp Return

Pricing:
	call AdjustPricing
	cmp al, '4'
    je BackDashboard
	jmp Return

Showtimes:
	call SetShowtimes
    cmp al, '2'
    je BackDashboard
    jmp Return

Report:
	mov edx, OFFSET msg4
	call WriteString
	call Crlf
	jmp Return

BackLogin:
	mov edx, OFFSET msg501
	call WriteString
	call Crlf
	exit

BackDashboard:
	mov edx, OFFSET msg502
	call WriteString
	call Crlf
	jmp dashboardLoop

Return:
	mov edx, OFFSET promptX
	call WriteString
	call ReadChar
	call WriteChar
	call Crlf

	cmp al, '7'
	je BackDashboard
	cmp al, '0'
	je dashboardQuit
	jmp InvalidX

dashboardQuit: 
	mov edx, OFFSET msg6
	call WriteString
	exit

Invalid1:
	mov edx, OFFSET msg0
	call WriteString
	call Crlf
	jmp dashboardLoop

Invalid2:
	mov edx, OFFSET msg0
	call WriteString
	call Crlf
	jmp StatusMenu

InvalidX:
	mov edx, OFFSET msg0
	call WriteString
	call Crlf
	jmp Return

main ENDP


Movie PROC
	mov MovieCount, 3

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

    mov ecx, Movie_MAXCount
    sub ecx, MovieCount
    jz initDone

initStatusLoop:
    mov [edi], eax
    add edi, 4
    loop initStatusLoop

initDone:
    ret

Movie ENDP


displayMovieList PROC
	mov edx, OFFSET ListHeader
	call WriteString

	mov ecx, MovieCount
    mov esi, OFFSET MovieName
    mov edi, OFFSET MovieDesc
	mov ebx, OFFSET MovieStatus

displayMovieLoop:
    cmp ecx, 0
    je  displayDone

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
    call Crlf

    mov edx, edi
	call WriteString
	call Crlf
	call Crlf

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

    ret
displayMovieList ENDP


AddNewMovie PROC
	mov eax, MovieCount
    cmp eax, Movie_MAXCount
    jae MovieListFull
	
NewMovie:
	mov edx, OFFSET msg101
    call WriteString
    mov edx, OFFSET bufferName
    mov ecx, Movie_NameSize
    call ReadString
	call Crlf

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
    call Crlf

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
    call Crlf
    ret

MovieListFull:
    mov edx, OFFSET msg105
    call WriteString
    call Crlf
    ret

AddNewMovie ENDP


UpdateMovieStatus PROC
SelectMovie:
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
	call Crlf
	ret

askConfirm:
    call ReadChar
    call WriteChar
    call Crlf

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
    call Crlf
    ret

statusOK:
    mov edx, OFFSET msg115
    call WriteString
    call Crlf
    ret

UpdateMovieStatus ENDP


RemoveSelectMovie PROC
SelectMovie:
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
    call Crlf

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

    mov eax, ebx
    add eax, 1
    shl eax, 2                   
    mov esi, OFFSET MovieStatus
    add esi, eax
    mov eax, [esi]               

    mov eax, ebx
    shl eax, 2                   
    mov edi, OFFSET MovieStatus
    add edi, eax
    mov [edi], eax

    inc ebx
    jmp ShiftLoop

ShiftDone:
    dec MovieCount

    mov edx, OFFSET msg122
    call WriteString
    call Crlf
    ret

RemoveSelectMovie ENDP


AdjustPricing PROC
AdjustMenu:
    call Crlf
    mov edx, OFFSET ListHeader2
    call WriteString

    mov edx, OFFSET msg201
    call WriteString
    mov eax, Price2D1
    mov ebx, 100
    mov ecx, 2
    call TwoDecimal
    call Crlf

    mov edx, OFFSET msg202
    call WriteString
    mov eax, Price2D2
    mov ebx, 100
    mov ecx, 2
    call TwoDecimal
    call Crlf

    mov edx, OFFSET msg203
    call WriteString
    mov eax, Price2D3
    mov ebx, 100
    mov ecx, 2
    call TwoDecimal
    call Crlf

    mov edx, OFFSET msg204
    call WriteString
    mov eax, PriceIM1
    mov ebx, 100
    mov ecx, 2
    call TwoDecimal
    call Crlf

    mov edx, OFFSET msg205
    call WriteString
    mov eax, PriceIM2
    mov ebx, 100
    mov ecx, 2
    call TwoDecimal
    call Crlf

    mov edx, OFFSET msg206
    call WriteString
    mov eax, PriceIM3
    mov ebx, 100
    mov ecx, 2
    call TwoDecimal
    call Crlf

    mov edx, OFFSET msg207
    call WriteString
    mov eax, ComboA
    mov ebx, 100
    mov ecx, 2
    call TwoDecimal
    call Crlf

    mov edx, OFFSET msg208
    call WriteString
    mov eax, ComboB
    mov ebx, 100
    mov ecx, 2
    call TwoDecimal
    call Crlf

    mov edx, OFFSET msg209
    call WriteString
    mov eax, ComboC
    mov ebx, 100
    mov ecx, 2
    call TwoDecimal
    call Crlf

    mov edx, OFFSET msg210
    call WriteString
    mov eax, ComboX
    mov ebx, 100
    mov ecx, 2
    call TwoDecimal
    call Crlf

    mov edx, OFFSET ListFooter1
    call WriteString
    call Crlf

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
    call Crlf

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
    call Crlf

    mov edx, OFFSET menu10
    call WriteString

    mov edx, OFFSET prompt4
    call WriteString
    call ReadChar
    call WriteChar
    call Crlf

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
    call Crlf

    mov edx, OFFSET msg220
    call WriteString
    call ReadInt
    mov ebx, 100
    imul eax, ebx
    mov Price2D1, eax
    jmp NewConfirm

New2D2:
    call Crlf

    mov edx, OFFSET msg220
    call WriteString
    call ReadInt
    mov ebx, 100
    imul eax, ebx
    mov Price2D2, eax
    jmp NewConfirm

New2D3:
    call Crlf

    mov edx, OFFSET msg220
    call WriteString
    call ReadInt
    mov ebx, 100
    imul eax, ebx
    mov Price2D3, eax
    jmp NewConfirm

AdjustIMAX:
    call Crlf

    mov edx, OFFSET menu11
    call WriteString

    mov edx, OFFSET prompt4
    call WriteString
    call ReadChar
    call WriteChar
    call Crlf

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
    call Crlf

    mov edx, OFFSET msg220
    call WriteString
    call ReadInt
    mov ebx, 100
    imul eax, ebx
    mov PriceIM1, eax
    jmp NewConfirm

NewIM2:
    call Crlf

    mov edx, OFFSET msg220
    call WriteString
    call ReadInt
    mov ebx, 100
    imul eax, ebx
    mov PriceIM2, eax
    jmp NewConfirm

NewIM3:
    call Crlf

    mov edx, OFFSET msg220
    call WriteString
    call ReadInt
    mov ebx, 100
    imul eax, ebx
    mov PriceIM3, eax
    jmp NewConfirm

AdjustCombo:
    call Crlf

    mov edx, OFFSET menu12
    call WriteString

    mov edx, OFFSET prompt4
    call WriteString
    call ReadChar
    call WriteChar
    call Crlf

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
    call Crlf

    mov edx, OFFSET msg220
    call WriteString
    call ReadInt
    mov ebx, 100
    imul eax, ebx
    mov ComboA, eax
    jmp NewConfirm

NewComboB:
    call Crlf

    mov edx, OFFSET msg220
    call WriteString
    call ReadInt
    mov ebx, 100
    imul eax, ebx
    mov ComboB, eax
    jmp NewConfirm

NewComboC:
    call Crlf

    mov edx, OFFSET msg220
    call WriteString
    call ReadInt
    mov ebx, 100
    imul eax, ebx
    mov ComboC, eax
    jmp NewConfirm

NewConfirm:
    mov edx, OFFSET msg103
    call WriteString
    call ReadChar
    call WriteChar
    call Crlf

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
    call Crlf
    ret

Invalid4:
    mov edx, OFFSET msg222
    call WriteString
    call Crlf
    jmp PriceOperation

backDashboard:
    mov edx, OFFSET msg503
    ret

AdjustPricing ENDP


SetShowtimes PROC
ShowtimesList:
    call Crlf
    call displayShowtimesList

pressEnter:
    call ReadChar
    cmp al, 0DH
    jne pressEnter

ShowtimesMenu:
    mov edx, OFFSET menu3
    call WriteString

    mov edx, OFFSET prompt3
    call WriteString
    call ReadChar
    call WriteChar
    call Crlf

    cmp al, '1'
    je AddTime
    cmp al, '2'
    je backDashboard
    jmp Invalid4

AddTime:
    call AddShowtime
    call Crlf
    ret

backDashboard:
    call Crlf
    ret

Invalid4:
    mov edx, OFFSET msg222
    call WriteString
    call Crlf
    jmp ShowtimesMenu

SetShowtimes ENDP


displayShowtimesList PROC
    pushad
    mov edx, OFFSET ListHeader
    call WriteString

    mov ecx, MovieCount
    mov esi, OFFSET MovieName
    xor ebx, ebx

NextMovie:
    cmp ecx, 0
    je DoneList

    mov edx, esi
    call WriteString
    call Crlf

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

ShowLoop:
    cmp ecx, 0
    je ShowDone
    
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
    jmp ShowLoop

ShowDone:
    call Crlf
    call Crlf
    pop ecx

    add esi, Movie_NameSize
    inc ebx
    dec ecx
    jmp NextMovie
    
DoneList:
    mov edx, OFFSET ListFooter1
    call WriteString
    call Crlf

    popad
    ret

displayShowtimesList ENDP


AddShowtime PROC
    pushad

SelectMovie:
    call Crlf

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
    jl SelectMovie
    cmp edi, eax
    jge SelectMovie

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
    jne CheckColon
    cmp ah, '0'
    jb InvalidFormat
    cmp ah, '3'
    ja InvalidFormat

CheckColon:
    mov al, [esi+2]
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

ConfirmAdd:
    mov edx, OFFSET msg103
    call WriteString
    call ReadChar
    call WriteChar
    call Crlf

    cmp al, 'Y'
    je SetMovieIndex
    cmp al, 'y'
    je SetMovieIndex
    cmp al, 'N'
    je PromptTime
    cmp al, 'n'
    je PromptTime
    jmp ConfirmAdd

SetMovieIndex:
    mov ebx, edi
    jmp SaveTime

SaveTime:
    mov eax, ebx
    shl eax, 2
    mov edi, OFFSET TimeCount
    add edi, eax
    mov ecx, [edi]

    cmp ecx, MAXShowtimes
    jae MaxReached

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
    call Crlf
    jmp DoneAdd

InvalidFormat:
    mov edx, OFFSET msg304
    call WriteString
    call Crlf
    jmp PromptTime

MaxReached:
    mov edx, OFFSET msg303
    call WriteString
    call Crlf
    jmp DoneAdd

DoneAdd:
    popad
    ret

AddShowtime ENDP


TwoDecimal PROC
    pushad
    mov  edi, ecx
    xor  esi, esi
    test eax, eax
    jns  NumOk
    neg  eax
    inc  esi

NumOk:
    test ebx, ebx
    jns  DenOk
    neg  ebx
    inc  esi

DenOk:
    xor  edx, edx
    div  ebx

    test esi, 1
    jz   NoSign
    mov  al, '-'
    call WriteChar

NoSign:
    push eax
    call WriteDec
    pop  eax

    cmp  edi, 0
    jz   Done

    mov  al, '.'
    call WriteChar

DecLoop:
    cmp  edi, 0
    je   Done

    mov  eax, edx
    xor  edx, edx
    mov  ecx, 10
    mul  ecx
    div  ebx

    add  al, '0'
    call WriteChar

    dec  edi
    jmp  DecLoop

Done:
    popad
    ret
TwoDecimal ENDP


END main