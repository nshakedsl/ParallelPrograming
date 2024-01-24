# 325655058 ofir gurvits
# 323082867 Shaked Solomon
.globl hamming_dist
.globl b64_distance
.section .data
    .align 16
.section .rodata

.text	#the beginnig of the code
hamming_dist: #recieves as arguments two pointers %rdi = &str1 %rsi = &str2
    pushq	%rbp		#save the old frame pointer
    movq	%rsp, %rbp
    pushq   %rbx        #push rbx to stack for later

    xorq    %rax,%rax
    xorq    %rcx,%rcx
    .L4:
    addq    %rcx,%rax   # add the amount of matching chars to the return value
    movdqa  (%rdi), %xmm0 # load the first 16 chars
    movdqa  (%rsi), %xmm1 # load the first 16 chars
    subq    $16, %rdi   # move forward 16 characters
    subq    $16 ,%rsi   # move forward 16 characters
    pcmpistri $0x0, %xmm0, %xmm1  # compare str1 and str2
    je .L4              #if null byte was encountered in xmm2 then zf is 0
    jns .L4             #if null byte was encountered in xmm1 then zf is 0

	movq	%rbp, %rsp	#restore stack
	popq	%rbp
	ret			        #return turn
