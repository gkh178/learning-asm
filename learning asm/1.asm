assume cs:codesg

codesg segment
   start:
    MOV ax,0123H
    MOV bx,0456H
    ADD ax,ax
    add ax,bx
    
    mov ax,4c00H
    int 21H
    
codesg ends

    end
