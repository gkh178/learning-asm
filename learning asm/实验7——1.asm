assume cs:code,ds:data,es:table
data segment
	db '1975','1976','1977','1978','1979','1980','1981','1982','1983'
    db '1984','1985','1986','1987','1988','1989','1990','1991','1992'
    db '1993','1994','1995'
    ;以上是表示21年的21个字符串
    dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
    dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000
    ;以上是表示21年公司总收的21个dword型数据
    dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
    dw 11542,14430,45257,17800
    ;以上是表示21年公司雇员人数的21个word型数据
data ends
table segment
	db 21 dup('year summ ne ?? ')
table ends
code segment
    start:
	mov ax,data
	mov ds,ax    ;段寄存器ds关联data段
	mov ax,table
	mov es,ax    ;段寄存器es关联table段
	mov bx,0     ;data段中循环时需要加4进行循环
	mov bp,0     ;table段中循环时需要加16进行循环
	mov di,0     ;data段中循环时需要加2进行循环
	
	mov cx,21
s:  
    mov al,[bx]
    mov es:[bp],al
    mov al,[bx+1]
    mov es:[bp+1],al
    mov al,[bx+2]
    mov es:[bp+2],al
    mov al,[bx+3]
    mov es:[bp+3],al  ;table段中年份输出
    
    mov ax,[bx+54h]
    mov dx,[bx+56h]   ;将data段中的收入提取作为被除数
    mov es:[bp+5h],ax
    mov es:[bp+7h],dx ;将data段中的收入写入table段中对应的位置
    
    mov ax,[di+0a8h]  
    mov es:[bp+0ah],ax;将data段中的雇员数写入table段中对应的位置
    
    mov ax,[bx+54h]
    div word ptr ds:[di+0a8h]
    mov es:[bp+0dh],ax;将人均收入写入table段中对应的位置
    
    add bx,4
    add di,2
    add bp,16
loop s

mov ax,4c00h
int 21h

code ends
    end start
end
	

 

