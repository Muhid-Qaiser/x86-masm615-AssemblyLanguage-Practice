.model small
.stack 100h
.data
	var dd 012345678h 
	sum db 00
	rev dd 0h
	;res dd 87654321h
	sum_prompt db "SUM: $"
	rev_prompt db "Reversed: $"
	 
	
    ; Input/Output Data
    
    digitCount db 0 
    anotherCounter db 0
    enteredNumber dw 0
    temp1 dw 0
    counter db 0
    inputStr db "Enter any number: ","$"
    outputStr db "Number is: ","$"     
           
    ; Input/Output Data
	
	
.code
	mov ax, @data
	mov ds, ax
	mov ax, 0
	
	
	mov si, offset var
	mov di, offset rev + 3
	mov bl, 10h
	mov cx, 4
	

	L1:	; calculate sum and reverse number
		mov al, byte ptr[si]
		div bl

		add sum, ah
		add sum, al	
		
		mov dl, al
		mov al, ah
		mov ah, 0
		mul bl
		add al, dl		
		mov byte ptr[di], al	; store reversed number

		dec di
		inc si
		
	Loop L1 
	
	
	
	; Display
	         
	mov ax, 0
    mov al, sum
    mov enteredNumber, ax
                     
                     
    call endl  
    
    lea dx, sum_prompt	; get address of sum_prompt
    mov ah, 9
    int 21h
    
    call output_multi_dec
	
    call endl
    
    lea dx, rev_prompt	; get address of sum_prompt
    mov ah, 9
    int 21h
    
    lea si, rev
    add si, 3  ; Starting from end because of little endian
    mov cx, 0         
    mov ax, 0
    
 
    
    l5:
        cmp cx, 4
        je end_l5    
    
        mov al, [si]       
        
        mov enteredNumber, ax
        
        call output_multi	; print multiple digits
              
        inc cx
        dec si      
              
        jmp l5	
    	
	 end_l5:
	
	
exit:		
	mov ah, 4ch
    int 21h
	
	
	
	
	
	
	; Functions 
	
	
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
	
	
	
	
    output_multi proc 
           
        push ax
        push bx
        push cx
        push dx        
        
        
         ;OUTPUT multidigit number
        
         OUTPUT:
            mov dx, 0
        	MOV AX, enteredNumber
        	MOV Bx, 16
        	L100:
                mov dx, 0
        		CMP Ax, 0
        		JE DISP
        		DIV Bx
        		MOV cx, dx
        		PUSH CX
        		inc counter
        		MOV AH, 0
        		JMP L100
        
        DISP:
        	CMP counter, 0
        	JE EXIT100
        	POP DX
        	ADD DX, 48
        	MOV AH, 02H
        	INT 21H
        	dec counter
        	JMP DISP
        	
        exit100:
        	
        pop dx
        pop cx
        pop bx 
        pop ax
        
        ret    
    output_multi endp
	
	
	
	output_multi_dec proc 
           
        push ax
        push bx
        push cx
        push dx        
        
        
         ;OUTPUT multidigit number
        
         OUTPUT1:
            mov dx, 0
        	MOV AX, enteredNumber
        	MOV Bx, 10
        	L101:
                mov dx, 0
        		CMP Ax, 0
        		JE DISP1
        		DIV Bx
        		MOV cx, dx
        		PUSH CX
        		inc counter
        		MOV AH, 0
        		JMP L101
        
        DISP1:
        	CMP counter, 0
        	JE EXIT101
        	POP DX
        	ADD DX, 48
        	MOV AH, 02H
        	INT 21H
        	dec counter
        	JMP DISP1
        	
        exit101:
        	
        pop dx
        pop cx
        pop bx 
        pop ax
        
        ret    
    output_multi_dec endp
	
	
end