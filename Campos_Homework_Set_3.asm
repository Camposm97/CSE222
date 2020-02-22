.data
strMessage: .asciiz "I am a college student at SCCC"
strPrmptInt: .asciiz "Please enter an integer: "
strYouEntered: .asciiz "You entered: "
strBothEven: .asciiz "Both numbers are even."
strBothOdd: .asciiz "Both numbers are odd."
strOddAndEven: .asciiz "One number is odd and one is even."
strIsMultOf4: .asciiz "The number you entered is a multiple of 4!"
strIsNotMultOf4: .asciiz "The number you entered is NOT a multiple of 4!"
newLn: .asciiz "\n"
var1: .word 32	# Not sure why I have to set a number after .word
var2: .word 10	# For comparison
var3: .word 33	# For comparison

.text
main:	# Question 1 (1)
	li $v0, 4	# Print strMessage
	la $a0, strMessage
	syscall
	
	li $v0, 4	# Print new line
	la $a0, newLn
	syscall
	
	# Question 1 (2)
	li $v0, 4	# Print strPrmptInt
	la $a0, strPrmptInt
	syscall

	li $v0, 5	# Read integer
	syscall
	
	sw $v0, var1	# Store entered integer in var1
	
	li $v0, 4	# Print strYouEntered
	la $a0, strYouEntered
	syscall
	
	li $v0, 1	# Print var1
	lw $a0, var1
	syscall
	
	li $v0, 4	# Print new line
	la $a0, newLn
	syscall
	
	
	
	# Question 2
	lw $t2, var2		# t2 = var2
	lw $t3, var3		# t3 = var3
	slt $t1, $t2, $t3	# t1 = 1 if t2 < t3 else t1 = 0
	
	# If t1 == 0, jump to prnt_Var3_Then_Var2
	beqz $t1, prnt_Var3_Then_Var2
	j prnt_Var2_Then_Var3
	
prnt_Var2_Then_Var3:
	li $v0, 1	# Print value of var2 (t2)
	move $a0, $t2
	syscall

	li $v0, 4	# Print new line
	la $a0, newLn
	syscall
	
	li $v0, 1	# Print value of var3 (t3)
	move $a0, $t3
	syscall

	li $v0, 4	# Print new line
	la $a0, newLn
	syscall
	
	j cont_Program_1

prnt_Var3_Then_Var2:
	li $v0, 1	# Print value of var3 (t3)
	move $a0, $t3
	syscall

	li $v0, 4	# Print new line
	la $a0, newLn
	syscall

	li $v0, 1	# Print value of var2 (t2)
	move $a0, $t2
	syscall
	
	li $v0, 4	# Print new line
	la $a0, newLn
	syscall

	j cont_Program_1

cont_Program_1:
	li $v0, 4
	la $a0, newLn
	syscall
	
	# Question 3
	jal ask_For_Int
	move $s0, $v0	# Move entered integer into s0

	jal ask_For_Int
	move $s1, $v0	# Move entered integer into s1
	
	move $a0, $s0	# Move s0 value to argument
	jal is_Int_Even
	move $t0, $v0	# Move return value to t0
	
	move $a0, $s1	# Move s1 value to argument
	jal is_Int_Even
	move $t1, $v0	# Move return value to t1
	
	# If t0 == t1 then t3 = 1 (both are even or odd) 
	# else t3 = 0 (one is odd and even)
	seq $t3, $t0, $t1
	beqz $t3, prnt_Nums_Odd_And_Even
	
	# If t3 == 0 then both are odd
	beqz $t0, prnt_Nums_Both_Odd
	j prnt_Nums_Both_Even # Else, both are even
	
prnt_Nums_Both_Odd:
	li $v0, 4
	la $a0, strBothOdd
	syscall
	
	li $v0, 4	# Print new line
	la $a0, newLn
	syscall
	
	j cont_Program_2

prnt_Nums_Both_Even:
	li $v0, 4
	la $a0, strBothEven
	syscall
	
	li $v0, 4	# Print new line
	la $a0, newLn
	syscall
	
	j cont_Program_2
	
prnt_Nums_Odd_And_Even:
	li $v0, 4
	la $a0, strOddAndEven
	syscall
	
	li $v0, 4	# Print new line
	la $a0, newLn
	syscall
	
	j cont_Program_2
	
cont_Program_2:
	li $v0, 4	# Print new line
	la $a0, newLn
	syscall
	
	# Question 4
	# How would I check my computer if big or little endian?
	
	# Question 5
	jal ask_For_Int
	move $a0, $v0	# move value of v0 to a0
	jal is_Mult_Of_Four
	move $a0, $v0	# move value of v0 to a0
	jal display_Result_If_Mult_Of_4
	
terminate:
	li $v0, 10	# Terminate Program
	syscall

ask_For_Int:
	li $v0, 4	# Ask for integer input
	la $a0, strPrmptInt
	syscall

	li $v0, 5	# Read integer
	syscall
	
	# Entered integer is already stored in v0
	jr $ra

is_Int_Even:
	# Take the arugment register and shift it right and left once
	# and store the result in a temp register for comparison.
	# Compare the arg. and temp. reg to each other and store in return register.
	srl $v0, $a0, 1	# v0 = a0 >> 1
	sll $v0, $v0, 1	# v0 = v0 << 1
	seq $v0, $a0, $v0	# If a0 == v0 then v0 = 1
	jr $ra

is_Mult_Of_Four:
	# Use AND to see if argument is a multiple of four
	# If v0 equals 0, then the arugment is a mutiple of four
	# Else, the argument is NOT a multiple of four
	and $v0, $a0, 3
	jr $ra
	
display_Result_If_Mult_Of_4:
	move $t0, $a0	# move value of argument to t0
	beqz $t0, prnt_Is_Mult_Of_4
	j prnt_Is_Not_Mult_Of_4
prnt_Is_Mult_Of_4:
	li $v0, 4
	la $a0, strIsMultOf4
	syscall
	j display_Result_If_Mult_Of_4_Return
prnt_Is_Not_Mult_Of_4:
	li $v0, 4
	la $a0, strIsNotMultOf4
	syscall
	j display_Result_If_Mult_Of_4_Return
display_Result_If_Mult_Of_4_Return:
	jr $ra