.data
arr1: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
arr2: .space 40
size: .word 10
tab: .asciiz "\t"
.text
main:
	la $s0 arr1		# s0 = address of arr1
	la $s1 arr2		# s1 = address of arr2
	addi $s0 $s0 36	# Set s0 to the last cell (address) of the array
	lw $s2 size		# s2 = size
	li $t1 0		# Set t1 = 0
	
loop_Reverse:
	beq $t0 $s2 contProgram	# If t0 == 0, then jump to done
	lw $t1 0($s0)		# Load number from array
	sw $t1 0($s1)		# Save number to array2
	
	addi $t0 $t0 1		# Increment i
	sub $s0 $s0 4		# Move to next cell (backwards)
	addi $s1 $s1 4		# Move to next cell (forwards)
	j loop_Reverse

contProgram:
	la $a0 arr2
	lw $a1 size
	jal functDisplayArr
done:
	li $v0 10
	syscall
	
# Takes in 3 arguments (parameters) where
# a0 = arr1 (the array that we're going to reverse)
# a1 = arr2 (the array we're going to store the numbers in reverse from arr1)
# a2 = size (the size of the array)
functReverseArr:
	
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
