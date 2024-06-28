.model small
.stack 0100h
.data
	InputVal db ?
	InputStr db "099"
	InputPrompt db 10, "Enter a Number(1-100) : $"
	OutputPrompt db 10, "Factors: " , 10, "--------------------" ,10 ,"$"
	
	digitCount db 0 
	anotherCounter db 0
	enteredNumber dw 0
	temp1 dw 0
	counter db 0
	inputStr1 db "Enter any number: ","$"
	outputStr1 db "Number is: ","$"
	
	
	
.code
	mov ax, @data
	mov ds, ax
	mov ax, 0
	jmp Main
	
OutputNum Proc
	push bx
		mov ax, 0
		mov al, dl
		mov bl, 10
		div bl
		mov dx,0
		
		mov dl, al
		mov dh, ah
		
		add dl, 30h
		mov ah, 02h
		int 21h
		
		mov dl, dh
		add dl, 30h
		int 21h
		
		mov dl, 10
		int 21h
				
	pop bx
	ret
OutputNum endp

InputData proc
	lea dx, [di]
	mov ah, 09h
	int 21h
	
	; lea dx, offset InputStr
	mov dx, offset InputStr
	mov ah, 03fh
	int 21h
	
	mov ax, 0
	mov bl, 10
	mov si, offset InputStr
	mov cl, lengthof InputStr

	L1:
		cmp byte ptr[si], 0Dh
		je Return
		mul bl
		
		add al, [si]
		sub al, 30h
	
		inc si
	Loop L1
	
	Return: 
	mov InputVal, al
	ret
InputData endp 


OutputFactors proc
	pop bx
	
	lea dx, offset OutputPrompt
	; lea dx, OutputPrompt
	; mov dx, offset OutputPrompt
	mov ah, 09h
	int 21h
	
	mov ah,02h
	L2:
		pop dx
		call OutputNum
	cmp sp,0100h
	jne L2
	
	push bx
	ret
OutputFactors endp

Factors proc
	mov cl, InputVal
	pop dx
	
	L3:
		mov ax, 0
		mov al, InputVal
		div cl
		
		cmp ah,0
		jne SkipFactor
			push cx
		SkipFactor:
	Loop L3

	push dx
	ret
Factors endp

Main:
	mov ax, 0
	mov cx, 0
	mov si, offset InputVal
	mov di, offset InputPrompt
	;call InputData2
	
	mov ah,09h ; Print String
	mov dx,offset inputStr1
	int 21h
	
	input:
	mov ah,01h
	int 21h
	cmp al,13 ;Stop taking input if user presses Enter key
	je stopIt
	sub al,48
	mov ah,0
	mov temp1, ax 
	mov ax,0
	mov ax,enteredNumber
	mov bx,10
	mul bx
	add ax,temp1
	mov enteredNumber,ax ; Store Number in Variable 
	inc digitCount ; Count Number of Digits
	jmp input
	stopIt:

	mov ax, enteredNumber
	mov InputVal, al
	
	
	
	
	
	cmp InputVal, 100
	ja exit
	cmp InputVal, 0
	je exit

	call Factors

	call OutputFactors
exit:
	mov ah, 04ch
	int 21h
end