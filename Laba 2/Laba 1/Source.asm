.model flat, stdcall
.stack 100h

.data
    X dw 2231h
    Y dw 48B3h
    Z dw 6BB8h
    L dw ?
    R dw ?
    ;M dw ?
    G dw ?

.code
ExitProcess PROTO STDCALL : DWORD

point1 PROC
    mov bx, ax
    rol bx, 8
    mov ax, bx
    ret
point1 ENDP

point2 PROC
    add ax, 10BAh
    jmp check_even_count
    ret
point2 ENDP

Start:
    xor ax, ax
    xor dx, dx
    xor cx, cx
    xor bx, bx

    ; �������� ������ ������ �������
    lea esi, X
    mov cx, 0F291h   ; ��������� �������� F291 � ������� CX

    ; ���� ��������� X, Y, Z
subtract_loop:
    mov ax, [esi]      ; �������� ���������� �������� � ������� AX
    sub cx, ax         ; ��������� F291 �� �������� ��������
    mov [esi], ax      ; ���������� ���������� ������� � ������
    add esi, 2         ; ������� � ���������� �������� � �������
    cmp esi, OFFSET L  ; ��������, �������� �� ����� �������
    jne subtract_loop  ; ��������� ���� ��� ��������� ���������
    mov L, cx        ; ��������� ��������� � L
    xor cx, cx

    ; ���������� M
    mov ax, X
    and ax, Y
    mov bx, L
    shr bx, 1
    add ax, bx
    ;�������������� �����
    sub ax, 07D0h
    xor bx, bx

    
    
    ; �������� ������� M < 99F
    cmp ax, 099Fh
    jb label1   ; ���� M < 99F, ��������� � �/� 1

    ; ���� M >= 99F, ��������� � �/� 2
label2:
    call point2

label1:
    ; ������������ ������� � ������� ������ M
    call point1

check_even_count:
    ; ������� ���������� ������ � ������� ����� R
    mov bx, ax
    and bx, 00FFh      ; ��������� ������ ������� ����
    xor cx, cx         ; ������� ������
count_bits_loop:
    test bx, 1         ; ��������� ������� ���
    jz bit_is_zero     ; ���� ��� ����� 0, ���������� ��������� ��������
    inc cx             ; ��������� ��������
bit_is_zero:
    shr bx, 1          ; �������� ������� ������
    jnz count_bits_loop ; ��������� ����, ���� ������� �� ������ �������

    ; �������� �������� �������� ������
    test cx, 1
    jz adr1     ; ���� ������ ���������� ������, ��������� � ���1

    ; �����, ��������� � ���2
    xor ax, 0F0Fh
    jmp finish

adr1:
    and ax, 0F0F0h

finish:
    mov R, ax
    
    INVOKE ExitProcess, R
END Start