.macro prmptInt()
	li $v0 5
	syscall
.end_macro
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
arr: .space 40
arrSize: .word 10
prmptLower: .asciiz "Please set the lower bound: "
prmptUpper: .asciiz "Please set the upper bound: "
space: .asciiz " "
newLine: .asciiz "\n"
.text
main:
	prntStr(prmptLower)	# Ask user to set lower bound
	prmptInt()
	move $a2 $v0		# a2 = lower bound
	prntStr(prmptUpper)	# Ask user to set upper bound
	prmptInt()
	move $a3 $v0		# a3 = upper bound
	
	la $a0 arr			# a0 = arr
	lw $a1 arrSize		# a1 = size of array
	jal funct_Fill_Arr	# Fill array with odd numbers
	
	la $a0 arr			# a0 = arr
	lw $a1 arrSize		# a1 = size of array
	jal funct_Display_Arr	# Display array

terminate:
	li $v0 10
	syscall

# (a0 = array, a1 = size of array)
funct_Display_Arr:	# Displays the array on one line
	move $s0 $a0	# Movement argument to s0
	move $s1 $a1	# Move a1 to s1 (size of array)
	li $t0 0		# t0 = 0 (counter)
	
display_Arr_Loop:
	lw $t1 0($s0)	# t1 = integer from array
	prntInt($t1)
	prntStr(space)
	addi $t0 $t0 1
	addi $s0 $s0 4
	bne $t0 $s1 display_Arr_Loop
	prntStr(newLine)
	jr $ra

# Takes 4 args:
# a0 = array, a1 = size of array
# a2 = lower bound, a3 = upper bound
funct_Fill_Arr:	
	sub $sp $sp 4	# Make room in stack pointer
	sw $ra 0($sp)	# Save return address to stack pointer
	move $s0 $a0	# s0 = address of array
	move $s1 $a1	# s1 = size of array
	li $s2 0 		# s2 = 0 (counter)
fill_Arr_Loop:
	move $a0 $a2
	move $a1 $a3
	jal funct_Emit_Odd_Int
	move $s3 $v0			# Move odd number to s3
	sw $s3 0($s0)	
	addi $s2 $s2 1			# Increment counter
	addi $s0 $s0 4			# Move to next cell
	bgt $s1 $s2 fill_Arr_Loop	# If s1 > s2 then jump to loop
	lw $ra 0($sp)
	addi $sp $sp 4
	jr $ra

# a0 = lower bound, a1 = upper bound
# If the random number is not odd then we keep
# generating a new number until we get one.  
funct_Emit_Odd_Int:	# Takes in two parameters (a0, a1)
	move $t0 $a0	# Move lower bound to t0
	sub $sp $sp 4	# Make space in stack
	sw $ra 0($sp)	# Save return address in stack
emit_Int_Loop:
	li $v0 42			# Generate a number
	syscall
	add $a0 $a0 $t0		# Add lower bound
	jal funct_Is_Odd		# Check if number is odd
	beqz $v0 emit_Int_Loop	# If v0 == 0 (is even), then generate a new number
					
	lw $ra 0($sp)		# Load return address
	addi $sp $sp 4		# Restore stack pointer 
	move $v0 $a0		# v0 = generated odd number
	jr $ra

# Checks if a0 is odd
# Returns 1 if a0 is odd
# Returns 0 if a0 is even
funct_Is_Odd:		# Takes one argument: a0 (int)
	move $t8 $a0	# t8 = a0
	sub $sp $sp 4	# Make room in stack pointer
	sw $ra 0($sp)	# Save return address
	srl $t9 $t8 1	# t9 = a0 >> 1
	sll $t9 $t9 1	# t9 = t9 << 1
	sne $v0 $t9 $t8	# If t9 != a0, v0 = 1 (is odd)
	lw $ra 0($sp)	# Load return address
	addi $sp $sp 4	# Restore stack pointer
	jr $ra