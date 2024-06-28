.model small
.stack 0100h
.data      

    digitCount db 0 
    anotherCounter db 0
    enteredNumber dw 0
    temp1 dw 0
    counter db 0
    inputStr db "Enter any number: ","$"
    arm db "is Armstrong$"   
    notarm db "is NOT Armstrong$"
    digit dw 0 
    ans dw 0 
    digit_lists db 5 dup(?) 
    i db 0
    
.code
    mov ax, @data
    mov ds, ax
    mov ax, 0  
    
    ; Start
    
     mov ah,09h ; Print String
     mov dx,offset inputStr
     int 21h
    
     ;input multidigit number
    
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
     
     
    ; Endl
    MOV dl, 10 
    MOV ah, 02h
    INT 21h
    MOV dl, 13
    MOV ah, 02h
    INT 21h
                
    mov ax, enteredNumber
    mov  dx, 0
    mov  bx, 10
    div  bx
    mov digit, dx
    mov temp1, ax
     
    exitArm: 
     
     
     mov cx, 0             
     mov ax, 0
                  
     loop1:
         cmp cl, digitCount
         je end_loop1
         
         mov ax, digit
         mov i, 1
         
         loop2: 	; multiply number by itself, DigitCount amount of time
            mov dl, digitCount
            cmp i, dl
            je end_loop2 
            
            mul digit 
            inc i
            jmp loop2
            
            
         end_loop2:
         
    
         add ans, ax	; store the result in ans for checking later
         
         mov bx, 10
         mov ax, temp1 
         mov dx, 0
         div bx   
         mov digit, dx   
         mov temp1, ax
         
         
         inc cx
      
         jmp loop1
      
      
     end_loop1:
        
     
         mov ax, ans
         cmp ax, enteredNumber	; checking it number is armstrong or not
         je armstrong
         
         
         mov ah,09h ; Print String
         mov dx,offset notarm
         int 21h
         jmp exit             
         
         armstrong:
             mov ah,09h ; Print String
             mov dx,offset arm
             int 21h    
     
    
    
    EXIT:
        mov ah, 4ch
        int 21h
end