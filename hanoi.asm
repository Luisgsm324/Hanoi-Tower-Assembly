section .data
    question_length_disks db "Qual o número de discos? ", 0x0
    len_question_length_disks equ $- question_length_disks - 1

    firstMsg db "Mova o disco ", 0x0
    secondMsg db " de ", 0x0
    thirdMsg db " para ", 0x0
    nextLine db 0xA
    lenFirstMsg equ $- firstMsg
    
    buffer db 0

section .bss
    length_disks_string resb 1 
    length_disks_hex resd 1

section .text
global _start

_start:
    ; Printando numero de discos
    mov eax, 0x4
    mov ebx, 0x1
    mov ecx, question_length_disks
    mov edx, len_question_length_disks
    int 0x80
        
    ; Armazenando número de discos
    mov eax, 0x3
    mov ebx, 0x0
    mov ecx, length_disks_string
    mov edx, 2
    int 0x80


    movzx eax, byte[length_disks_string]
    mov [length_disks_hex], eax
    
    mov eax, 0x42
    mov ebx, 0x43
    mov ecx, 0x41
    mov edx, dword[length_disks_hex] ; 51 -> 3 (Número de discos)

    call hanoi    
    jmp exit
    
print_move:
    mov eax, [esp+4]
    mov [firstMsg+13], al
    
    mov ebx, [esp+8]
    mov [secondMsg+4], bl

    mov ecx, [esp+12]
    mov [thirdMsg+6], cl
    
    mov eax, 0x4
    mov ebx, 0x1
    mov ecx, firstMsg
    mov edx, lenFirstMsg
    int 0x80
    ret

    
igual_a_1:
    call print_move
    add esp, 16
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
    
    add esp, 16
    ret
    
exit:
    mov eax, 0x1
    mov ebx, 0x0
    int 0x80
    ret
