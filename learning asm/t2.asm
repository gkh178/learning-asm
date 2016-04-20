;计算ffff:0-ffff:b内存单元中的和，将结果放在dx中
assume cs:sum       ;cs:ip指向sum代码段
sum segment         ;定义代码段sum
	mov ax,0ffffh     
	mov ds,ax
	mov bx,0        ;初始化ds:[]
	
	mov dx,0        ;初始化累加寄存器dx
	
	mov cx,12       ;设置循环次数
s:	mov al,[bx]
	mov ah,0        ;将内存单元[bx]处的指赋给ax
	add dx,ax       ;设置计算循环体
	inc bx          ;指向下一个内存单元
	loop s
	
	mov ax,4c00h
	int 21h         ;程序返回
sum ends            ;定义代码段sum
end                 ;程序结束
