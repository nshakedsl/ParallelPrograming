# 325655058 ofir gurvits
# 323082867 Shaked Solomon
.intel_syntax noprefix

.globl formula2
.section .data
    .align 16
.section .rodata
        float_array: .float 1.0, 1.0, 1.0, 1.0

.text	#the beginnig of the code
formula2: #recieves as arguments two pointers %rdi = &str1 %rsi = &str2
    #push	rbp		#save the old frame pointer
    #mov	    rbp,rsp
    #push    rbx     #push rbx to stack for later
    #push    rbx
    # x - rdi
    # y - rsi
    # n - rdx, assuming n divides 4 for simplicity

    # calculating xy in xmm2
    vxorps xmm2, xmm2, xmm2
    vmovups xmm3, [rip+float_array] #initialize those arrays to 1's
    vmovups xmm4, [rip+float_array]
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
    vsubps xmm0, xmm0, xmm1 # calculate x - y
    vmulps xmm0,xmm0,xmm0   # (x-y)^2
    vaddps xmm0, xmm3, xmm0 # (x-y)^2 + 1
    vmulps xmm4, xmm4, xmm0 # store Pi (xi^2 + yi^2 - 2xiyi + 1)
    add r8, 16 # increasing byte counter
    add r9, 4 # increasing loop counter

    jmp .for_loop # jumping to the start of the loop

.end_for_loop:

    vshufps xmm0, xmm2, xmm2, 0b01001110
    vaddps xmm2, xmm0, xmm2
    vshufps xmm0, xmm2, xmm2, 0b10110001
    vaddps xmm2, xmm0, xmm2

    vshufps xmm0, xmm4, xmm4, 0b01001110
    vmulps xmm4, xmm0, xmm4
    vshufps xmm0, xmm4, xmm4, 0b10110001
    vmulps xmm4, xmm0, xmm4

    vdivps xmm0, xmm2, xmm4 # calculating the final value

	ret			        #return turn
