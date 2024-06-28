.model small
.stack 100h

.data
    input_num dw ?

    prompt    db "Enter the size [0-9]: $"
    sterik db "Sterik Pattern: $"
    num_p db "Number Pattern: $"

.code
main proc
	mov  ax, @data
	mov  ds, ax
	
	; Start code

	mov  ah, 09h
	mov  dx, offset prompt ; print prompt
	int  21h

	mov  ah, 01h
	int  21h

	sub  al, '0'	;	subtract to get correct value
	mov  ah, 0

	mov  input_num, ax
	mov cx, 0

	call endl
	call endl
	
	mov dx, offset sterik	; print *
	mov ah, 9
	int 21h
	
	call endl 
	

	; Asterisk Pattern
	
	upper_outer_loop1:  ; prints upper half of the pyramid
	    cmp cx, input_num
	    jae end_upper_outer_loop1
	    
	    mov bx, 0
	    
	    inner_loop1:	; print space for each line
	        mov ax, input_num
	        sub ax, cx
	        sub ax, 1 
	        
	        cmp bx, ax
	        jae end_inner_loop1
	        
	        mov dl, ' '
	        mov ah, 2
	        int 21h
	        
	        inc bx
	        jmp inner_loop1
        
        end_inner_loop1:
            
            mov bx, 0
     
        inner_loop2:	; print * for each line
            mov ax, cx
            mov dx, 2
            mul dx
            mov dx, 0
            inc ax   
            
            cmp bx, ax
            jae end_inner_loop2
            
            mov dl, '*'
            mov ah, 2
            int 21h
            
            inc bx
            jmp inner_loop2
            
            
        
        end_inner_loop2:
        
            inc cx         
            call endl
            jmp upper_outer_loop1 
                 
    end_upper_outer_loop1:
        mov cx, input_num
        sub cx, 2    
    
    
    
    lower_outer_loop1:	; prints lower half of the pyramid
        cmp cx, 0
        jl end_lower_outer_loop1
        
        mov bx, 0
        
        inner_loop3:	; prints space for each line
            mov ax, input_num
            sub ax, cx
            sub ax, 1
            
            cmp bx, ax
            jae end_inner_loop3
            
            mov dl, ' '
            mov ah, 2
            int 21h
            
            inc bx
            jmp inner_loop3
            
            
        end_inner_loop3:
            mov bx, 0            
        
        inner_loop4:  ; prints * for each line
            mov ax, cx
            mov dx, 2
            mul dx
            inc ax
                      
            cmp ax, bx
            jle end_inner_loop4
            
            mov dl, '*'
            mov ah, 2
            int 21h
            
            inc bx
            jmp inner_loop4
            
        
        end_inner_loop4:
        
        dec cx       
        call endl
        jmp lower_outer_loop1
    
    
    end_lower_outer_loop1:    
		
	call endl 
	;call endl
	
	mov dx, offset num_p
	mov ah, 9
	int 21h
	
	call endl 
	
	; Numbers Pattern
	    
	mov cx, 1                 
	                  
	upper_outer_loop2:	; prints upper half of the numbers pyramid
	    cmp cx, input_num
	    ja end_upper_outer_loop2
	    
	    mov bx, 0 
	    
	    inner_loop5:	; prints space for each line
	        mov ax, input_num
	        sub ax, cx
	        
	        cmp ax, bx
	        jle end_inner_loop5
	        
	        mov dl, ' '
	        mov ah, 2
	        int 21h
	        
	        inc bx
	        jmp inner_loop5
	        
	        
	    end_inner_loop5:
	        mov bx, cx
	        
	        inner_loop6:	; prints number for each line
	            cmp bx, 1
	            jl end_inner_loop6
	            
	            mov dl, bl
	            add dl, 30h
	            mov ah, 2
	            int 21h
	            
	            dec bx
	            jmp inner_loop6
	                           
	    end_inner_loop6:
	        mov bx, 2
	
	    inner_loop7:
	        cmp bx, cx
	        jg end_inner_loop7
	        
	        mov dl, bl
	        add dl, 30h
	        mov ah, 2
	        int 21h
	        
	        inc bx 
	        jmp inner_loop7
	    
	    end_inner_loop7:
	    
	    
	    
	    inc cx
	    call endl
	    jmp upper_outer_loop2
		
    end_upper_outer_loop2:
        
        mov cx, input_num
        dec cx
        
        
        
    lower_outer_loop2:	; prints lower half of the number pyramid
        
        cmp cx, 0
        je end_lower_outer_loop2
        
        mov bx, 0
        
        inner_loop8:	; prints space for each line
        
            mov ax, input_num
            sub ax, cx
            
            
            cmp ax, bx
            jle end_inner_loop8
            
            mov dl, ' '
            mov ah, 2
            int 21h
            
            inc bx
            jmp inner_loop8
            
        
            
        end_inner_loop8: 
        
            mov bx, cx
        
        inner_loop9:	; prints Number for each line
            
            cmp bx, 0
            jle end_inner_loop9
            
            mov dl, bl
            add dl, 30h
            mov ah, 2
            int 21h
            
            dec  bx
            jmp inner_loop9               
        
               
        end_inner_loop9: 
            mov bx, 2
            
        inner_loop10:
            cmp bx, cx
            ja end_inner_loop10
            
            mov dl, bl
            add dl, 30h
            mov ah, 2
            int 21h
            
            inc bx
            jmp inner_loop10           
            
        end_inner_loop10:
        
        
        
        dec cx               
        call endl
        jmp lower_outer_loop2
    	
	       
	end_lower_outer_loop2:
   

 

    exit:   
                   mov  ah, 4ch
                   int  21h
main endp

endl PROC
                   push ax
                   push dx
                    
                   ; Endl
                   mov  dl, 10
                   mov  ah, 02h
                   int  21h
                   mov  dl, 13
                   mov  ah, 02h
                   int  21h

                   pop  dx
                   pop  ax
    
                   ret
endl ENDP
end main
