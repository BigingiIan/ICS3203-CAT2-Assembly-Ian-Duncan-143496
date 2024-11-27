section .data
    prompt db "Enter a number: ", 0
    positive_msg db "The number is POSITIVE.", 10, 0
    negative_msg db "The number is NEGATIVE.", 10, 0
    zero_msg db "The number is ZERO.", 10, 0

section .bss
    input resb 4; Reserve space for input

section.text
    global _start

_start
    ; Print prompt
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt
    mov edx, 15
    int 0x80

    ; Read user input
    mov eax, 3
    mov ebx, 0
    mov ecx, input
    mov edx, 4
    int 0x80

    ; Convert ASCII input to integer
    mov eax, dword [input]
    sub eax, '0'

    ; Branching logic for classification
    cmp eax, 0
    je is_zero
    jl is_negative 

is_positive:
    ; Print "POSITIVE"
    mov eax, 4
    mov ebx, 1
    mov ecx, positive_msg
    mov edx, 25
    int 0x80
    jmp done

is_negative:
    ; Print "NEGATIVE"
    mov eax, 4
    mov ebx, 1
    mov ecx, negative_msg
    mov edx, 25
    int 0x80
    jmp done

is_zero:
    ; Print "ZERO"
    mov eax, 4
    mov ebx, 1
    mov ecx, zero_msg
    mov edx, 20
    int 0x80

done:
    ; Exit program
    mov eax, 1
    xor ebx, ebx
    int 0x80