.include "Macro_Keys.asm"

.text
main:
	#li $a0 2		# a0 = 2
	#li $a1 3		# a1 = 3
	#li $a2 4		# a2 = 4
	#li $a3 5		# a3 = 5
	jal diff_Of_Sums	# Call function: diff_Of_Sums
	move $s1 $v0		# Move result in s1
	
	print("Diff_Of_Sums: ")
	prntInt($s1)		# Print integer (result)
	print("\n")		# Print new line
	
	print("Emit_Int: ")
	li $a0 100		# Set upper bound
	jal emit_Int		# Call emit_Int function
	move $t0 $v0		# Move return value to t0
	prntInt($t0)		# Print integer (result)

terminate:
	li $v0 10		# End program
	syscall

diff_Of_Sums:		# Generates 4 random numbers and gets the sum difference
	addi $sp $sp -12
	sw $ra 0($sp)

	li $a0 100		# Pass parameter
	jal emit_Int	
	move $t0 $v0		# t0 = random number
	li $a0 100		# Pass parameter
	jal emit_Int
	move $t1 $v0		# t1 = random number
	li $a0 100		# Pass parameter
	jal emit_Int
	move $t2 $v0		# t2 = random number
	li $a0 100		# Pass parameter
	jal emit_Int
	move $t3 $v0		# t3 = random number

	add $t0 $t0 $t1	# t0 = t0 + t1
	add $t2 $t2 $t3	# t2 = t2 + t3
	sub $v0 $t0 $t1	# v0 = t0 + t2
	
	lw $ra 0($sp)	# Push return address
	addi $sp $sp 4	# Recover stack pointer
	jr $ra			# Return to caller
	
emit_Int:			# Has a parameter for upper bound
	#addi $sp $sp -8	# Make room for stack pointer
	sw $ra 4($sp)	# Save return address to sp
	sw $a0 8($sp)	# Save argument to sp

	li $v0 42		# Generate random number
	move $a1 $a0		# Move parameter to a1 for upper bound
	syscall		
	move $v0 $a0		# Move generated number to v0 (return value)

	lw $a0 8($sp)	# Push and store in a0 (recover argument)
	lw $ra 4($sp)	# Push and store in ra (recover return address)
	#addi $sp $sp 8	# Make stack pointer equal to 0
	jr $ra			# Return to caller