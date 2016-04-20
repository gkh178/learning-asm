;将a段与b段中的数据依次相加，结果存入c段中
a segment
	db 1,2,3,4,5,6,7,8        ;定义一个段a,功能相当与数据段,把ds作为它的段寄存器
a ends
b segment
	db 1,2,3,4,5,6,7,8        ;定义一个段b,功能相当于数据段,把es作为它的段寄存器
b ends
c segment
	db 0,0,0,0,0,0,0,0        ;定义一个段c,功能相当于数据段,把ss作为它的段寄存器，
c ends
assume cs:code ;cs段寄存器关联code段
code segment
	mov ax,a
	mov ds,ax   ;定义段a的段寄存器初始地址
	
	mov ax,b
	mov es,ax   ;定义段b的段寄存器初始地址
	
	mov ax,c
	mov ss,ax   ;定义段c的段寄存器初始地址
	
	mov al,0    ;定义相加后用来存结果的寄存器
	mov bx,0    ;初始化各数据段的内存偏移地址
	mov cx,8    ;循环次数
s:
    mov al,[bx] ;将a:[bx]中的数据送入al中
    add es:[bx],al;将a:[bx]+b:[bx]的结果送入b:[bx]中
    mov al,es:[bx];将b:[bx]中的结果送入al中
    mov ss:[bx],al;将al中的结果赋给c:[bx]中
    inc bx        ;bx=bx+1
    loop s
    
    mov ax,4c00h
    int 21h
code ends
end


