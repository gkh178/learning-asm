data segment

        db 'Welcome to masm!',0

data ends

 

code segment

        assume cs:code,ds:data

start:

        mov dh,8              ;dh装行号(范围:1--25)

        mov dl,3             ;dl装列号(范围:1--80)[注:每超过80等于行号自动加1]

        mov cl,0cah           ;cl中存放颜色属性(0cah为红底高亮闪烁绿色属性)

        mov ax,data

        mov ds,ax

        mov si,0

 

        call show_str

        

        mov ax,4c00h

        int 21h

        

show_str:   ;显示字符串的子程序[定义开始]

        push cx

        push si

        mov al,0A0h

        dec dh          ;行号在显存中下标从0开始,所以减1

        mul dh

        mov bx,ax

        mov al,2

        mul dl

        sub ax,2       ;列号在显存中下标从0开始,又因为偶字节存放字符,所以减2

        add bx,ax      ;此时bx中存放的是行与列号的偏移地址

        mov ax,0B800h

        mov es,ax      ;es中存放的是显存的第0页(共0--7页)的起始的段地址

        mov di,0

        mov al,cl

        mov ch,0

s:      mov cl,ds:[si]

        jcxz ok

        mov es:[bx+di],cl       ;偶地址存放字符

        mov es:[bx+di+1],al     ;奇地址存放字符的颜色属性

        inc si

        add di,2

        jmp short s

ok:     pop si

        pop cx

        ret    ;显示字符串的子程序[定义结束]

 

code ends

end start

 

