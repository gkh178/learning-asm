;将字符串'ibm             '
;        'dec             '
;        'dos             '
;        'vax             '
;中的前3个字母改写为大写字母
assume cs:codesg,ds:datasg
datasg segment
	db 'ibm             '
	db 'dec             '
	db 'dos             '
	db 'vax             '
	dw 0                  ;定义一个字，用来暂存外层循环变量
datasg ends
codesg segment
	start:
	mov ax,datasg
	mov ds,ax
	mov bx,0
	
	mov cx,4              ;外层循环变量用cx寄存
s1: mov ds:[40h],cx       ;内存ds:[40h]暂存外层循环变量,不能用[40h]，编译器不识别[40h]
    
    mov cx,3              ;内层循环变量用cx寄存
    mov si,0
s2: mov al,[bx][si]
    and al,11011111b
    mov [bx][si],al
    inc si
    loop s2
    
    add bx,16
    mov cx,ds:[40h]             ;将外层循环变量的值返给cx
    loop s1
    
    mov ax,4c00h           
    int 21h
codesg ends
    end start
end

