.model small
.stack 050h
.data
	rows equ 3
	cols equ 3
	ary db rows dup (cols dup(0)) 
	;ary db 0, 0, 0,				; For emulator
	;		db 0, 0, 0,
	;		db 0, 0, 0
	
	Srow db 2						;Specifying Row for Sum
	RSum db 0
	
	LDSum db 0                      ; Sum of Left Diagonal
	RDSum db 0
	
	Max db 0                        ; Max in Row
	MSRow db 1
	
	colt equ 3                      ; Transpose Matrix, cols and rows
	rowt equ 3
	tps db rows dup(colt dup(0))
	;tps db 0, 0, 0,				; For emulator
	;		db 0, 0, 0,
	;		db 0, 0, 0 
	


	res db 3 dup(3 dup(0))          ; Resultant Matrix
	;res db 0, 0, 0,				; For emulator
	;		db 0, 0, 0,
	;		db 0, 0, 0 
	
.code
	mov ax, @data
	mov ds, ax
	mov ax, 0
	mov cx, 0
	mov dx, 0
	mov bx, 0 
	
	; Start
	
;------------- Initializing -------------;
	mov si, offset ary
	LI1:
		mov cl, 0
		LI2:
			inc al
			mov [si], al
			;inc al
			;add si, type ary
			add si, 1
			inc cl
			cmp cl, cols
			jne LI2
				
		inc ch
		cmp ch, rows
		jne LI1
	
	
	mov ax , 0
	mov bx , 0
	mov cx , 0
	mov dx , 0
;--------------- Row Sum ---------------;
	
	mov si, offset ary
	mov al, cols
	mul Srow
	add si, ax	
	mov cl , 0
	
	LRS1:
		mov dl, [si]
		add RSum, dl
	
		;add si, type ary
		add si, 1
		inc cl
		cmp cl, cols
		jne LRS1


	mov ax , 0
	mov bx , 0
	mov cx , 0
	mov dx , 0 
	
;---------------- Row Max ---------------;

	mov si , offset ary
	mov al , cols
	mul MSRow
	add si , ax
	
	mov dl , [si]
	mov Max , dl
	mov bx , si
	
	LRM:
		mov dl , [si]
		
		cmp Max , dl
		jae SkipUpdateMax
			mov Max , dl
		
		SkipUpdateMax:
		
		;add si , type ary
		add si, 1
		inc cl
	cmp cl , cols
	jne LRM


	mov ax , 0
	mov bx , 0
	mov cx , 0
	mov dx , 0
	
;------------ Sum LDiagonal ------------;

LLDS:
	mov si , offset ary
	mov al, cols
	mul cl
	add al, cl
	add si, ax
	
	mov dl, [si]
	add LDSum , dl
	
	inc cl
	cmp cl, rows
	jne LLDS

    
	mov ax , 0
	mov bx , 0
	mov cx , 0
	mov dx , 0 
;-------------- Transpose --------------;

	;mov dl , type ary  
	mov dl, 1
	LT1:
		mov cl, 0
		LT2:
			mov si , offset ary
			mov al , rows
			mul ch
			add al , cl
			mul dl
			
			add si , ax
			mov bl , [si]
			mov ax , 0
			
			mov di , offset tps
			mov al , rows
			mul cl
			add al , ch
			mul dl
			
			add di , ax
			mov ax , 0
			
			mov [di], bl
			
			add cl , dl
			cmp cl , cols
			jne LT2
		
		add ch , dl
		cmp ch , rows
		jne LT1
	

	mov ax , 0
	mov bx , 0
	mov cx , 0
	mov dx , 0
;------------ Multiplication -----------;
	
	LM1:
		mov cl , 0
		LM2:
			mov di , offset res
			mov al , colt
			mul ch
			add al , cl
			add di , ax
			
			mov dh , 0
			LM3:
				mov si , offset ary
				mov al , cols
				mul ch
				add al , dh
				add si , ax
				mov dl , [si]
				
				mov si , offset tps
				mov al , colt
				mul dh 
				add al , cl
				add si , ax
				
				mov al , [si]
				mul dl
				add [di] , al
				mov al, 0
			
				inc dh
			
				cmp dh , cols
				jne LM3
				
			inc cl
			cmp cl , colt
			jne LM2
		
		inc ch
		cmp ch , rows
		jne LM1

;---------------------------------------;  


            
            
            
            
            
; I am abit confused as which exactly is left and right diagonal so I will mention this just in case

mov ax , 0
mov bx , 0
mov cx , 0
mov dx , 0
	
;------------ Sum RDiagonal ------------;

;mov dh , type ary
mov dh, 1
mov cl , cols
dec cl

LRDS:
	mov si , offset ary
	mov al , cols
	mul ch
	add al , cl
	mul dh
	
	add si , ax
	mov dl , [si]
	add RDSum , dl
	
	inc ch
	dec cl
	
	cmp ch , rows
	jne LRDS
		

;---------------------------------------; 


exit:
	mov ah, 04ch
	int 21h
	
end