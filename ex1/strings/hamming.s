# 325655058 ofir gurvits
# 323082867 Shaked Solomon

.section .data
    .align 16
.section .rodata
    MAX_LEN: .int 128
    format: .string "%s"

.text	#the beginnig of the code
.globl	main	#the label "main" is used to state the initial point of this program
	.type	main, @function	# the label "main" representing the beginning of a function
main:	# the main function:

	pushq	%rbp		#save the old frame pointer
	movq	%rsp,	%rbp
    pushq   %rbx   #push rbx to stack for later

    # scanf("%s",str1);

    leaq    format(%rip), %rdi #load input format for scanf
    subq    $136, %rsp  # allocate stack space for str1
    leaq    8(%rsp),%rsi # load adress for *str1 to rsi
    xorq    %rax,%rax

    call    scanf
    addq $8, %rsp    # Adjust the stack pointer

    popq    %rbx    #restore rbx back to normal
	movq	$0, %rax	#return value is zero (just like in c - we tell the OS that this program finished seccessfully)
	movq	%rbp, %rsp	#restore the old stack pointer - release all used memory.
	popq	%rbp		#restore old frame pointer (the caller function frame)
	ret			        #return to caller function (OS)

hamming: #recieves as arguments two pointers %rdi = &str1 %rsi = &str2
    pushq	%rbp		#save the old frame pointer
    movq	%rsp,	%rbp
    pushq   %rbx   #push rbx to stack for later




	movq	$0, %rax
	movq	%rbp, %rsp	#restore stack
	popq	%rbp
	ret			        #return turn
