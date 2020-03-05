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
arr: .space 48			# arr with size of 12 (4 bytes per cell)
arrSize: .word 12
spce: .asciiz " "
newLine: .asciiz "\n"
.text
main:
	la $a0 arr			# Load the address of the array into a0
	lw $a1 arrSize		# Load size of array into a1
	sub $sp $sp 4		# Make space in stack pointer
	jal funct_fill_Arr		# Call function
	addi $sp $sp 4
	la $a0 arr
	lw $a1 arrSize
	jal funct_Display_Arr
	

terminate:
	li $v0 10		# Exit program
	syscall
	
funct_Compute_Avg_Arr:	# a0 = array, a1 = size of array
	move $s0 $a0		# s0 = a0
	move $s1 $a1		# s1 = a1
	li $t0 0		# t0 = 0
	
avg_Arr_Loop:
	beq $t0 $s1 compute_Avg_Arr_Done
	lw $t1 0($s0)
	addi $s0 $s0 4	# Move to next cell in the array
	
compute_Avg_Arr_Done:
	jr $ra

funct_fill_Arr:
	sw $ra 0($sp)	# Save return address to stack pointer
	move $s0 $a0
	move $s1 $a1
	li $t0 0		# t0 = 0 (counter)
	
fill_Arr_Loop:
	beq $t0 $s1 fill_Arr_Done	# If t0 == arrSize then end loop
	jal funct_Emit_Int	# Generate random integer
	move $t1 $v0		# Move return value to t1
	sw $t1 0($s0)	# Store int into the array
	addi $t0 $t0 1	# Increment t0 by 1
	addi $s0 $s0 4	# Move to next cell in the array
	j fill_Arr_Loop

fill_Arr_Done:
	lw $ra 0($sp)	# Load return address from stack pointer
	jr $ra			# Jump back to caller

funct_Emit_Int:		# Generates a int in range [0, 101) = [0, 100]
	li $v0 42
	li $a1 101		# Set upper bound
	syscall
	move $v0 $a0		# Move generated number to v0	
	jr $ra			# Return to caller

funct_Display_Arr:		# Displays the array 5 elements per line 
				# (a0 = array, a1 = size of array)
	move $s0 $a0		# Movement argument to s0
	move $s1 $a1		# Move a1 to s1 (size of array)
	li $t0 0		# t0 = 0 (counter)
	li $t1 0		# t1 = 0 (line counter)

display_Arr_Loop:
	beq $t0 $s1 display_Arr_Done	# If t0 == arrSize, jump to exit
	lw $t2 0($s0)			# Read integer from array	
	prntInt($t2)				# Print intger

	addi $t0 $t0 1		# t0 = t0 + 1 (increment counter)
	addi $t1 $t1 1		# t1 = t1 + 1 (increment 
	addi $s0 $s0 4		# Move to next cell
	
	beq $t1 5 resetLnCt	# If t1 == 5, then t2 = 0 and print new line
	prntStr(spce)		# Print space
	j display_Arr_Loop
resetLnCt:
	li $t1 0			# Reset t2 = 0
	prntStr(newLine)	# Print new line
	j display_Arr_Loop
display_Arr_Done:
	jr $ra
