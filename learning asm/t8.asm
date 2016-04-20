;将8个0123h,0456h,0789h,0abch,0defh,0fedh,0cbah,0987h数据依次入栈，然后出栈到原来的内存地址,但是数据排列逆向
assume cs:code
code segment
	dw 0123h,0456h,0789h,0abch,0defh,0fedh,0cbah,0987h   ;定义8个字放入cs:0-15
	dw 0,0,0,0,0,0,0,0                                   ;定义8个字的空间作栈,栈地址为cs:16-31
	start:                                               ;程序指令入口点
	    mov ax,cs
	    mov ss,ax
	    mov sp,32                                        ;设置栈顶ss:sp=cs:32
	    mov bx,0                                         ;初始化内存偏移地址
	    
	    mov cx,8                                         
s1:
        push cs:[bx]                                     ;入栈
        add bx,2
        loop s1
        
        mov bx,0                                         ;重新初始化内存偏移地址                                   
        
        mov cx,8
s2:     
        pop cs:[bx]                                      ;出栈
        add bx,2
        loop s2
        
        mov ax,4c00h
        int 21h                                          ;程序返回
code ends
    end start
end
	    
