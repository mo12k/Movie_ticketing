INCLUDE Irvine32.inc

.data
    dateStr BYTE "Current Date: ", 0
    timeStr BYTE "Current Time: ", 0
    newline BYTE 0Dh, 0Ah, 0
    sysTime SYSTEMTIME <>

.code
main PROC
    ; Display date string
    mov edx, OFFSET dateStr
    call WriteString
    
    ; Get current system time
    INVOKE GetLocalTime, ADDR sysTime
    
    ; Display month
    movzx eax, sysTime.wMonth
    call WriteDec
    mov al, '/'
    call WriteChar
    
    ; Display day
    movzx eax, sysTime.wDay
    call WriteDec
    mov al, '/'
    call WriteChar
    
    ; Display year
    movzx eax, sysTime.wYear
    call WriteDec
    
    ; New line
    mov edx, OFFSET newline
    call WriteString
    
    ; Display time string
    mov edx, OFFSET timeStr
    call WriteString
    
    ; Display hours
    movzx eax, sysTime.wHour
    call WriteDec
    mov al, ':'
    call WriteChar
    
    ; Display minutes
    movzx eax, sysTime.wMinute
    call WriteDec
    mov al, ':'
    call WriteChar
    
    ; Display seconds
    movzx eax, sysTime.wSecond
    call WriteDec
    
    ; New line
    mov edx, OFFSET newline
    call WriteString
    
    call WaitMsg        ; Wait for user input
    exit
main ENDP
END main