.data
arr1: .space 40
asize: .word 10
arr2: .word 1, 3, 5, 7, 9
space: .asciiz " "

.text
main:
	li $t0 0		# t0 = 0
	lw $t1 asize		# t1 = size of array
	la $s0 arr1		# a1 = address of arr1
	#li $t2 1		# t2 = 1
	
loop_1:
	li $v0 42	# Generate random number
	li $a1 100	# Set upper bound to 100
	syscall
	
	move $t2 $a0		# t2 = a0 (random number)
	
	sw $t2 0($s0)	# Save register value to index 0 in a1 (array)
	addi $t0 $t0 1	# t0 = t0 + 1
	beq $t0 $t1 cont_1	# If t0 == t1 jump to done
	addi $s0 $s0 4	# a1 = a1 + 4
	#addi $t2 $t2 1	# t2 = t2 + 1
	j loop_1		# Jump to loop
	
cont_1:
	li $t0 0
	la $s1 arr1
display_Arr:
	lw $a0 0($s1)	# load int from array
	li $v0 1
	syscall
	
	li $v0 4		# Print space between integers
	la $a0 space
	syscall
	
	addi $t0 $t0 1
	beq $t0 $t1 cont_2
	addi $s1 $s1 4
	j display_Arr

cont_2:
	li $t0 0	# t0 is my counter
	li $t1 0	# t1 is my sum
	la $s0 arr1	# load address of arr1 into s0
find_Average:
	

exit:
	li $v0 10
	syscall
	
