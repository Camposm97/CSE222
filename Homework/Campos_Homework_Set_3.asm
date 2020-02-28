.macro prntStr(%str)
	li $v0 4
	la $a0 %str
	syscall
.end_macro
.macro prntlnStr(%str)
	prntStr(%str)
	prntStr(newLine)
.end_macro
.macro print(%str)
	.data
	str: .asciiz %str
	.text
	prntStr(str)
.end_macro
.macro println(%str)
	.data
	str: .asciiz %str
	.text
	prntlnStr(str)
.end_macro
.macro prntInt()
	li $v0 1
	syscall
.end_macro

.data
newLine: .asciiz "\n"
var1: .word 32
var2: .word 34
var3: .word 43

.text
main:
	# Question 1 (1)
	println("I am a college student at SCCC")
	
	# Question 1 (2)
	jal askForInt
	sw $v0 var1
	
	# Question 2
	lw $a0 var2
	lw $a1 var3
	jal compareTwoInts
	
	# Question 3
	jal showQuestion3
	addi $sp $sp 4
	
	# Question 4
	# On my computer when I print var1 it is displayed as big endian.  
	li $v0 34
	lw $a0 var1
	syscall
	
	prntStr(newLine)
	
	# Question 5
	jal askForInt		# Ask user for integer
	move $a0, $v0		# Move return value to a0
	jal isMultOfFour		# Check if integer is a multiple of four
	move $a0, $v0		# Move return value to a0
	jal showResultIfMultOf4	# Print results	

terminate:
	li $v0 10
	syscall

askForInt:	# No argument needed
	print("Please enter an integer: ")
	li $v0 5
	syscall
	jr $ra
	
compareTwoInts:	# Two arguments needed
	slt $t0 $a0 $a1
	beqz $t0 prntWay2
	j prntWay1
	
prntWay1:	# Print a0 then a1
	prntInt()
	print(", ")
	move $a0 $a1
	prntInt()
	j compareTwoIntsReturn
	
prntWay2:	# Print a1 then a0
	move $t0 $a0
	move $a0 $a1
	prntInt()
	print(", ")
	move $a0 $t0
	prntInt()
	j compareTwoIntsReturn

compareTwoIntsReturn:
	prntStr(newLine)
	jr $ra

isEvenInt:	# Takes one argument (a0)
	srl $t9, $a0, 1	# t9 = a0 >> 1
	sll $t9, $t9, 1	# t9 = t9 << 1
	seq $v0, $a0, $t9	# If a0 == t0 then v0 = 1
	jr $ra
	
showQuestion3:	# ANSWER FOR QUESTION #3 BEGINS HERE
	sub $sp $sp 4
	sw $ra 0($sp)
	
	jal askForInt
	move $t0 $v0 # Move return value to t0
	jal askForInt
	move $t1 $v0 # Move return value to t1
	
	move $a0 $t0 # Move temp value to a0
	jal isEvenInt
	move $t0 $v0 # Move return value to t0
	move $a0 $t1 # Move temp value to a0
	jal isEvenInt
	move $t1 $v0 # Move return value to t1
	
	seq $t2 $t0 $t1			# If t0 == t1, then t2 = 1
	beqz $t2 prntNumsOneOddAndEven	# If t2 == 0 then nums is odd and even
	beqz $t0 prntNumsBothOdd		# If t0 == 0 then both nums are odd
	j prntNumsBothEven				# Else both nums are even
	
prntNumsBothOdd:
	println("Both numbers are odd.")
	j showQuestion3Return
	
prntNumsBothEven:
	println("Both numbers are even.")
	j showQuestion3Return
	
prntNumsOneOddAndEven:
	println("One number is odd and one is even.")
	j showQuestion3Return
	
showQuestion3Return:	
	lw $ra 0($sp)
	jr $ra			# ANSWER FOR QUESTION #3 ENDS HERE
	
isMultOfFour:
	# Use AND to see if argument is a multiple of four
	# If v0 equals 0, then the arugment is a mutiple of four
	# Else, the argument is NOT a multiple of four
	and $v0, $a0, 3
	jr $ra
	
showResultIfMultOf4:
	move $t0, $a0	# Move value of argument to t0
	beqz $t0, prntIsMultOf4
	j prntIsNotMultOf4
prntIsMultOf4:
	println("The number you entered is a multiple of 4!")
	j showResultIfMultOf4Return
prntIsNotMultOf4:
	println("The number you entered is NOT a multiple of 4!")
	j showResultIfMultOf4Return
showResultIfMultOf4Return:
	jr $ra
