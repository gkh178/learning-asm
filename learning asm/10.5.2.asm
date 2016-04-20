assume cs:code
data segment
	dw 8 dup (0)
data ends
code segment
	start:
	mov ax,data
	mov ss,ax
	mov sp,10h
	mov word ptr ss:[0],offset s
	mov ss:[2],cs
	call word ptr ss:[0]
	nop
s:
    mov ax,offset s
    sub ax,ss:[0ch]
    mov bx,cs
    sub bx,ss:[0eh]
    
    mov ax,4c00h
    int 21h
code ends
    end start
end
;½á¹ûax=1,bx=0
