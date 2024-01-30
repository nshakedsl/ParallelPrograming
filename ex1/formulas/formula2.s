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
    # x - rdi
    # y - rsi
    # n - rdx, assuming n divides 4 for simplicity

    # calculating xy in xmm2
    # calculating x^2 in xmm3
    # calculating y^2 in xmm4
    vxorps xmm2, xmm2, xmm2
    vxorps xmm3, xmm3, xmm3
    vxorps xmm4, xmm4, xmm4
    vxorps xmm5, xmm5, xmm5 # Xi^2
    vxorps xmm6, xmm6, xmm6 # Yi^2
    vxorps xmm7, xmm7, xmm7 # 2xiyi + 1

    # the loop
    xor r8, r8 # defining byte counter in r8
    xor r9, r9 # defining loop counter in r9
.for_loop:
    cmp r9, rdx # r9 - rdx
    jge .end_for_loop # if r9 - rdx >= 0 then jump

# inside the loop
    vmovaps xmm0, [rdi + r8] # loading x value
    vmovaps xmm1, [rsi + r8] # loading y value

    # calculating xy
    vmulps xmm5, xmm0, xmm1
    # adding xy to sum(xy)
    vaddps xmm2, xmm5, xmm2

    # calculating x^2, and adding it to sum(x^2)
    vmulps xmm0, xmm0, xmm0
    vaddps xmm3, xmm0, xmm3

    # calculating y^2, and adding it to sum(y^2)
    vmulps xmm1, xmm1, xmm1
    vaddps xmm4, xmm1, xmm4



    add r8, 16 # increasing byte counter
    add r9, 4 # increasing loop counter

    jmp .for_loop # jumping to the start of the loop

.end_for_loop:
    vaddps xmm3, xmm4, xmm3 # calculating sum(x^2) + sum(y^2)

    # summing the 4 seperate values in xmm2, to one value
    vshufps xmm6, xmm2, xmm2, 0b01001110
    vaddps xmm2, xmm6, xmm2
    vshufps xmm6, xmm2, xmm2, 0b10110001
    vaddps xmm2, xmm6, xmm2

    # summing the 4 seperate values in xmm3, to one value
    vshufps xmm6, xmm3, xmm3, 0b01001110
    vaddps xmm3, xmm6, xmm3
    vshufps xmm6, xmm3, xmm3, 0b10110001
    vaddps xmm3, xmm6, xmm3


    # vsqrtss xmm3, xmm3, xmm3 #calculating sqrt(sum(x^2) + sum(y^2))


    #vsubss xmm0, xmm2, xmm3 # calculating the final value
    ret


	mov 	 rsp, rbp	#restore stack
	pop 	 rbp
	ret			        #return turn
