# 325655058 ofir gurvits
# 323082867 Shaked Solomon

.section .data
    .align 16
.section .rodata

.text	#the beginnig of the code
hamming_dist: #recieves as arguments two pointers %rdi = &str1 %rsi = &str2
    pushq	%rbp		#save the old frame pointer
    movq	%rsp,	%rbp
    pushq   %rbx   #push rbx to stack for later




	movq	$0, %rax
	movq	%rbp, %rsp	#restore stack
	popq	%rbp
	ret			        #return turn

b64_distance:
    pushq	%rbp		#save the old frame pointer
    movq	%rsp,	%rbp
    pushq   %rbx   #push rbx to stack for later




	movq	$0, %rax
	movq	%rbp, %rsp	#restore stack
	popq	%rbp
	ret
