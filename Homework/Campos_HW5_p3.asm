.macro prntStr(%str)
	li $v0 4
	la $a0 %str
	syscall
.end_macro
.data
promptPosInt: .asciiz "Please enter a positive integer: "
youEntered: .asciiz "You entered: "
newLine: .asciiz "\n"
sumIs: .asciiz "The sum is: "
.text
main:
	prntStr(promptPosInt)
	li $v0 5			# Prompt integer
	syscall
	
	move $s7 $v0		# Move entered integer to s7
	move $a0 $s7		# a0 = s7
	jal funct_Is_Pos_Int
	move $t0 $v0		# Move result to t0
	beqz $t0 main		# If t0 == 0, then jump to main
	
	prntStr(youEntered)	# Print string
	li $v0 1			# Print entered integer
	move $a0 $s7
	syscall
	prntStr(newLine)		# Print new line
	
	move $a0 $s7
	jal funct_Compute_Sum
	move $t0 $v0		# t0 = sum
	prntStr(sumIs)
	li $v0 1
	move $a0 $t0
	syscall
	prntStr(newLine)
	

terminate:
	li $v0 10
	syscall
	
funct_Is_Pos_Int:	# Takes one argument
	sgt $t0 $a0 0	# If a0 > 0, then t0 == 1
	move $v0 $t0	# Move result to t0
	jr $ra
	
funct_Compute_Sum:	# Takes one argument
	move $s0 $a0	# Move a0 to s0
	li $s1 0		# Set s1 = 0 (sum)
	li $t0 1		# Set t0 = 1 (counter)
	
sum_Loop:
	add $s1 $s1 $t0		# sum = sum + t0
	addi $t0 $t0 1		# Increment counter
	bge $s0 $t0 sum_Loop	# If s0 > t0, jump to sum_Loop
	move $v0 $s1		# v0 = sum
	jr $ra
