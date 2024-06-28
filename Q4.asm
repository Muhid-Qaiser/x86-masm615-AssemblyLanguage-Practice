.model small
.stack 050h

.data
	string db " ,Madam, I'm Adam"				
	;string db "you're damn mad,roy"
	len equ lengthof string	
	mask1 db 11011111b						;Mask To Convert LowerCase to UpperCase
	res db 0								
	is_pal db "is Palindrome$"
	not_pal db "is NOT Palindrome$" 
	len=$-string
	
.code
	mov ax, @data
	mov ds, ax
	mov ax, 0
	mov cx, 0
	
	; Start

	mov si , offset string-1				
	mov di , offset string					
	
	L1:									
		inc si								
		mov al , [si]	
		and al , mask1						;Convert Lower Case To Upper Case
		inc ch	
										
		cmp al , "A"						;if (al < "A") -> (Special Character)
		jb L1								
		
		cmp al , "Z"						;if (al > "Z") -> (Special Character)
		ja L1
		
		mov al , [si]						
		mov [di] , al
		inc di
		inc cl
		
	cmp ch, len
	jne L1
	
	mov ch , 0
	mov si , offset string					
	mov di , offset string
	add di , cx
	dec di									;di Points to Last Index of Updated String
	
	L2:
		cmp si , di							
		jae SaveP							;Successfull Check of n/2 elements 
		
		mov al , [si]
		and al , mask1						;Convert LowerCase to UpperCase
		
		mov dl , [di]
		and dl , mask1						;Convert LowerCase to UpperCase
		
		cmp al , dl							; check if not equal
		jne SaveN
		
		inc si
		dec di
		jmp L2		
	
SaveP:	; Is Palindrome
	mov res, 0FFh
	Mov dx, offset is_pal
	Mov ah, 9
	Int 21h
	
	
	jmp Exit
	

SaveN:	; Is Not Palindrome
	mov res, 0AAh
	Mov dx, offset not_pal
	Mov ah, 9
	Int 21h
	
Exit:		
	mov ah , 4ch
	int 21h
end