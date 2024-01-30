# 325655058 ofir gurvits
# 323082867 Shaked Solomon
.intel_syntax noprefix

.globl formula2
.section .data
    .align 16
    float_array: .float 1.0, 1.0, 1.0, 1.0
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
    vmovaps xmm3, [float_array]
    vxorps xmm4, xmm4, xmm4
    vxorps xmm5, xmm5, xmm5 # Xi^2
    vxorps xmm6, xmm6, xmm6 # Yi^2
    vxorps xmm7, xmm7, xmm7 # 2xiyi
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
    vaddps xmm2, xmm5, xmm2 # calculate sigma xy
    # calculating xi^2, and yi^2
    vmulps xmm0, xmm0, xmm0
    vmulps xmm1, xmm1, xmm1
    vaddps xmm5, xmm5, xmm5 # calculate 2xy
    vaddps xmm1, xmm1, xmm0 # xi^2 + yi^2
    vsubps xmm1, xmm1, xmm5 # xi^2 + yi^2 - 2xiyi
    vaddps xmm1, xmm3, xmm1 # xi^2 + yi^2 - 2xiyi + 1
    vmulps xmm4, xmm4, xmm1 # store Pi (xi^2 + yi^2 - 2xiyi + 1)
    add r8, 16 # increasing byte counter
    add r9, 4 # increasing loop counter

    jmp .for_loop # jumping to the start of the loop

.end_for_loop:


    mov     r9,rdx
    and     rdx,3
    lea     rax, [rdx*4] # rax = rdx * 3
    sub     r9, rax     # r9 = r9 - rax
    xor     r8,r8
    vxorps xmm1, xmm1, xmm1
    vxorps xmm0, xmm0, xmm0

loop_start:
    cmp r8, rdx             # Compare counter (rcx) with rdx
    jge loop_end            # Jump to loop_end if r8 >= rdx

    vmovss xmm0, xmm0, [rdi + r9] # Load float1 into the lowest 32 bits of xmm0
    vshufps xmm0, xmm0, xmm0, 0x39 # Shift left by 32 bits
    vmovss xmm1, xmm1, [rsi + r9] # Load float1 into the lowest 32 bits of xmm0
    vshufps xmm1, xmm1, xmm1, 0x39 # Shift left by 32 bits

    inc r8          # Increment the counter
    add 4,r9
    jmp loop_start   # Jump back to the start of the loop
loop_end:

    # recalculate xy
    vmulps xmm5, xmm0, xmm1
    # adding xy to sum(xy)
    vaddps xmm2, xmm5, xmm2 # calculate sigma xy

    # calculating xi^2, and yi^2
    vmulps xmm0, xmm0, xmm0
    vmulps xmm1, xmm1, xmm1
    vaddps xmm5, xmm5, xmm5 # calculate 2xy
    vaddps xmm1, xmm1, xmm0 # xi^2 + yi^2
    vsubps xmm1, xmm1, xmm5 # xi^2 + yi^2 - 2xiyi
    vaddps xmm1, xmm3, xmm1 # xi^2 + yi^2 - 2xiyi + 1
    vmulps xmm4, xmm4, xmm1 # store Pi (xi^2 + yi^2 - 2xiyi + 1)

    vshufps xmm0, xmm2, xmm2, 0b01001110
    vaddps xmm2, xmm0, xmm2
    vshufps xmm0, xmm2, xmm2, 0b10110001
    vaddps xmm2, xmm0, xmm2

    vshufps xmm0, xmm4, xmm4, 0b01001110
    vmulps xmm4, xmm0, xmm4
    vshufps xmm0, xmm4, xmm4, 0b10110001
    vmulps xmm4, xmm0, xmm2

    vdivps xmm0, xmm2, xmm4 # calculating the final value

    xor     rax,rax
    movd    eax,xmm0
	mov 	rsp, rbp	#restore stack
	pop 	rbp
	ret			        #return turn
