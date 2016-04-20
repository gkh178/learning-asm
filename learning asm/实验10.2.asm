;解决1000000/10除法溢出，将dx为商的高16位，ax为商的低16位，cx为余数
assume cs:code,ss:stack
stack segment
	dw 8 dup(0)
stack ends
code segment
	start:
	mov ax,stack
	mov ss,ax
	mov sp,10h      ;设置栈顶
	mov ax,4240h    ;被除数的低16位
	mov dx,000fh    ;被除数的高16位
	mov cx,000ah    ;除数10设置为16位
	
	call divdw
	mov ax,4c00h
	int 21h
	
divdw:
    push ax         ;将被除数的低16位压栈
    mov ax,dx
    mov dx,0        ;dx:ax此时为被除数的高16位，作为一个32位被除数
    div cx          ;ax存储高16位的商，dx位高16位的余数
    mov bx,ax       ;bx暂存高16位的商
    pop ax          ;被除数低16位出栈,dx:ax表示rem(H/N)+L
    div cx          ;ax位商的低16位,dx为余数
    mov cx,dx       ;cx为总结果的余数
    mov dx,bx       ;dx为总结果的商的高16位,ax为总结果商的低16位
    ;32位被除数/16位除数=被除数的高16位(当作32位)/16位除数  为商的高16位
    ;+[被除数的高16位/16为除数的商(dx):被除数低16位(ax)]/16位除数  结果余数为整个运算的余数，商为整个商的低16位
ret
code ends
    end start
end
    
