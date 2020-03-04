.macro prntStr(%str)
	li $v0 4
	la $a0 %str
	syscall
.end_macro
.macro prntInt(%n)
	li $v0 1
	move $a0 %n
	syscall
.end_macro
.data
arr: .space 48	# arr with size of 12 (4 bytes per cell)
arrSize: .word 12
spce: .asciiz " "
newLine: .asciiz "\n"
.text
main:
	la $s0 arr		# Load the address of the array into s0
	lw $s1 arrSize	# Load size of array into s1
	sub $sp $sp 4	# Make space in stack pointer
	jal fill_Arr		# Call function
	addi $sp $sp 4	
	la $s0 arr		# Re-load the address of the array
	li $t0 0		# t0 = 0	(counter)
	li $t2 0		# t2 = 0	(line counter)
	
display_Arr:			# Display array
	beq $t0 $s1 exit	# If t0 == arrSize, jump to exit
	lw $t1 0($s0)	# Read integer from array	
	prntInt($t1)		# Print intger

	addi $t0 $t0 1	# t0 = t0 + 1
	addi $t2 $t2 1	# t1 = t1 + 1
	addi $s0 $s0	 4	# Move to next cell
	
	beq $t2 5 resetLnCount	# If t2 == 5, then t2 = 0 and print new line
	prntStr(spce)		# Print space
	j display_Arr
resetLnCount:
	li $t2 0			# Reset t2 = 0
	prntStr(newLine)		# Print new line
	j display_Arr

exit:
	li $v0 10	# Exit program
	syscall

fill_Arr:
	sw $ra 0($sp)	# Save return address to stack pointer
	li $t0 0		# t0 = 0 (counter)
	
fill_Arr_Loop:
	beq $t0 $s1 fill_Arr_Done	# If t0 == arrSize then end loop
	jal emit_Int		# Generate random integer
	move $t1 $v0		# Move return value to t1
	sw $t1 0($s0)	# Store int into the array
	addi $t0 $t0 1	# Increment t0 by 1
	addi $s0 $s0 4	# Move to next cell in the array
	j fill_Arr_Loop

fill_Arr_Done:
	lw $ra 0($sp)	# Load return address from stack pointer
	jr $ra			# Jump back to caller

emit_Int:			# Generates a int in range [0, 101)
	li $v0 42
	li $a1 101		# Set upper bound
	syscall
	move $v0 $a0		# Move generated number to v0	
	jr $ra
