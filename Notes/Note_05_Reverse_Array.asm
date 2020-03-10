.data
arr1: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
arr2: .space 40
size: .word 10
tab: .asciiz "\t"
comma: .asciiz ", "
.text
main:
	la $a0 arr1
	la $a1 arr2
	lw $a2 size
	jal functReverseArr
	
	la $a0 arr2
	lw $a1 size
	jal functDisplayArrWithCommas
done:
	li $v0 10
	syscall
	
# Takes in 3 arguments (parameters) where
# a0 = arr1 (the array that we're going to reverse)
# a1 = arr2 (the array we're going to store the numbers in reverse from arr1)
# a2 = size (the size of the array. Size of the arrays should be equal)
functReverseArr:
	move $s0 $a0	# s0 = arr1
	move $s1 $a1	# s1 = arr2
	move $s2 $a2	# s2 = size
	li $t0 0		# Set t0 = 0 (counter)
	addi $s0 $s0 36	# Move to the last cell of the arr1
reverseArrLoop:
	beq $t0 $s2 reverseArrDone
	lw $t1 0($s0)	# Load integer from arr1
	sw $t1 0($s1)	# Save integer to arr2
	addi $t0 $t0 1	# Increment i
	sub $s0 $s0 4	# Move to the next cell in arr1 (right to left)
	addi $s1 $s1 4	# Move to the next cell in arr2 (left to right)
	j reverseArrLoop
reverseArrDone:
	jr $ra

# This function takes in 2 arguments:
# a0 = array
# a1 = size of the array
functDisplayArr:
	move $s0 $a0		# s0 = address of array
	move $s1 $a1		# s1 = size of array
	li $t0 0			# Set t0 = 0 (counter)
loopDisplay:
	beq $t0 $s1 displayArrDone
	lw $a0 0($s0)
	
	li $v0 1
	syscall
	
	li $v0 4
	la $a0 tab
	syscall
	
	addi $t0 $t0 1
	addi $s0 $s0 4
	j loopDisplay
displayArrDone:
	jr $ra

# This functions takes in 2 arguments
# a0 = array
# a1 = size of the array
functDisplayArrWithCommas:
	move $s0 $a0
	move $s1 $a1
	li $t0 0		# Set t0 = 0 (counter)
	addi $t1 $s1 -1	# t1 = size of array - 1
commaLoop:
	beq $t0 $s1 commaLoopDone	
	lw $a0 0($s0)	# Load integer from array into a0
	li $v0 1		# Print integer
	syscall
	beq $t0 $t1 skipComma	# If t0 == arr.length - 1 then skip the comma
prntComma:
	li $v0 4		# Print comma
	la $a0 comma
	syscall	
skipComma:
	addi $t0 $t0 1	# Increment i
	addi $s0 $s0 4	# Move to next cell of the array
	j commaLoop
commaLoopDone:
	jr $ra