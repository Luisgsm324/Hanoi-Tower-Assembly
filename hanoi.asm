section .data
    question_length_disks db "Qual o número de discos? ", 0x0
    len_question_length_disks equ $- question_length_disks - 1

    firstMsg db "Mova disco ", 0x0
    lenFirstMsg equ $- firstMsg - 1
    
    SecondMsg db " de ", 0x0
    lenSecondMsg equ $- SecondMsg - 1 

    thirdMsg db " para ", 0x0
    lenThirdMsg equ $- thirdMsg - 1
    
    
    
    one_hex db 0x31, 0x0
    
    next_line db 0xA, 0x0
    
    buffer db 0

section .bss
    length_disks resb 0x1

section .text
global _start

; Função para printar
print:
    mov eax, 0x4
    mov ebx, 0x1
    int 0x80
    ret

_start:
        ; ; Printando numero de discos
        ; mov ecx, question_length_disks
        ; mov edx, len_question_length_disks
        ; call print
        
        ; ; Armazenando número de discos
        ; mov eax, 0x3
        ; mov ebx, 0x0
        ; mov ecx, length_disks
        ; mov edx, 2
        ; int 0x80
    
    mov eax, 0x42
    mov ebx, 0x43
    mov ecx, 0x41
    mov edx, 0x33

    jmp hanoi    
    
print_move:
    mov ecx, firstMsg
    mov edx, lenFirstMsg
    call print
    
    mov eax, [esp+4]
    mov [buffer], al
    mov ecx, buffer
    mov edx, 1
    call print
    
    mov ecx, SecondMsg
    mov edx, lenSecondMsg
    call print
    
    mov ebx, [esp+8]
    mov [buffer], bl
    mov ecx, buffer
    mov edx, 1
    call print
    
    mov ecx, thirdMsg
    mov edx, lenThirdMsg
    call print

    mov ecx, [esp+12]
    mov [buffer], cl
    mov ecx, buffer
    mov edx, 1
    call print
    
    mov ecx, next_line
    mov edx, 1
    call print
    ret

    
igual_a_1:
    call print_move
    pop eax
    pop eax
    pop eax
    pop eax
    ret

; auxiliar = eax
; destino = ebx
; origem = ecx
; n = edx
hanoi:
    push eax
    push ebx
    push ecx
    push edx
   
    mov edx, [esp]
    cmp edx, 0x31
    je igual_a_1
    
    dec edx
    mov ecx, [esp+4]
    mov ebx, [esp+12]
    mov eax, [esp+8]
    
    call hanoi
    
    call print_move
    
    mov edx, [esp]
    dec edx
    mov ecx, [esp+12]
    mov ebx, [esp+8]
    mov eax, [esp+4]

    call hanoi
    
    pop eax
    pop eax
    pop eax
    pop eax
    ret
    
exit:
    mov eax, 0x1
    mov ebx, 0x0
    int 0x80
    ret