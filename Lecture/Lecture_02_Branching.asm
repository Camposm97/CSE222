.data
	var1: .word 3
	var2: .word 7
	msg1: .asciiz "v1 is greater than v2"
	msg2: .asciiz "v2 is greater than v1"
.text
main:
	lw $t1 var1	# load var1 into t1
	lw $t2 var2	# load var2 into t2
	
	slt $t0 $t1 $t2		# If t1 < t2 then t0 = 0 Else t0 = 0
	beq $t0 $0 label_1		# If t0 == 0 then jump to label_1
	la $a0 msg2			# Else Load address msg2 to a0
	j label_2			# Jump to label_2

label_1:
	la $a0 msg1			# load address msg1 to a0

label_2:
	li $v0 4			# Print string
	syscall
	