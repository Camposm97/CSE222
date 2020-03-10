.data
arr1: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
size: .word 10
arr2: .space 40
.text
main:
	la $s0 arr1		# s0 = address of arr1
	la $s1 arr2		# s1 = address of arr2
	addi $s0 $s0 40	# Set s0 to the last cell (address) of the array
	lw $s2 size		# s2 = size
	move $t0 $s1		# Set t1 = s1 (i)
	
loop_Reverse:
	beqz $t0 done	# If t0 == 0, then jump to done
	lw $t1 0($s0)	# Load number from array
	sw $t1 0($s1)	# Save number to array2
	
	sub $t0 $t0 1	# t0 = t0 - 1 (decrement i)
	addi $s0 $s0 4	# Move to next cell (forwards)
	sub $s1 $s1 4	# Move to next cell (backwards)
	j loop_Reverse

done:
	li $v0 10
	syscall
