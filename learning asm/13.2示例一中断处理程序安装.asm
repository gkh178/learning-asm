assume cs:code 
code segment
	start:
	mov ax,cs
	mov ds,ax
	mov si,offset sqr
	mov ax,0
	mov es,ax
	mov di,200h
	mov cx,offset sqrend-offset sqr
	cld
	rep movsb                         ;安装中断处理程序到0:200h处
	
	mov ax,0
	mov es,ax
	mov word ptr es:[7ch*4],200h
	mov word ptr es:[7ch*4+2],0       ;设置中断向量表中的表项指向内存0:200h处
	
sqr:
    mul ax
    iret
sqrend:
    nop
code ends
    end start
