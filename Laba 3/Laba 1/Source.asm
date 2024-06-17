.model flat, stdcall
.stack 100h

.data
    array_times dd 1, 1 
    array DWORD 70 dup(?) 
    R DWORD ? 

.code
ExitProcess PROTO STDCALL : DWORD
Start:
    
    finit

    
    fild dword ptr[array_times]
    fistp dword ptr[array+4]
    fild dword ptr[array_times+4]
    fistp dword ptr[array + 8]
    mov ecx, 2 

fill_array:
    mov eax, ecx
    sub eax, 1
    imul eax, eax, 4 
    fild dword ptr[array + eax]  
    mov eax, ecx
    imul eax, eax, 4  
    fild dword ptr[array + eax]  

    fadd

    mov eax, ecx
    inc eax
    imul eax, eax, 4 
    fistp dword ptr[array + eax] 

    mov ebx, ecx
    xor edx, edx  
    mov ebx, 3
    div ebx       
    cmp edx, 0    
    jne continue_loop 
    inc ecx
    fild dword ptr[array + ecx*4]
    fchs              
    fistp dword ptr[array + ecx*4]
    dec ecx
continue_loop:

    inc ecx 
    cmp ecx, 70
    jl fill_array 

mov eax, DWORD PTR [array + 280] 
mov R, eax
jmp end_program

end_program:
    INVOKE ExitProcess, R
END Start