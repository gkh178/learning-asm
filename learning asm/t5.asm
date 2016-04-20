;向内存0:200-0:23F(20:0-20:3F)中依次传送数据0-63
assume cs:write
write segment
	mov ax,20h
	mov ds,ax      ;将内存20:0的段地址赋给ds
	mov dl,0       ;初始化要传送的数据
	mov bx,0       ;初始化循环变量
	
	mov cx,64      ;循环次数64次
s:
    mov [bx],dl	   ;写入数据
    inc bx
    inc dl
    loop s
    
    mov ax,4c00h
    int 21h
write ends
end
