assume cs:code,ds:data,ss:stack
data segment
	db 'welcome to masm!'  ;定义要显示的字符串(共16字节)
	db 02h,24h,71h    ;定义三种颜色属性
data ends
stack segment
	dw 8 dup(0)
stack ends
code segment
	start:
	mov ax,data
	mov ds,ax
	mov ax,stack
	mov ss,ax
	mov sp,10h
	mov dx,0b872h  ;设置第十二行中间起始位置
	mov si,0       ;data段中内循环
	mov di,0       ;显存内存区循环
	mov bx,10h     ;data段中字符的属性选择

    mov cx,3
s:  
    push cx
    push si
    push di
    mov es,dx
    
    mov cx,10h
s1:
    mov al,ds:[si]
    mov es:[di],al
    inc si
    add di,2
    loop s1
    
    mov al,ds:[bx]
    mov di,1
s2:
    mov es:[di],al
    add di,2
    loop s2
    
    inc bx
    add dx,0ah
    pop di
    pop si
    pop cx
    loop s
    


