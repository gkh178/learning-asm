;将8个数据0123h,0456h,0789h,0abch,0defh,0fedh,0cbah,0987h的和送入ax中
assume cs:code
code segment
	dw 0123h,0456h,0789h,0abch,0defh,0fedh,0cbah,0987h;定义8个字，放在CS:0中
	mov ax,0                                          ;初始化累加寄存器
	mov bx,0                                          ;初始化偏移地址
	
    mov cx,8                                          
s:  add ax,cs:[bx]                                    ;将cs:[bx]中的数据送入ax中
    add bx,2                                         
    loop s
    
    mov ax,4c00h
    int 21h
code ends
end
