    ; Muhammad Hamza
	; 1602028
include Irvine32.inc
        ; Without Align Structure 
Employee STRUCT
    LastName BYTE "Muhammad Hamza"
    IdNum WORD 0
    Years WORD 0
    SalaryHistory DWORD 0 ,0 ,0 ,0
Employee ENDS
       ; With Align Structure
AlignEmployee STRUCT
    LastName BYTE "Muhammad Hamza"
	ALIGN WORD
    IdNum WORD 0
    ALIGN WORD
	Years WORD 0
	ALIGN DWORD
    SalaryHistory DWORD 0 ,0 ,0 ,0
AlignEmployee ENDS



.data
ArraySize = 100
x DWORD ?
y DWORD ?
Object Employee ArraySize DUP(<'\0',0,0,4 DUP (0)>)  ;without Align Array

ALIGN 
AObject AlignEmployee ArraySize DUP(<'\0',0,0,4 DUP (0)>)  ;with Align Array

.code
main proc
    
   call GetMseconds
	mov x,eax
	;call WriteInt
	call Crlf

	call WithoutAlign

	call GetMseconds
	;call WriteInt
	sub eax,x
	call WriteInt       ;Display Time after Without Align Called 
	call Crlf
	call WaitMsg

	call Crlf
	call Crlf
	call Crlf



	call GetMseconds
	mov x,eax
	;call WriteInt
	call Crlf

	call WithAlign          ;Display Time after With Align Called

	call GetMseconds
	;call WriteInt
	sub eax,x
	call WriteInt
	call Crlf
	call WaitMsg




	invoke ExitProcess,0
main endp

            ; WithoutAlign Proc 
WithoutAlign proc
   enter 0,0

    mov edi,0
	mov ecx,ArraySize
	mov ax,80
	mov edx,0

	abc:	
    mov (Employee PTR Object[edi]).IdNum,cx
	mov (Employee PTR Object[edi]).Years,ax
	mov (Employee PTR Object[edi]).SalaryHistory[edx+0],1200
	mov (Employee PTR Object[edi]).SalaryHistory[edx+4],1300
	mov (Employee PTR Object[edi]).SalaryHistory[edx+8],1400
	mov (Employee PTR Object[edi]).SalaryHistory[edx+12],1500
	add edi,TYPE Employee
	inc edx
	inc ax
	loop abc

   leave 
   ret 
WithoutAlign endp


; WithAlign Proc

WithAlign proc
   enter 0,0

    mov edi,0
	mov ecx,ArraySize
	mov ax,80
	mov edx,0

	abc:	
    mov (AlignEmployee PTR AObject[edi]).IdNum,cx
	mov (AlignEmployee PTR AObject[edi]).Years,ax
	mov (AlignEmployee PTR AObject[edi]).SalaryHistory[edx+0],1200
	mov (AlignEmployee PTR AObject[edi]).SalaryHistory[edx+4],1300
	mov (AlignEmployee PTR AObject[edi]).SalaryHistory[edx+8],1400
	mov (AlignEmployee PTR AObject[edi]).SalaryHistory[edx+12],1500
	add edi,TYPE AlignEmployee
	inc edx
	inc ax
	loop abc

   leave 
   ret 
WithAlign endp



end main

