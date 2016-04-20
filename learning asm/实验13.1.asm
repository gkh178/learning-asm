assume cs:code
data segment
	db "Welcome to masm!",0
data ends
code segment
	start:
	mov ax,cs
	mov ds,ax
	mov si,offset no7c
	mov ax,0
	mov es,ax
	mov di,200h
	mov cx,offset no7cend-offset no7c
	cld
	rep movsb                             ;7ch中断处理程序代码安装到0:200h
	
	mov es:[7ch*4],200h
	mov es:[7ch*4+2],0                    ;设置7ch中断的中断向量表，表项中存入中断处理程序的CS,IP
	
	mov dh,10
	mov dl,10
	mov cl,2
	mov ax,data
	mov ds,ax
	mov si,0
	int 7ch
	
	mov ax,4c00h
	int 21h                        
	
no7c:
    push ax       ;定义中断例程[开始]
    push bx
    push di
    mov bx,0b800h
    mov es,bx
    mov al,160d
    mul dh
    mov di,ax
    mov al,2        ;此6句为确定符合题意的显存的偏移地址，
    mul dl          ;不可用"mov di,160*dh+2*dl"试图达到此6句指令的功能。
    add di,ax
    
    mov bl,cl
again: 
     mov cx,[si]
     jcxz no7cret
     mov es:[di],cl
     mov es:[di+1],bl
     inc si
     add di,2
     jmp short again
no7cret:        
     pop di
     pop bx
     pop ax
     iret
no7cend:       
     nop       
code ends
     end start
