;将字符串'1. display      '             
;        '2. brows        '
;        '3. replace      '
;        '4. modify       '
;中的前4个字母改写为大写字母
assume cs:code,ds:data,ss:stack
data segment
	db '1. display      '             
    db '2. brows        '
    db '3. replace      '
    db '4. modify       '
data ends
stack segment
	dw 0,0,0,0  
stack ends               ;定义一段栈，用来暂存外循环值cx
code segment
	start:
	mov ax,data
	mov ds,ax
	mov bx,0
	
	mov cx,4              ;外层循环变量用cx寄存
s1: push cx               ;外层循环变量入栈
    
    mov cx,4              ;内层循环变量用cx寄存
    mov si,3
s2: mov al,[bx][si]
    and al,11011111b
    mov [bx][si],al
    inc si
    loop s2
    
    add bx,16
    pop cx            ;将外层循环变量弹栈，返回原来的cx
    loop s1
    
    mov ax,4c00h           
    int 21h
code ends
    end start
end

