section .data
    v1 dw '109', 0xA, 0xD
    lenv1 equ $ - v1

section .bss
    BUFFER resb 10

section .text
global _start

_start:
    call convert_value
    call show_value 

    mov eax, 0x1
    mov ebx, 0x0
    int 0x80

convert_value:
    lea esi, [v1]
    mov ecx, v1
    call string_to_int

    add eax, 0x2 ; Teste para ver se está funcionando
    ret

show_value:
    call int_to_string
    ; printar o conteúdo
    mov eax, 0x4
    mov ebx, 0x1
    mov ecx, BUFFER
    mov edx, 10
    int 0x80

    ret


string_to_int:
    xor ebx, ebx ; Vai zerar o ebx

.prox_digit:
    movzx eax, byte[esi]
    test al, al  ; Verificar se chegou ao final da string
    jz .end_string_to_int
    inc esi
    sub al, '0'  ; Subtrair o valor ASCII de '0'
    imul ebx, 10
    add ebx, eax
    jmp .prox_digit

.end_string_to_int:
    mov eax, ebx
    ret


int_to_string:
    lea esi, [BUFFER + 10] ; Começar a escrever a partir do final do buffer
    mov byte [esi], 0 ; Null terminator
    dec esi ; Retroceder um byte
    mov ebx, 10
.prox_digit:
    xor edx, edx
    div ebx
    add dl, '0' ; Adicionar o valor ASCII de '0'
    dec esi
    mov [esi], dl
    test eax, eax
    jnz .prox_digit
    ret