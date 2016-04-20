assume cs:code
code segment
	start:
	mov ax,2000h
	mov ds,ax         ;将内存2000h处的段地址定位到ds中
	
	mov bx,0          ;初始化ds:[bx]为ds:[0]
s:  mov cl,[bx]
    mov ch,0          ;将内存ds:[bx]中的字节送入cx寄存器中
    inc cx            ;(cx)=(cx)+1
    inc bx            ;设置下一轮循环
    loop s            ;(cx)=(cx)-1,将cx中寄存的内存ds:[bx]中的字节返回给cx，如果(cx)!=0,跳转到s,如果cx=0,向下执行
    
ok: dec bx            ;(bx)=(bx)-1,将bx中的值减去一，因为S标号中有inc bx,改动了bx的值
    mov dx,bx         
    
    mov ax,4c00h
    int 21h
code ends
    end start
end
