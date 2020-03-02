.data
array: .space 52	# array with size of 12 (4 bytes per cell)
comma: .ascii ", "
.text
main:
	sub $sp $sp 4
	jal fill_Arr
	addi $sp $sp 4
	li $t0 0
	loop:
		beq. $t0 48 terminate
		lw $t1 array($t0)
		
		li $v0 1		# Print integer
		move $a0 $t1
		syscall
		
		li $v0 4		# Print comma
		la $a0 comma
		syscall
		
		addi $t0 $t0 4
	j loop

terminate:
	li $v0 10	# Exit program
	syscall

fill_Arr:
	sw $ra 0($sp)	# Save return address to stack pointer
	li $t0 0		# t0 = 0
	fill_Arr_Loop:
		beq $t0 48 fill_Arr_Done	# If t0 > 48 then end loop
		jal emit_Int	# Generate random integer
		move $t1 $v0	# Move return value to t1
		sw $t1 array($t0)	# Store int to arr at index t0
		addi $t0 $t0 4	# Increment t0 by 4
	j fill_Arr_Loop

fill_Arr_Done:
	lw $ra 0($sp)
	jr $ra

emit_Int:			# Generates a int in range [0, 101)
	#sw $ra 4($sp)
	
	li $v0 42
	li $a1 101		# Set upper bound
	syscall
	move $v0 $a0	# Move generated number to v0
	
	#lw $ra 4($sp)
	jr $ra
