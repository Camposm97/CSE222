.data
arr1: .space 40
asize: .word 10
arr2: .word 1, 3, 5, 7, 9
space: .asciiz " "
newLine: .asciiz "\n"
msg_sum: .asciiz "The sum of the array is "
msg_avg: .asciiz "The average of the array is "

.text
main:
	li $t0 0		# t0 = 0
	lw $t1 asize		# t1 = size of array
	la $s0 arr1		# a1 = address of arr1
	#li $t2 1		# t2 = 1
	
loop_1:
	li $v0 42	# Generate random number
	li $a1 10	# Set upper bound to 10
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
	lw $s1 asize	# load size of array into s1
find_Sum:
	lw $t2 0($s0)	# load integer from array
	add $t1 $t1 $t2	# t2 = t2 + t1 (sum array)
	addi $t0 $t0 1	# t0 = t0 + 1
	beq $t0 $s1 cont_3	# If t0 == s1 jump out of loop
	addi $s0 $s0 4	# move to next cell in array
	j find_Sum
cont_3:
	li $v0 4	# Print new line
	la $a0 newLine
	syscall
	
	li $v0 4	# Print sum message
	la $a0 msg_sum
	syscall
	
	li $v0 1	# Print sum of array
	move $a0 $t1	
	syscall
	
	li $v0 4	# Print new line
	la $a0 newLine
	syscall

display_Average:
	li $v0 4		# Print average message
	la $a0 msg_avg
	syscall
	
	div $t1 $s1		# Divide sum of array by size of array

	mflo $t0		# Move result (32 bits before decimal) to t0
	
	li $v0 1	# Print average
	move $a0 $t0
	syscall

question_3_part_1:
	li $t0 0		# t0 = 0
	lw $s0 asize		# s0 = size of array
	la $s1 arr1		# load address of arr1 into s1
	li $t1 0($s1)	# t1 is my max number
	
find_Max_Int:
	beq $t0 $s0 cont_4	# If t0 == s0, jump to cont_4
j find_Max_Int

cont_4:	# Print max number in array

question_4_part_2
	li $t0 0		# t0 = 0
	lw $s0 asize		# s0 = size of array
	la $s1 arr1		# load address of arr1 into s1
	li $t1 0($s1)	# t1 is my min number
find_Min_Int:
	beq $t0 $s0 cont_5
	
j find_Max_Int

cont_5:	# Print min number in array

exit:
	li $v0 10
	syscall
	
