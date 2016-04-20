assume cs:code
code segment
	start:
	mov bx,0b800h
	mov es,bx
	mov di,160*12+2*30
	push di
	mov al,10
	
rdate:
    dec al
    cmp al,7
    jb rtime
    call show
    add di,6
    jmp short rdate
    
rtime:
    sub al,2
    cmp al,0feh
    je sign
    call show
    add di,6
    jmp short rtime
    
sign:
    pop di
    add di,4
    mov byte ptr es:[di],'/'
    add di,6
    mov byte ptr es:[di],'/'
    add di,12
    mov byte ptr es:[di],':'
    add di,6
    mov byte ptr es:[di],':'
    
    in al,60h
    cmp al,10h
    je quit
    jmp start
    
quit:
    mov ax,4c00h
    int 21h
    
show:
    push ax
    push cx
    out 70h,al
    in al,71h
    mov ah,al
    mov cl,4
    shr ah,cl
    add cl,00001111b
    add ah,30h
    add al,30h
    mov byte ptr es:[di],ah
    mov byte ptr es:[di+2],al
    pop cx
    pop ax
    ret
code ends
    end start

