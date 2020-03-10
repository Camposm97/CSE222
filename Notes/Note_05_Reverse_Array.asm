.data
arr1: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
size: .word 10
arr2: .space 40
tab: .asciiz "\t"
.text
main:
	la $s0 arr1		# s0 = address of arr1
	la $s1 arr2		# s1 = address of arr2
	addi $s0 $s0 36	# Set s0 to the last cell (address) of the array
	lw $s2 size		# s2 = size
	li $t1 0		# Set t1 = 0
	
loop_Reverse:
	beq $t0 $s2 display_Reverse	# If t0 == 0, then jump to done
	lw $t1 0($s0)		# Load number from array
	sw $t1 0($s1)		# Save number to array2
	
	addi $t0 $t0 1		# Increment i
	sub $s0 $s0 4		# Move to next cell (backwards)
	addi $s1 $s1 4		# Move to next cell (forwards)
	j loop_Reverse

display_Reverse:
	li $t0 0	# Set t0 = 0 (i)
	li $t1 0	# Set t1 = 0 (placeholder)
	la $s0 arr2	# Load address of arr2 into s0
	lw $s1 size	# Load size into s1
loop_Display:
	beq $t0 $s1 done	# If t0 == size, jump to done
	lw $t1 0($s0)	# Read int from array
	
	li $v0 1		# Print integer
	move $a0 $t1
	syscall
	
	li $v0 4		# Print tab
	la $a0 tab
	syscall
	
	addi $t0 $t0 1	# Increment i
	addi $s0 $s0 4	# Move to next cell
	j loop_Display

done:
	li $v0 10
	syscall
	
functDisplayArr:
	move $s0 $a0		# s0 = address of array
	move $s1 $a2		# s1 = size of array
	li $t0 0			# Set t0 = 0 (counter)
loopDisplay:
	beq $t0 $s1 done
	
loopDisplayDone:
	
	jr $ra
