.data
prmptInt: .asciiz "Please enter an integer: "
.text
main:
	li $v0 4
	la $a0 prmptInt
	syscall
	
	li $v0 5
	syscall
	
	move $a0 $v0	# Move entered integer to a0
	jal funct_Count_Ones
	move $t0 $v0	# Move result to t0
	
	li $v0 1		# Print result
	move $a0 $t0
	syscall
terminate:
	li $v0 10
	syscall
	
funct_Count_Ones:
	move $s0 $a0	# Move a0 to s0
	li $t0 10		# Set t0 = 10
	li $s7 0		# Set s7 = 0 (1's counter)
loop_1:
	div $s0 $t0		# s0 / t0
	mfhi $t1		# t1 = remainder
	
	beq $t1 1 foundOne	# If t1 == 1, jump
	j cont_Loop
foundOne:
	addi $s7 $s7 1		# Increment counter
cont_Loop:
	mflo $s0			# s0 = quotient
	bgt $s0 0 loop_1		# If s0 > t0, jump to loop	
	
	move $v0 $s7		# v0 = result (counter)
	jr $ra