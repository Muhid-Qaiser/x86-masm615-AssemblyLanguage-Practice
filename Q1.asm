.model small
.stack 100h
.data
      
 size1 dw 3
 strings db 'Ali$', 'Usman$', 'Abdullah$'  
 ;strings db 'ALI$', 'ALA$', 'BLI$'
 element1 db 4 dup(0)
 element2 db 6 dup(0)
 element3 db 9 dup(0)
 cost1 dw 0
 cost2 dw 0
 cost3 dw 0
 count dw 0   
     
 org_prompt db "Original List : $"
 rev_prompt db "Reversed List : $"        
            

.code

; Start

main proc
    mov ax, @data
    mov ds, ax
           
    ; Display
    mov dx, offset org_prompt
    mov ah, 9
    int 21h
    mov si, offset strings
    call display_list
    
    ; Code
       
    mov ax, 0
    mov dx, 0
    mov bx, 0
    mov cx, 1 
    
    mov si, offset strings
    mov di, offset element1            
    
    loop1:
        cmp BYTE PTR [si], 24h	; If letter is not $
        je loop1_end
        
        mov ah, 0  
        
        mov al, BYTE PTR [si]	; get letter
        mov BYTE PTR [di], al	; store letter in element1
        mul cx
        
        
        add cost1, ax  	; calculate cost by adding ASCI
        inc si
        inc cx
        inc di
        
        jmp loop1    
        
        
    loop1_end:
    
    mov BYTE PTR [di], '$'
    inc si
    mov cx, 1
    mov di, offset element2 
    
    loop2:
        cmp BYTE PTR [si], 24h ; if letter is not $
        je loop2_end  
        
        mov ah, 0
        
        mov al, BYTE PTR [si]	; get letter
        mov BYTE PTR [di], al	; store letter in element2
        mul cx
        
        add cost2, ax	; calculate cost by adding ASCI
        inc si
        inc cx
        inc di      
              
        jmp loop2 
          
    
    loop2_end:
    
    mov BYTE PTR [di], '$' 
    inc si
    mov cx, 1
    mov di, offset element3	; get address of di
    
    loop3:
        cmp BYTE PTR [si], 24h	; check if letter is not $
        je loop3_end 
        
        mov ah, 0 
        
        mov al, BYTE PTR [si]	; get letter
        mov BYTE PTR [di], al	; store letter in element3
        mul cx
        
        add cost3, ax 	; calculate cost by adding ASCI
        inc si
        inc cx
        inc di
        
        jmp loop3 
          
    
    loop3_end:
    
    mov BYTE PTR [di], '$'
    mov si, offset strings
    mov bx, cost2
    cmp cost1, bx	; compare cost of element1 and element2
    
    ja l1	; if element1 cost more
    jmp l2	; if element2 cost more
    
    
    l1:  
        mov bx, cost3
        cmp cost1, bx
        ja l3
        jmp l4
        
        
    l2: 
        mov bx, cost3
        cmp cost2, bx
        ja l5
        jmp l4 
            
        
        
    l3:
        ; cost1 biggest 
        mov di, offset element1
        
        loop4:
            
            cmp BYTE PTR [di], 24h
            je loop4_end
                      
            mov dx, [di]
            mov [si], dx
            
            inc si
            inc di
            
            jmp loop4
            
            
        loop4_end:
        
        mov bx, cost3    
        cmp cost2, bx
        ja l6
        jmp l7
            
    l6: 
        inc si 
        mov di, offset element2
        
        loop5:
            
            cmp BYTE PTR [di], 24h
            je loop5_end
                      
            mov dx, [di]
            mov [si], dx
            
            inc si
            inc di
            
            jmp loop5
            
            
        loop5_end:
        
        inc si 
        mov di, offset element3
        
        loop6:
            
            cmp BYTE PTR [di], 24h
            je loop6_end
                      
            mov dx, [di]
            mov [si], dx
            
            inc si
            inc di
            
            jmp loop6    
 
            
            
        loop6_end:
            jmp display
        
        
    l7:
        inc si
        mov di, offset element3
        
        loop7:
            
            cmp BYTE PTR [di], 24h
            je loop7_end
                      
            mov dx, [di]
            mov [si], dx
            
            inc si
            inc di
            
            jmp loop7
            
            
        loop7_end: 
        
        inc si
        mov di, offset element2
        
        
        loop8:
            
            cmp BYTE PTR [di], 24h
            je loop8_end
                      
            mov dx, [di]
            mov [si], dx
            
            inc si
            inc di
            
            jmp loop8
            
            
        loop8_end:
 
            jmp display 
            
            
            
    l4:
        ; cost3 biggest 
        mov di, offset element3
        
        loop9:
            
            cmp BYTE PTR [di], 24h
            je loop9_end
                      
            mov dx, [di]
            mov [si], dx
            
            inc si
            inc di
            
            jmp loop9
            
            
        loop9_end:
        
        mov bx, cost2    
        cmp cost1, bx
        ja l8
        jmp l9
 
    
    l8:
        inc si
        mov di, offset element1
        
        loop10:
            
            cmp BYTE PTR [di], 24h
            je loop10_end
                      
            mov dx, [di]
            mov [si], dx
            
            inc si
            inc di
            
            jmp loop10
            
            
        loop10_end: 
        
        inc si
        mov di, offset element2
        
        
        loop11:
            
            cmp BYTE PTR [di], 24h
            je loop11_end
                      
            mov dx, [di]
            mov [si], dx
            
            inc si
            inc di
            
            jmp loop11
            
            
        loop11_end:
 
            jmp display
            
 
    l9:
        inc si
        mov di, offset element2
        
        loop12:
            
            cmp BYTE PTR [di], 24h
            je loop12_end
                      
            mov dx, [di]
            mov [si], dx
            
            inc si
            inc di
            
            jmp loop12
            
            
        loop12_end: 
        
        inc si
        mov di, offset element1
        
        
        loop13:
            
            cmp BYTE PTR [di], 24h
            je loop13_end
                      
            mov dx, [di]
            mov [si], dx
            
            inc si
            inc di
            
            jmp loop13
            
            
        loop13_end:
 
            jmp display
    
    
    

    l5:
        ; cost2 biggest
        mov di, offset element2
        
        loop14:
            
            cmp BYTE PTR [di], 24h
            je loop14_end
                      
            mov dx, [di]
            mov [si], dx
            
            inc si
            inc di
            
            jmp loop14
            
            
        loop14_end:
        
        mov bx, cost3    
        cmp cost1, bx
        ja l10
        jmp l11
        
        
    l10:
        inc si
        mov di, offset element1
        
        loop15:
            
            cmp BYTE PTR [di], 24h
            je loop15_end
                      
            mov dx, [di]
            mov [si], dx
            
            inc si
            inc di
            
            jmp loop15
            
            
        loop15_end: 
        
        inc si
        mov di, offset element3
        
        
        loop16:
            
            cmp BYTE PTR [di], 24h
            je loop16_end
                      
            mov dx, [di]
            mov [si], dx
            
            inc si
            inc di
            
            jmp loop16
            
            
        loop16_end:
 
            jmp display
            
 
    l11:
        inc si
        mov di, offset element3
        
        loop17:
            
            cmp BYTE PTR [di], 24h
            je loop17_end
                     
            mov dx, [di]
            mov [si], dx
            
            inc si
            inc di
            
            jmp loop17
            
            
        loop17_end: 
        
        inc si
        mov di, offset element1
        
        
        loop18:
            
            cmp BYTE PTR [di], 24h
            je loop18_end
                      
            mov dx, [di]
            mov [si], dx
            
            inc si
            inc di
            
            jmp loop18
            
            
        loop18_end:
 
            jmp display
            
 
    ; Display
    
    display: 
    
    call endl
    
    mov dx, offset rev_prompt
    mov ah, 9
    int 21h
    
    mov si, offset strings
    
    call display_list
 
        
        
    
                 
exit:                 
    mov ah, 4ch
    int 21h  
        
main endp

; Funtions

    
display_list proc 
    
    push ax
    push bx
    push cx
    push dx
    
    mov cx, 0
    
    loop19:
        cmp cx, size1
        jae end_loop19
        
        mov dl, BYTE PTR [si]
        
        cmp dl, 24h
        jne continue
               
        mov dl, ' '
        mov ah, 2
        int 21h               
        inc si       
        inc cx
        jmp loop19       
        
        continue:
        
        mov ah, 2
        int 21h   
        inc si
        jmp loop19
        
    end_loop19:
    
    
    pop ax
    pop bx
    pop cx
    pop dx

    ret
display_list endp

 	
endl proc
    
    push ax
    push dx
    
    ; Endl
    MOV dl, 10 
    MOV ah, 02h
    INT 21h
    MOV dl, 13
    MOV ah, 02h
    INT 21h           
              
    pop dx
    pop ax
        
    ret
endl endp

end main
