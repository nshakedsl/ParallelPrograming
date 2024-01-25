# 325655058 ofir gurvits
# 323082867 Shaked Solomon
.intel_syntax noprefix

.globl formula2
.section .data
    .align 16
.section .rodata

.text	#the beginnig of the code
formula2: #recieves as arguments two pointers %rdi = &str1 %rsi = &str2
    push	rbp		#save the old frame pointer
    mov	    rbp,rsp
    push    rbx     #push rbx to stack for later

	mov 	 rsp, rbp	#restore stack
	pop 	 rbp
	ret			        #return turn
