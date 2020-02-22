.data
strMessage: .asciiz "I am a college student at SCCC"
newLn: .asciiz "\n"
prmptInt: .asciiz "Please enter an integer: "
strProcessNums: .asciiz "Processing entered integers if odd or even..."
var1: .word 32	# Not sure why I have to set a number after .word
var2: .word 7	# For comparison
var3: .word 2	# For comparison

.text
main:	# Question 1 (1)
	li $v0, 4	# Print strMessage
	la $a0, strMessage
	syscall
	
	li $v0, 4	# Print new line
	la $a0, newLn
	syscall

	# Question 1 (1)
	li $v0, 4	# Print prmptInt
	la $a0, prmptInt
	syscall

	li $v0, 5	# Read integer
	syscall
	
	sw $v0, var1	# Store entered integer in var1
	
	li $v0, 4	# Print new line
	la $a0, newLn
	syscall

	#li $v0, 1	# Print var1
	#lw $a0, var1
	#syscall

	# Question 2
	lw $t2, var2		# t2 = var2
	lw $t3, var3		# t3 = var3
	slt $t1, $t2, $t3	# t1 = 1 if t2 < t3 else t1 = 0
	
	# If t1 != 0, jump to display_Var2_Then_Var3
	bne $t1, $zero, display_Var2_Then_Var3
	
display_Var2_Then_Var3:
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
	
	j continue_Program_1

display_Var3_Then_Var2:
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

	j continue_Program_1

continue_Program_1:
	# Question 3
	li $v0, 4	# Ask for integer input
	la $a0, prmptInt
	syscall

	li $v0, 5	# Read integer
	syscall
	
	move $s0, $v0	# Move entered integer into s0
	
	#li $v0, 4	# Print new line
	#la $a0, newLn
	#syscall

	li $v0, 4	# Ask for integer input
	la $a0, prmptInt
	syscall
	
	li $v0 5	# Read integer
	syscall
	
	move $s1, $v0	# Move entered integer into s1

	#li $v0, 4	# Print new line
	#la $a0, newLn
	#syscall

question_3:
	li $v0, 4	# Print processing numbers message
	la $a0, strProcessNums
	syscall
	
	# Determine if s0 is odd or even
	#srl $t0, $s0, 1	# t0 = s0 >> 1
	#sll $t0, $t0, 1	# t0 = t0 << 1
	
	#seq $t0, $s0, $t0	# t0 = 1 if s0 == t0
	#beq $t0, 1, printIntIsEven
	
	li $v0, 4	# Print new line
	la $a0, newLn
	syscall
	
	#li $v0, 1	# Print integer in t0
	#move $a0, $t0
	#syscall
	
	
done:
	# Terminate Program
	li $v0, 10
	syscall

is_Integer_Even:
	# Take the arugment register and shift it right and left once
	# and store the result in a temp register for comparison.
	# Compare the arg. and temp. reg to each other and store in return register.
	srl $v0, $a0, 1
	sll $v0, $v0, 1
	seq $v0, $a0, $v0
	jr $ra