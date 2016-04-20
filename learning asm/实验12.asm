assume cs:code
code segment
	start:
	mov ax,cs
	mov ds,ax
	mov si,offset do0
	mov ax,0
	mov es,ax
	mov di,0200h
	mov cx,offset do0end-offset do0
	cld
	rep movsb
	
	mov ax,0
	mov es,ax
	mov word ptr es:[0],200h
	mov word ptr es:[2],0
	
	mov ax,0f000h
	mov dx,22d
	mov cx,10d
	div cx                           ;此4句是为了做个溢出的除法
	mov ax,4c00h
	int 21h
	
do0:
    jmp short do0start
    db "overflow!"
do0start:
    mov ax,cs
    mov ds,ax
    mov si,0202h
    mov ax,0b800h
    mov es,ax
    mov di,12*160+36*2
    mov cx,9
s:  
    mov al,[si]
    mov es:[di],al
    inc si
    add di,2
    loop s
    mov ax,4c00h
    int 21h
do0end:
    nop
    
code ends
    end start
	
