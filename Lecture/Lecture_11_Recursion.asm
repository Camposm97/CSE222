.text	# LOOK AT THIS LATER!!!!!!!!!!!!!!!!!!!!!!
main:
	li $a0 4		# a0 = 4
	jal factorial	# Call factorial function
	
done:
	li $v0 10		# End program
	syscall

factorial:				# Parameter (int n (a0))
	addi $sp $sp -8		# Make room in stack pointer
	sw $ra 0($sp)		# Save return address
	sw $a0 4($sp)		# Save parameter
	ble $a0 1 factorial_Arg_Less_Than_One	# If a0 <= 1 jump to factorial_Arg_Le_One
	
	li $v0
	
factorial_Arg_Le_One:
	li $v0 1		# v0 = 1
	lw $ra 0($sp)	# Load return address
	addi $sp $sp 8	# Recover stack pointer
	jr $ra			# Jump to caller
	