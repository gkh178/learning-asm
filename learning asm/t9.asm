;将8个0123h,0456h,0789h,0abch,0defh,0fedh,0cbah,0987h数据依次入栈，然后出栈到原来的内存地址,但是数据排列逆向
data segment
	dw 0123h,0456h,0789h,0abch,0defh,0fedh,0cbah,0987h   ;数据段
data ends	
stack segment
	dw 0,0,0,0,0,0,0,0                                   ;定义8字栈
stack ends
assume cs:code,ds:data,ss:stack                          ;说明cs段寄存器关联code,ds段寄存器关联data,ss寄存器关联stack
code segment                                 
	start:                                               ;程序指令入口点
	    mov ax,stack
	    mov ss,ax
	    mov sp,16                                        ;设置栈顶ss:sp=stack:16
	    mov ax,data
	    mov ds,ax                                        ;设置数据段ds的初始值
	    mov bx,0                                         ;初始化内存偏移地址
	    
	    mov cx,8                                         
s1:
        push [bx]                                        ;入栈
        add bx,2
        loop s1
        
        mov bx,0                                         ;重新初始化内存偏移地址                                   
        
        mov cx,8
s2:     
        pop [bx]                                         ;出栈
        add bx,2
        loop s2
        
        mov ax,4c00h
        int 21h                                          ;程序返回
code ends
    end start
end
	    
