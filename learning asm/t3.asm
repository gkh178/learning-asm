assume cs:code
code segment;定义代码段
	mov ax,0ffffh
	mov ds,ax
	mov bx,6
	mov al,[bx];ax低位赋值
	mov ah,0;ax高位清零
	mov dx,0;累加寄存器dx清零
	mov cx,100;设置循环次数
s:  add dx,ax;循环体
    loop s
    
    mov ax,4c00h
    int 21c;程序返回
code ends;定义代码段
end

