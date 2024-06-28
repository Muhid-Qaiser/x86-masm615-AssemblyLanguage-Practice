.model small
.stack 100h
.data
    n equ 5
    array1 db 1, 2, 3, 4, 5
    array2 db 10, 22, 13, 4, 35    
    result db n dup(?)
    prompt db " Result: $"
	prompt1 db " Array1: $"
	prompt2 db " Array2: $"
    
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

main proc
    mov ax, @data
    mov ds, ax
        
    mov si, offset array1
    mov di, offset array2
    add di, n
    dec di
    mov bx, offset result
    
    mov cx, n

add_loop:  ; Add start of array1 with end of array2 and store in start of array3
    mov ax, 0
    mov al, [si]
    add al, [di]	; Adding here
    mov [bx], ax	; Storing here
    inc si
    dec di
    inc bx
    loop add_loop
    
    
    
    
    ; Display
	
	mov si, offset array1
    mov cx, n
    
    mov dx, offset prompt1
    mov ah, 9
    int 21h
    
    l3:       
        mov ax, 0
        mov al, BYTE PTR [si]      
        mov enteredNumber, ax
        
        call output_multi
        
        inc si
    
        loop l3
	
	
	call endl
	
	
	mov si, offset array2
    mov cx, n
    
    mov dx, offset prompt2
    mov ah, 9
    int 21h
    
    l1:       
        mov ax, 0
        mov al, BYTE PTR [si]      
        mov enteredNumber, ax
        
        call output_multi
        
        inc si
    
        loop l1
		
	call endl
	
     
    mov si, offset result
    mov cx, n
    
    mov dx, offset prompt
    mov ah, 9
    int 21h
    
    l2:       
        mov ax, 0
        mov al, BYTE PTR [si]      
        mov enteredNumber, ax
        
        call output_multi
        
        inc si
    
        loop l2
    
    
         
          
exit:
    mov ah, 4ch
    int 21h
    
    
main endp



; Function

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
    	MOV Bx, 10
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
    
	mov dl, ' '
	mov ah, 02h
	int 21h
    	
    
    ret    
output_multi endp








end
