.data
arr1: .word 1, 2, 3
arr1Size: .word 3
.text
main:
	la $a0 arr1
	lw $a1 arr1Size
	jal functFindSum
	
	move $t0 $v0	# move the sum to t0
	
	li $v0 1
	move $a0 $t0
	syscall
	
done:
	li $v0 10
	syscall

# Takes in two arguments where is a0 which should be an array and a1 should be the size of the array
functFindSum:
	move $s0 $a0
	move $s1 $a1 
	li $t0 0	# i (counter)
	li $s2 0	# s2 = sum
	
findSumLoop:
	beq $t0 $s1 findSumLoopDone	# If t0 == s1 then jump to findSumLoopDone
	lw $t9 0($s0)	# Read an int from the array
	add $s2 $s2 $t9	# sum = sum + t9
	addi $t0 $t0 1	# Increment i
	addi $s0 $s0 4	# Move to next cell
	j findSumLoop
findSumLoopDone:
	move $v0 $s2	# v0 = sum
	jr $ra