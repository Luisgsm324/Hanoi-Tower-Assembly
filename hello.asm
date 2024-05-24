section .data
    first_question db "Insira a torre inicial:", 0x0
    lenFirstQuestion equ $- first_question - 1

    second_question db "Insira a torre final:", 0x0
    lenSecondQuestion equ $- second_question - 1

    firstMsg db "Mova disco 1 da Torre "
    lenFirstMsg equ $- firstMsg

    secondMsg db " para a Torre "
    lenSecondMsg equ $- secondMsg


section .bss
    initial_tower resb 2
    final_tower resb 2

section .text

global _start

_start:
    ; Processo de escrever a mensagem de input
    mov eax, 0x4
    mov ebx, 0x1
    mov ecx, first_question
    mov edx, lenFirstQuestion
    int 0x80


    ; Processo de armazenar variável
    mov eax, 0x3
    mov ebx, 0x0

    mov ecx, initial_tower
    mov edx, 2
    int 0x80


    ; Processo para escrever a segunda pergunta 
    mov eax, 0x4
    mov ebx, 0x1

    mov ecx, second_question
    mov edx, lenSecondQuestion
    int 0x80


    ; Processo para armazenar a variável da segunda pergunta

    mov eax, 0x3
    mov ebx, 0x0
    mov ecx, final_tower
    mov edx, 2
    int 0x80


    ; Processo completo para escrever toda a string

    mov eax, 0x4
    mov ebx, 0x1
    mov ecx, firstMsg
    mov edx, lenFirstMsg
    int 0x80

    mov eax, 0x4
    mov ebx, 0x1
    mov ecx, initial_tower
    mov edx, 1
    int 0x80

    mov eax, 0x4
    mov ebx, 0x1
    mov ecx, secondMsg
    mov edx, lenSecondMsg
    int 0x80

    mov eax, 0x4
    mov ebx, 0x1
    mov ecx, final_tower
    mov edx, 1
    int 0x80

    mov eax, 0x1
    mov ebx, 0x0
    int 0x80
