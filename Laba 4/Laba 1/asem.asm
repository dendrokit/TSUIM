.586
.model flat, c
.data
	tmp real4 0.0
	adr dword 0
	counter byte 0

.code
	extern Func:near

	public Array
	Array proc
	push ebp
	mov ebp, esp

	mov adr, eax
	loop1:
	movzx ecx, counter
	push ecx
	call Func
	add esp, 4
	fstp tmp
	mov ebx, tmp
	mov eax, adr
	movzx ecx, counter
	mov [eax+ecx*4], ebx
	inc counter
	cmp counter, 10
	jbe loop1

	mov esp, ebp
	pop ebp
	ret
	Array endp

end
