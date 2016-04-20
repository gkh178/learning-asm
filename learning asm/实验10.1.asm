data segment
	db 'Welcome to masm!',0
data ends
assume cs:code,ds:data
code segment
	start:
	mov ax,data
	mov ds,ax        ;ds中存放data段
	mov dh,8         ;第八行
	mov dl,3         ;第三列
	mov cl,0cah      ;颜色属性为0cah
	
	call show_ptr
	mov ax,4c00h
	int 21h
	
show_ptr:
    mov al,0a0h
    dec dh
    mul dh
    mov bx,ax        ;第八行的偏移地址
    mov al,2
    mul dl
    sub ax,2
    add bx,ax        ;第八行第三列的偏移地址存放在bx中
    
    mov ax,0b800h
    mov es,ax        ;es关联显存的段地址
    
    mov si,0
    mov di,0
    mov al,cl        ;颜色属性转移给al
s:  
    mov cl,ds:[si]
    mov ch,0
    jcxz ok
    mov es:[bx+di],cl
    mov es:[bx+di+1],al 
    inc si
    add di,2
    jmp short s
    
ok: 
    ret
    
code ends
    end start
end
