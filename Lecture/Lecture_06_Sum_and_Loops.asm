.data
msg1: .asciiz "Enter a number: "

.text
	li $v0 4		# Print a string
	la $a0 msg1
	
	li $v0 5		# Ask for integer (integer is stored in v0)
	syscall
	
	move $t0 $v0	# Move entered integer to t0
	
	addi $t1 $0 0	# t1 = 0 (sum)
	addi $t2 $0 1	# t2 = 1 (i = 1)
	
loop:
	add $t1 $t1 $t2	# t1 = t1 + t2
	beq $t2 $t0 exit	# If t2 == t0 then jump to exit
	addi $t2 $t2 1	# t2 = t2 + 1
	j loop
exit:
	li $v0 1		# Print sum
	move $a0 $t1	# a0 = t1 (sum)
	syscall
	
	li $v0 10	# Terminate program
	syscall
	