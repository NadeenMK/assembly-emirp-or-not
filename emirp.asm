include inout.asm
.model small,c
.486
.stack 1000

;Enter a number to determine if it is an emirp or not

.data

     msg db 13,10,"Enter a number to determine if it is an emirp or not-->$"
	 msg2 db 13,10,"The number is an emirp.$"
	 msg3 db 13,10,"The number is not emirp.$"
	 msg4 db 13,10,"The number is not prime try another prime number.$"
	 num dw ?
     sum dw 0





.code

    isprime proc _num2$ :word
         LOCALS
		 uses cx,dx
 
		 mov cx,2
again:	
         mov ax,_num2$
     	 cwd		 
		 div cx
		 or dx,dx
		 JZ done
		 cmp cx,_num2$
		 JL next 

next:
      inc cx
	  or cx,_num2$
	  JL again
	     
done:
         mov ax,dx
	 
          ret
		 
  endp isprime

isemirp proc _num$ :word
         LOCALS
		 uses bx,cx,dx
		 
		 call isprime,_num$
		 or ax,ax
		 jz notprime
		 mov bx,10
		 mov ax,_num$
srart:
		 cwd
		 div bx
		mov cx,sum
		imul cx,bx
		add cx,dx
		mov sum,cx
		or ax,ax
		jnz srart	
		
		xor ax,ax
		call isprime,sum
		 or ax,ax
		jz notemirp
		call puts,offset msg2 
		 jmp done2

notemirp:
		call puts,offset msg3 
        jmp done2
		
notprime:
	
        call puts,offset msg4 

done2:	
         ret
		 
		 endp isemirp
		 

  	 
       .STARTUP
	   
	   call puts,offset msg
	   call getint
	   mov num,ax
	   call isemirp,num    
	   .EXIT  
end

   
