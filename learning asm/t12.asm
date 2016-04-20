assume cs:code
code segment
	dw 1,2,3,4,5,6,7,8	
	dw 0,0,0,0,0,0,0,0
	start:
	mov ax,cs
	mov ds,ax     ;将寄存器ds与段a关联
	mov ax,cs
	mov ss,ax     ;将寄存器ss与段b关联
	mov sp,32h
	
	mov bx,0
	mov cx,8
	s:
	push [bx]
	add bx,2
	loop s
	
	mov ax,4c00h
	int 21h
code ends
    end start
end
