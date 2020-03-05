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
msg_Average: .asciiz "The average of the array is "
msg_Max: .asciiz "The max integer in the array is "
msg_Min: .asciiz "The min integer in the array is "
.text
main:
	# Load arguments for filling the array function
	la $a0 arr				# Load the address of the array into a0
	lw $a1 arrSize			# Load size of array into a1
	jal funct_fill_Arr			# Fill the array with random numbers
	
	# Load arguments for display array function
	la $a0 arr
	lw $a1 arrSize
	jal funct_Display_Arr		# Display the array 5 elements per line
	prntStr(newLine)			# Print new line
	
	# Load arguments for finding the max integer function
	la $a0 arr
	lw $a1 arrSize
	jal funct_Find_Max_Int		# Find max integer in the array
	move $t0 $v0				# Move result to t0
	prntStr(msg_Max)			# Print message
	prntInt($t0)				# Print max integer
	prntStr(newLine)			# Print new line
	
	# Load arguments for finding the min integer function
	la $a0 arr
	lw $a1 arrSize
	jal funct_Find_Min_Int
	move $t0 $v0				# Move result t0
	prntStr(msg_Min)
	prntInt($t0)
	prntStr(newLine)
	
	# Load arguments for computing the average in the array function
	la $a0 arr
	lw $a1 arrSize
	jal funct_Compute_Arr_Avg	# Compute average of the array
	move $t0 $v0 			# Move result to t0
	prntStr(msg_Average)		# Print message
	prntInt($t0)				# Print average
	prntStr(newLine)			# Print new line
	
terminate:
	li $v0 10				# Exit program
	syscall
	
funct_Find_Max_Int:
	move $s0 $a0		# s0 = address of array
	move $s1 $a1		# s1 = size of array
	li $t0 1		# t0 = 1 (counter)
	lw $t1 0($s0)	# Read first element in the array (max)
	addi $s0 $s0 4	# Move to next cell of the array
max_Loop:
	beq $t0 $s1 funct_Find_Max_Int_Done
	lw $t2 0($s0)			# Read integer from the array
	addi $t0 $t0 1			# Increment counter
	addi $s0 $s0 4			# Move to nex cell of the array
	bgt $t2 $t1 update_Max		# If t2 > t1 (current max) then update
	j max_Loop	
update_Max:
	move $t1 $t2				# t1 = t2 Store current element in t1
	j max_Loop
funct_Find_Max_Int_Done:
	move $v0 $t1		# Move max element to return value
	jr $ra			# Return to caller
	
funct_Find_Min_Int:
	move $s0 $a0
	move $s1 $a1
	li $t0 1		# t0 = 1 (counter)
	lw $t1 0($s0)	# Read first element in the array (min)
	addi $s0 $s0 4	# Move to next cell of the array
min_Loop:
	beq $t0 $s1 funct_Find_Min_Int_Done
	lw $t2 0($s0)			# Read integer from the array
	addi $t0 $t0 1			# Increment counter
	addi $s0 $s0 4			# Move to nex cell of the array
	blt $t2 $t1 update_Min		# If t2 < t1 (current min) then update
	j min_Loop	
update_Min:
	move $t1 $t2				# t1 = t2 Store current element in t1
	j min_Loop
funct_Find_Min_Int_Done:
	move $v0 $t1		# Move min element to return value
	jr $ra			# Return to caller
	
funct_Compute_Arr_Avg:	# a0 = array, a1 = size of array
	move $s0 $a0		# s0 = a0
	move $s1 $a1		# s1 = a1
	li $t0 0		# t0 = 0
	li $t2 0		# t2 = 0 (sum of array)
	
arr_Avg_Loop:
	beq $t0 $s1 compute_Arr_Avg_Done
	lw $t1 0($s0)	# Read integer in current cell of the array
	add $t2 $t2 $t1	# t2 = t2 + t1
	addi $t0 $t0 1	# Increment counter
	addi $s0 $s0 4	# Move to next cell in the array
	j arr_Avg_Loop
	
compute_Arr_Avg_Done:
	div $t2 $s1		# Divide sum of array by size of array
	mflo $v0		# Load quotient into v0
	jr $ra			# Jump to caller

funct_fill_Arr:
	sub $sp $sp 4	# Make space in stack pointer
	sw $ra 0($sp)	# Save return address to stack pointer
	move $s0 $a0		# Move address of array to s0
	move $s1 $a1		# Move size of array to s1
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
	addi $sp $sp 4	# Recover stack pointer
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
	prntStr(newLine)		# Print new line
	j display_Arr_Loop
display_Arr_Done:
	jr $ra
