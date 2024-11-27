section .data
    sensor_value db 0       ; Memory location simulating the water level sensor
    motor_status db 0       ; Memory location to represent motor state (0 = off, 1 = on)
    alarm_status db 0       ; Memory location to represent alarm state (0 = off, 1 = on)

    high_threshold db 70    ; Water level threshold for triggering alarm
    moderate_threshold db 30 ; Water level threshold for stopping the motor

    prompt db "Enter sensor value (0-100): ", 0
    motor_on_msg db "Motor turned ON.", 10, 0
    motor_off_msg db "Motor turned OFF.", 10, 0
    alarm_msg db "ALARM TRIGGERED!", 10, 0
    newline db 10, 0

section .bss
    input resb 4            ; Buffer for user input

section .text
    global _start

_start:
    ; Prompt user to input the sensor value
    mov eax, 4               ; sys_write
    mov ebx, 1               ; file descriptor (stdout)
    mov ecx, prompt          ; Address of the prompt
    mov edx, 30              ; Length of the prompt
    int 0x80

    ; Read user input
    mov eax, 3               ; sys_read
    mov ebx, 0               ; file descriptor (stdin)
    mov ecx, input           ; Buffer to store input
    mov edx, 4               ; Max bytes to read
    int 0x80

    ; Convert ASCII input to integer
    mov eax, dword [input]   ; Load input
    sub eax, '0'             ; Convert ASCII to integer
    mov [sensor_value], al   ; Store the sensor value in memory

    ; Read the sensor value
    mov al, [sensor_value]   ; Load the sensor value

    ; Check if water level is too high (>= high_threshold)
    mov bl, [high_threshold] ; Load the high threshold
    cmp al, bl
    jae trigger_alarm         ; If sensor value >= high_threshold, trigger alarm

    ; Check if water level is moderate (< high_threshold and >= moderate_threshold)
    mov bl, [moderate_threshold] ; Load the moderate threshold
    cmp al, bl
    jae stop_motor            ; If sensor value >= moderate_threshold, stop motor

    ; Default action: Turn motor ON
turn_motor_on:
    mov byte [motor_status], 1 ; Set motor_status = 1 (motor ON)
    ; Print motor ON message
    mov eax, 4                ; sys_write
    mov ebx, 1                ; file descriptor (stdout)
    mov ecx, motor_on_msg     ; Address of motor ON message
    mov edx, 16               ; Length of the message
    int 0x80
    jmp done                  ; Skip remaining checks

trigger_alarm:
    mov byte [alarm_status], 1 ; Set alarm_status = 1 (alarm ON)
    ; Print alarm message
    mov eax, 4                ; sys_write
    mov ebx, 1                ; file descriptor (stdout)
    mov ecx, alarm_msg        ; Address of alarm message
    mov edx, 18               ; Length of the message
    int 0x80
    jmp done                  ; Skip remaining checks

stop_motor:
    mov byte [motor_status], 0 ; Set motor_status = 0 (motor OFF)
    ; Print motor OFF message
    mov eax, 4                ; sys_write
    mov ebx, 1                ; file descriptor (stdout)
    mov ecx, motor_off_msg    ; Address of motor OFF message
    mov edx, 17               ; Length of the message
    int 0x80

done:
    ; Print newline
    mov eax, 4                ; sys_write
    mov ebx, 1                ; file descriptor (stdout)
    mov ecx, newline          ; Address of newline
    mov edx, 1                ; Length of newline
    int 0x80

    ; Exit program
    mov eax, 1                ; sys_exit
    xor ebx, ebx              ; Return 0
    int 0x80
