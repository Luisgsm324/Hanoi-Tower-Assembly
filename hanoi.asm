section .data
    question_length_disks db "Qual o número de discos? ", 0x0
    len_question_length_disks equ $- question_length_disks - 1

    firstMsg db "Mova disco 1 da Torre "
    lenFirstMsg equ $- firstMsg

    secondMsg db " para a Torre "
    lenSecondMsg equ $- secondMsg

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
    ; Printando numero de discos
    mov ecx, question_length_disks
    mov edx, len_question_length_disks
    call print
    
    ; Armazenando número de discos
    mov eax, 0x3
    mov ebx, 0x0
    mov ecx, length_disks
    mov edx, 2
    int 0x80
    
; n = eax
; origem = ebx
; destino = ecx
; final = edx

.hanoi:
    push 
    
    jmp exit

exit:
    mov eax, 0x1
    mov ebx, 0x0
    int 0x80
    ret
    
