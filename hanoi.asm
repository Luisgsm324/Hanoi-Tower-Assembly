section .data
    question_msg db "Número de discos: ", 0x0
    lenQuestion_msg equ $ - question_msg

section .bss 
    discos resb 2
section .text

global _start

_start:
    mov eax, 0x4
    mov ebx, 0x1
    
    mov ecx, question_msg
    mov edx, lenQuestion_msg
    int 0x80

    mov eax, 0x3
    mov ebx, 0x0
    
    mov ecx, discos
    mov edx, 2
    int 0x80

hanoi_tower:

