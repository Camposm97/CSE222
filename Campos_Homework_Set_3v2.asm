.macro prnt(%str)
	li $v0 4
	la $a0 %str
	syscall
.end_macro
.macro prntln(%str)
	prnt(%str)
	prnt(newLine)
.end_macro
.macro print(%str)
	.data
	str: .asciiz %str
	.text
	prnt(str)
.end_macro
.macro println(%str)
	.data
	str: .asciiz %str
	.text
	prntln(str)
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
	jal displayQuestion3
	
	# Question 4
	# Look up how to check if computer is big or little endian
	
	# Question 5
	jal askForInt
	move $a0, $v0	# Move return value to a0
	jal isMultOfFour
	move $a0, $v0	# Move return value to a0
	jal displayResultIfMultOf4	

terminate:
	li $v0 10
	syscall

askForInt:	# No arugmented needed
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
	prntln(newLine)
	jr $ra

isEvenInt:	# Takes one argument (a0)
	srl $t9, $a0, 1	# t9 = a0 >> 1
	sll $t9, $t9, 1	# t9 = t9 << 1
	seq $v0, $a0, $t9	# If a0 == t0 then v0 = 1
	jr $ra
	
displayQuestion3:
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
	j displayQuestion3Return
	
prntNumsBothEven:
	println("Both numbers are even.")
	j displayQuestion3Return
	
prntNumsOneOddAndEven:
	println("One number is odd and one is even.")
	j displayQuestion3Return
	
displayQuestion3Return:
	lw $ra 0($sp)
	jr $ra
	
isMultOfFour:
	# Use AND to see if argument is a multiple of four
	# If v0 equals 0, then the arugment is a mutiple of four
	# Else, the argument is NOT a multiple of four
	and $v0, $a0, 3
	jr $ra
	
displayResultIfMultOf4:
	move $t0, $a0	# move value of argument to t0
	beqz $t0, prntIsMultOf4
	j prntIsNotMultOf4
prntIsMultOf4:
	li $v0, 4
	la $a0, strIsMultOf4
	syscall
	j displayResultIf_Mult_Of_4_Return
prntIsNotMultOf4:
	li $v0, 4
	la $a0, strIsNotMultOf4
	syscall
	j displayResultIfMultOf4Return
displayResultIfMultOf4Return:
	jr $ra
