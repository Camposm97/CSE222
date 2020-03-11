.macro saveAddr(%ra)
	sub $sp $sp 4	# Make space in stack
	sw %ra 0($sp)	# Save address in stack pointer
.end_macro
.macro loadAddr(%ra)
	lw %ra 0($sp)	# Load address from stack
	addi $sp $sp 4	# Restore stack pointer
.end_macro
.data
str: .asciiz "End of Program"
newLine: .asciiz "\n"
.text
main:
	jal functionA
	
terminate:
	li $v0 4
	la $a0 str
	syscall

	li $v0 10
	syscall
	
functionA:
	saveAddr($ra)
	li $a0 10
	li $a1 20
	jal emitInt # [10, 30)
	move $s0 $v0
	li $v0 1
	move $a0 $s0
	syscall
	
	li $v0 4
	la $a0 newLine
	syscall
	
	move $a0 $s0
	jal isEven
	move $a0 $v0
	li $v0 1
	syscall
	
	li $v0 4
	la $a0 newLine
	syscall
	
	loadAddr($ra)
	jr $ra
	
# a0 = lower bound
# a1 = upper bound
# Generates a random number and returns it
emitInt:
	saveAddr($ra)
	move $t0 $a0	# Move lower bound to t0
	li $v0 42	# Generate random number
	syscall
	# Range = [lower bound, lowerbound + upperbound)
	
	add $a0 $a0 $t0	# Add lower bound
	move $v0 $a0	# Set v0 = generated number
	loadAddr($ra)
	jr $ra

# a0 = integer
isOdd:
	saveAddr($ra)
	srl $v0 $a0 1	# Shift integer to the right once and store in v0
	sll $v0 $v0 1	# Shift integer in v0 to the left once and store in itself
	sne $v0 $v0 $a0	# If v0 == a0 then v0 = 1
	# If the original integer equals NOT itself after being shifted then the number is odd
	loadAddr($ra)
	jr $ra
	
# a0 = integer
isEven:
	saveAddr($ra)
	srl $v0 $a0 1	# Shift integer to the right once and store in v0
	sll $v0 $v0 1	# Shift integer in v0 to the left once and store in itself
	seq $v0 $v0 $a0	# If v0 == a0 then v0 = 1
	# If the original integer equals itself after being shifted then the number is even
	loadAddr($ra)
	jr $ra