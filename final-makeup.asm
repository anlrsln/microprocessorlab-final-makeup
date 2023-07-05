;Student Number
    ;2020556456
;Student Name and Surname
    ;Asım Anıl Arslan
;Github Username
    ;github.com/anlrsln

.MODEL SMALL
.STACK 100h

.DATA
    STUDENTNUMBER DB '2', '0', '2', '0', '5', '5', '6', '4', '5', '6', '$'
    MORNINGMSG DB ' Morning', 0Dh, 0Ah, '$'
    EVENINGMSG DB ' Evening', 0Dh, 0Ah, '$'

.CODE
    MOV AX, @DATA
    MOV DS, AX
    
    ; Copy STUDENTNUMBER 
    CALL CopyStudentNumber
    
    ; Display the STUDENTNUMBER
    CALL DisplayStudentNumber
    
    ; Check last digit and display appropriate message
    CALL DisplayMessage
    
    ; Exit the program
    CALL ExitProgram

CopyStudentNumber PROC
    ; Copy STUDENTNUMBER
    MOV BX, 0100h
    MOV ES, BX
    MOV DI, 2000h
    MOV SI, OFFSET STUDENTNUMBER
    MOV CX, 10  
    REP MOVSB
    
    MOV SI, OFFSET STUDENTNUMBER
    MOV DI, 0200h 
    MOV ES, DI 
    MOV DI, 2000h 
    MOV CX, 10 
    CLD 
    REP MOVSB 
    
    RET
CopyStudentNumber ENDP

DisplayStudentNumber PROC
    ; Display the STUDENTNUMBER
    MOV AH, 09h
    LEA DX, [0200h:2000h]
    INT 21h
    
    RET
DisplayStudentNumber ENDP

DisplayMessage PROC
    ; Retrieve last digit from STUDENTNUMBER
    MOV BX, 0200h
    MOV ES, BX
    MOV SI, 2006h  ; Point SI to the last digit in STUDENTNUMBER
    MOV AL, ES:[SI]
    
    ; Check if last digit is '5'
    CMP AL, '5'
    JE MORNING
    
    ; Check if last digit is '6'
    CMP AL, '6'
    JE EVENING
    
    ; Default message (for other digits)
    MOV AH, 09h
    LEA DX, MORNINGMSG
    INT 21h
    JMP END_DISPLAY
    
MORNING:
    MOV AH, 09h
    LEA DX, MORNINGMSG
    INT 21h
    JMP END_DISPLAY

EVENING:    
    MOV AH, 09h
    LEA DX, EVENINGMSG
    INT 21h

END_DISPLAY:
    RET
DisplayMessage ENDP

ExitProgram PROC
    ; Exit the program
    MOV AH, 4Ch
    INT 21h
    
    RET
ExitProgram ENDP

END

