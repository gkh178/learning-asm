assume cs:code,ss:stack
stack segment
	db 128 dup(0)
stack ends
code segment
	main:
    mov ax,stack
    mov ss,ax
    mov sp,128                   ;ss指向stack段
    
    mov ax,0
    mov es,ax                    ;es指向0:[]处
    push es:[9*4]
    pop es:[200h]
    push es:[9*4+2]
    pop es:[202h]                ;将原BIOS提供的int9中断例程的入口点存入0:[200h]处
;***************************新int9中断例程安装与中断向量表的指向**********************************   
    push cs
    pop ds                       ;ds指向code段
    mov si,offset int9
    mov di,204h
    mov cx,offset int9end-offset int9
    cld
    rep movsb
    
    mov word ptr es:[9*4],204h
    mov word ptr es:[9*4+2],0    ;9号中断向量表项中存入的新int9中断例程的程序入口点
;*************************************************************************************************

    
    mov ax,0
    mov es,ax
    push es:[200h]
    pop es:[9*4]
    push es:[202h]
    pop es:[9*4+2]               ;BIOS提供的原int9中断例程的程序入口点恢复到9号中断向量表项中
    
    mov ax,4c00h
    int 21h   

    ;新的int9中断例程
int9: 
    push ax
    push bx
    push es
    
    in al,60h                    ;从端口60h读取扫描码至al中
    pushf                        ;Flag入栈
    pushf
    pop bx
    and bh,11111100b
    push bx
    popf                         ;设置IF=0,TF=0
    mov ax,0
    mov es,ax
    call dword ptr es:[200h]     ;push CS,push IP,(IP)=(200H),(CS)=(0),调用原int9中断例程
    
x1: 
    cmp al,1                     ;与ESC通码比较
    jne int9ret
    push ax
    mov ax,0b800h
    mov es,ax
    mov bx,1
    mov cx,2000
s1: 
    inc byte ptr es:[bx]
    add bx,2
    loop s1
    pop ax
    jmp x2
    
x2:   
    cmp al,9eh                    ;与'A'断码进行比较
    jne int9ret
    mov ax,0b800h
    mov es,ax
    mov bx,0
    mov cx,2000
s2: 
    mov byte ptr es:[bx],'A'
    add bx,2
    loop s2
    
int9ret:
    pop es
    pop bx
    pop ax
    iret
int9end:
    nop

code ends
    end main
