assume cs:codesg
codesg segment     ;定义代码段
	mov ax,2000H 
	mov ss,ax
	mov sp,0       ;定义栈顶元素
	add sp,4
	pop ax
	pop bx
	push ax
	push bx
	pop ax
	pop bx
	mov ax,4c00H
	int 21H        ;程序返回，将控制权还回COMMAND
codesg ends        ;定义代码段
end                ;程序结束
	
