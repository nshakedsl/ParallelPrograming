# 325655058 ofir gurvits
# 323082867 Shaked Solomon
.intel_syntax noprefix

.globl hamming_dist
.section .data
    .align 16
.section .rodata

.text	#the beginnig of the code
hamming_dist: #recieves as arguments two pointers %rdi = &str1 %rsi = &str2
    push	rbp		#save the old frame pointer
    mov	    rbp,rsp
    push    rbx        #push rbx to stack for later

    xor    rax,rax
    xor    rcx,rcx
    pxor   xmm0,xmm0
    .L4:
    pmovmskb ecx,xmm0 # load the msb of each byte to a bit in eax
    popcnt  ecx,ecx   # count matching chars
    add     rax,16   # add the amount of matching chars to the return value
    sub      rax,rcx
    movdqa  xmm1, [rdi] # load the first 16 chars
    movdqa  xmm2, [rsi] # load the first 16 chars
    add    rdi,16   # move forward 16 characters
    add    rsi,16   # move forward 16 characters 00010010
    mov    rbx,0b00100010
    pcmpistrm xmm1, xmm2, 0b01001000 # Compare for equality, result in XMM0
    jne .L4             # if null byte was encountered in xmm2 then zf is 0
    jns .L4             # if null byte was encountered in xmm1 then zf is 0

    pmovmskb ecx,xmm0 # load the msb of each byte to a bit in eax
    popcnt   ecx,ecx   # count matching chars
    add      rax,16   # add the amount of matching chars to the return value
    sub      rax,rcx
    sub      rax, 16
	mov 	 rsp, rbp	#restore stack
	pop 	 rbp
	ret			        #return turn
