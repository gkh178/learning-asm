;将内存ffff:0-ffff:b中的数据拷贝到0:200-0:20b(0020:0-0020:b)
assume cs:copy
copy segment              ;代码段初始
	mov bx,0              ;循环变量初始化0
	mov ax,0ffffh
	mov ds,ax             ;内存ffff:0段地址赋给ds
	mov ax,20h
	mov es,ax             ;内存0020:0段地址赋给es
	
	mov cx,12        
s:  mov dl,[bx]
    mov es:[bx],dl        ;实现数据拷贝
    inc bx  
    loop s
    
    mov ax,4c00h
    int 21h
copy ends
end              
             
	 
