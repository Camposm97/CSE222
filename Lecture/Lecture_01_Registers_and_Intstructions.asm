.data
var1: .word 0x0000f00f	# 0000 0000 0000 0000 1111 0000 0000 1111
var2: .word 0x0000a002	# 0000 0000 0000 0000 1010 0000 0000 0010
var3: .word 0		# word reserves 4 bytes
var4: .word 0
var5: .word 0 
var6: .word 0

# var1, var2, and var3 are addresses

.text
main: # main is also an address, you can choose any name
	lw $t0, var1
	lw $t1, var2
	and $t2, $t0, $t1	# t2 = t0 & t1
	sw $t2, var3	# save word $t0 into var3

	#or $t2, $t0, $t1
	#sw $t2, var4
	
	andi $t3, $t1, 0x800f	# I-Type Instruction
	sw $t3, var5
	or $t2, $t0, $t1
	ori $t3, $t1, 0x800f	# I-Type Instruction
	sw $t3, var6

	li $v0, 10 # terminate program
	syscall

	# sll = shift left logical
	# srl = shift right logical
	# sra = shift right arithmetic
	# Examples:
	# sll t0, t1, 5 # t0 = t1 << 5
	# srl t0, t1, 5 # t0 = t1 >>> 5
	# sra t0, t1, 5 # t0 = t1 >> 5
	#
	# R-Type Instructions
	# sllv: shift left logical varaibale
	# srlv: shift right logical variable
	# srav: shift right arithmetic variable
	#
	# Examples:
	# sllv t0, t1, t2 # t0 = t1 << t2
	# srlv t0, t1, t2 # t0 = t1 >>> t2
	# srav t0, t1, t2 # t0 = t1 >> t2
	# 
	# Notes:
	# $0 always holds the value 0.  It CANNOT be changed!
	#