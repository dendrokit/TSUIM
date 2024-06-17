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

    ; Загрузка адреса начала массива
    lea esi, X
    mov cx, 0F291h   ; сохраняем значение F291 в регистр CX

    ; Цикл вычитания X, Y, Z
subtract_loop:
    mov ax, [esi]      ; Загрузка очередного элемента в регистр AX
    sub cx, ax         ; Вычитание F291 из текущего значения
    mov [esi], ax      ; Сохранение результата обратно в память
    add esi, 2         ; Переход к следующему элементу в массиве
    cmp esi, OFFSET L  ; Проверка, достигли ли конца массива
    jne subtract_loop  ; Повторяем цикл для остальных элементов
    mov L, cx        ; Сохраняем результат в L
    xor cx, cx

    ; Вычисление M
    mov ax, X
    and ax, Y
    mov bx, L
    shr bx, 1
    add ax, bx
    ;Альтернативная ветвь
    sub ax, 07D0h
    xor bx, bx

    
    
    ; Проверка условия M < 99F
    cmp ax, 099Fh
    jb label1   ; Если M < 99F, переходим к п/п 1

    ; Если M >= 99F, переходим к п/п 2
label2:
    call point2

label1:
    ; Перестановка старших и младших байтов M
    call point1

check_even_count:
    ; Подсчет количества единиц в младшем байте R
    mov bx, ax
    and bx, 00FFh      ; Оставляем только младший байт
    xor cx, cx         ; Счетчик единиц
count_bits_loop:
    test bx, 1         ; Проверяем младший бит
    jz bit_is_zero     ; Если бит равен 0, пропускаем инкремент счетчика
    inc cx             ; Инкремент счетчика
bit_is_zero:
    shr bx, 1          ; Сдвигаем регистр вправо
    jnz count_bits_loop ; Повторяем цикл, пока регистр не станет нулевым

    ; Проверка четности счетчика единиц
    test cx, 1
    jz adr1     ; Если четное количество единиц, переходим к АДР1

    ; Иначе, переходим к АДР2
    xor ax, 0F0Fh
    jmp finish

adr1:
    and ax, 0F0F0h

finish:
    mov R, ax
    
    INVOKE ExitProcess, R
END Start