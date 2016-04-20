;利用编程，实现在内存2000h段中寻找第一个值为0的字节，找到后，将它的偏移地址存储到dx中
assume cs:code
code segment
	start:
	mov ax,2000h
	mov ds,ax       ;将ds定位在内存2000h段处
	
	mov bx,0        ;初始化ds:[bx]为ds:[0]
s:  mov cl,[bx] 
    mov ch,0        ;将ds:[bx]中的字节存入cx中
    jcxz ok         ;如果(cx)=0,即(ds:[bx])=0,跳转到ok标号处
    inc bx          ;如果(cx)!=0,偏移地址dx+1
    jmp short s     ;如果(cx)!=0,跳转到标号s处，进行下一轮循环直到jcxz ok执行为止
    
ok: mov dx,bx       ;(cx)=(ds:[bx])=0时候的bx寄存的偏移地址赋给dx

    mov ax,4c00h
    int 21h
code ends
    end start
end
	
