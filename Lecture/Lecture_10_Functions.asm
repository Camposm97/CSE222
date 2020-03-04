.macro print(%str)
	.data
	string: .asciiz %str
	.text
	li $v0 4
	la $a0 string
	syscall
.end_macro
.text
main:
	li $a0 2		# a0 = 2
	li $a1 3		# a1 = 3
	li $a2 4		# a2 = 4
	li $a3 5		# a3 = 5
	jal diff_Of_Sums
	move $s1 $v0		# Move result in s1
	
	print("Diff_Of_Sums: ")
	li $v0 1		# Print integer (the result)
	move $a0 $s1		# a0 = s1
	syscall
	print("\n")		# Print new line
	
	print("Emit_Int: ")
	li $a1 100		# Set upper bound
	jal emit_Int		# Call emit_Int function
	move $a0 $v0		# Move result into a0
	li $v0 1		# Print result
	syscall

terminate:
	li $v0 10	# End program
	syscall

diff_Of_Sums:	# Takes in arguments a0 - a3
	add $a0 $a0 $a1	# a0 = a0 + a1
	add $a2 $a2 $a3	# a2 = a2 + a3
	sub $v0 $a0 $a2	# v0 = a0 = a2
	jr $ra
	
emit_Int:		# Has a a1 parameter for upper bound
	li $v0 42	# Generate random number
	syscall
	move $v0 $a0
	jr $ra		# Return to caller