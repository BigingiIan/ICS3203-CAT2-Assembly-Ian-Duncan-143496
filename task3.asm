section .data
    prompt db "Enter a number (0-12): ", 0
    result_msg db "Factorial is: ", 0
    newline db 10, 0

section .bss
    input resb 4

section .text
    global _start

_start
    ; Prompt user for input
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt
    mov edx, 22
    int 0x80

    ; Read user input
    mov eax, 3
    mov ebx, 0
    mov ecx, input
    mov edx, 4
    int 0x80

    ; Convert ASCII input to  integer
    mov eax, dword [input]
    sub eax, '0'
    mov ebx, eax

    ; Call factorial subroutine 
    push ebx
    call factorial
    add esp, 4

    ; Print the result message
    mov eax, 4
    mov ebx, 1
    mov ecx, result_msg
    mov edx, 14
    int 0x80

    ; Print the result
    push eax
    call print_number
    add esp, 4

    ; Print newline
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; Exit program
    mov eax, 1
    xor ebx, ebx
    int 0x80

factorial:
    ; Calculate factorial of a number in EBX
    push epb
    mov epb, esp
    push ebx

    cmp ebx, 1
    jle factorial_done

    dec ebx
    push ebx 
    call factorial
    add esp, 4

    mov ebx, [epb-4]
    mul ebx

factorial_done:
    pop ebx
    mov esp, epb
    pop epb
    ret 

print_number:
    ; Print number in EAX
    push epb
    mov epb, esp
    push eax

    mov ecx, 10
    xor edx, edx

print_loop:
    div ecx
    add dl, '0'
    push edx
    test eax, eax
    jnz print_loop

print_digits:
    pop eax
    mov [esp-4], eax
    mov ecx, esp-4
    mov eax, 4
    mov ebx, 1
    mov edx, 1
    int 0x80
    cmp esp, epb
    jne print_digits

    pop eax
    mov esp, epb
    pop epb
    ret
    