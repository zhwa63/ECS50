#Authors: Angela(Haowen) Zhou, Courtney Laux

.data	0xA00
arr:	.space	 40
.data	0xA30
arr2:	.space	 40	
	.text	0
main:
init:	add	$t4,$0,$0	#t4(result) = 0
	addu	$t0,$0,$0	#initialize index of arr1 and arr2
	#addu	$a2,$0,$0	#initialize index of arr2
	la	$t3,arr	#load arr into t3
	la	$t6,arr2	#load arr2 into t6
loop1:	sll	$t1,$t0,2	#go to offset of next element
	add	$t1,$t1,$t6	#t1 = arr2[i]
	lw	$a2,0($t1)	#a2 = t1 = y
	nop
	sll	$t9,$t0,2	#offset of arr2
	add	$t9,$t9,$t3	#t9 = arr1[i]
	lw	$a1,0($t9)	#a1 = t9 = x
	nop
	jal	multiply
print:	add	$a0,$t4,$0	#add t4 to print
	addi	$v0,$0,1
	syscall
	subu	$t4,$t4,$t4	#reset t4 to 0
	addiu	$t0,$t0,1	#add one to current arr1/2 index
	#addiu	$a2,$a2,1	#arr2 index++
	slti	$t2,$t0,10	#see if the index is 10 yet
	bne	$t2,$0,loop1	#nope,go back to loop
	nop
	addiu	$v0,$0,10
	syscall
	.end

multiply:	
loop2:	beq	$a2,$0,return 	#if y = 0, return
	nop
	andi	$t8,$a2,1	# t8 = y & 1
	beq	$t8,$0,shift	# if t8 ==0,shift
	nop
	add	$t4,$t4,$a1	#result(t4) += x
shift:	sll	$a1,$a1,1	#x<<=1
	sra	$a2,$a2,1	#y>>=1
	j	loop2
	nop
return:	jr	$ra