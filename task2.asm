section .data
    prompt db "Enter 3 integers (one at a time): ", 0
    reverse_msg db "The reversed array is: ", 10, 0
    input_msg db "Enter number: ", 0
    newline db 10, 0

section .bss
    array resd 5
    temp resd 1

section .text
    global _start

_start
    ; Prompt user to input 5 integers
    mov ecx, 5
    mov esi, array

get_input:
    ; Print "Enter number:"
    mov eax, 4
    mov ebx, 1
    mov ecx, input_msg
    mov edx, 14
    int 0x80

    ; Read user input
    mov eax, 3
    mov ebx, 0
    lea ecx, [esi]
    mov edx, 4
    int 0x80

    ; Convert ASCII input to integer
    mov eax, dword [esi]
    sub eax, '0'
    mov [esi], eax
    add esi, 4
    loop get_input

    ; Reverse the array in place
    mov ecx, 2
    mov esi, array
    lea edi, [array + 16]

reverse_array:
    ; Swap elements
    mov eax, [esi]
    mov edx, [edi]
    mov [esi], edx
    mov [edi], eax

    ; Update pointers
    add esi, 4
    sub edi, 4
    loop reverse_array

    ; Output the reversed array 
    mov eax, 4
    mov ebx, 1
    mov ecx, reverse_msg
    mov edx, 24
    int 0x80

    mov ecx, 5
    mov esi, array

output_array:
    ; Print each integer
    mov eax, [esi]
    add eax, '0'
    push eax
    mov ecx, esp
    mov edx, 1
    mov eax, 4
    mov ebx, 1
    int 0x80
    pop eax

    ; Print newline after each number 
    mov eax, 4
    mov ebx, 1
    mov exd, newline
    mov edx, 1
    int 0x80

    add esi, 4
    loop output_array

    ; Exit programm
    mov eax, 1
    xor ebx, ebx
    int 0x80