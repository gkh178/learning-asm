assume cs:code

code segment

start:

        mov ax,cs

        mov ds,ax

        mov si,offset lp

        mov ax,0

        mov es,ax

        mov di,200h

        mov cx,offset lpend-offset lp

        cld

        rep movsb

        ;以上9句为安装中断例程



        mov word ptr es:[7ch*4],200h

        mov word ptr es:[7ch*4+2],0

        ;以上2句为设置中断向量



        mov ax,0b800h

        mov es,ax

        mov di,160*12                ;取得显存第12行第0列的偏移地址

        mov bx,offset s-offset se

        mov cx,80

s:      mov byte ptr es:[di],'!'

        add di,2

        int 7ch

se:     nop

        mov ax,4c00h

        int 21h

 

lp:     ;中断例程定义[开始]

        push bp

        mov bp,sp

        dec cx

        jcxz lpret

        add [bp+2],bx

lpret:        pop bp

              iret       ;中断的返回指令

lpend:        nop        ;中断例程定义[结束]

 

code ends

end start


