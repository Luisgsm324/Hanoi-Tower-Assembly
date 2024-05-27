section .data
    question_length_disks db "Qual o número de discos? ", 0x0
    len_question_length_disks equ $- question_length_disks - 1

    first_msg db "Mova o disco ", 0x0
    second_msg db " de ", 0x0
    third_msg db " para ", 0x0, 0xA
    len_first_msg equ $- first_msg
    
    buffer db 0

section .bss
    length_disks_string resb 1 

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
    
    ; Colocando na pilha os parametros
    movzx edx, byte[length_disks_string] ; Numero de discos
    mov eax, 0x42 ; Auxiliar = B
    mov ebx, 0x43 ; Destino = C
    mov ecx, 0x41 ; Origim = A

    ; Chamando função
    call hanoi  
    
    ; Exit
    mov eax, 0x1
    mov ebx, 0x0
    int 0x80
    
print_move:
    ; Pegando da pilha o numero de discos e adicionando na string
    mov eax, [esp+4]
    mov [first_msg+13], al
    
    ; Pegando da pilha torre de origem e adicionando na string
    mov ebx, [esp+8]
    mov [second_msg+4], bl

    ; Pegando da pilha torre de destino e adicionando na string
    mov ecx, [esp+12]
    mov [third_msg+6], cl
    
    ; Printando Mova o disco...
    mov eax, 0x4
    mov ebx, 0x1
    mov ecx, first_msg
    mov edx, len_first_msg
    int 0x80
    ret

equals_1:
    ; Caso seja um, printa o movimento e "remova" da pilha os parametros
    call print_move
    add esp, 16
    ret

; (n: edx, origem, ecx, destino: ebx, auxiliar: eax)
hanoi:
    ; Colocando na pilha os parametros
    push eax ; Auxiliar
    push ebx ; Destino
    push ecx ; Origim
    push edx ; Numero de discos
   
    mov edx, [esp] ; Pegando o numero de discos do topo da pilha
    cmp edx, 0x31 ; Comparando para ver se é igual a 1
    je equals_1 ; Caso seja, ele irá para funca
    
    dec edx ; (n - 1)
    mov ecx, [esp+4] ; origem = origem
    mov ebx, [esp+12] ; destino = auxiliar
    mov eax, [esp+8] ; auxiliar = destino
    
    call hanoi ; (n: edx, origin: ecx, destino: ebx, auxiliar: eax)
    
    call print_move ; Printando movimento
    
    mov edx, [esp] ; Pegando o numero de discos do topo da pilha
    dec edx ; (n - 1)
    mov ecx, [esp+12] ; origem = auxiliar
    mov ebx, [esp+8] ; destino = destino
    mov eax, [esp+4] ; auxiliar = origem

    call hanoi ; (n: edx, origin: ecx, destino: ebx, auxiliar: eax)
    
    add esp, 16 ; "Removendo da pilha"
    ret
