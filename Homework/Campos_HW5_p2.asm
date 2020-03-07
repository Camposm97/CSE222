.data
arr: .word 5, 10, 7, 15, 117, 0, 444, 7, 23, 12	# Total = 640
arrSize: .word 10
.text
main:
	la $a0 arr				# Load a0 with address of array
	lw $a1 arrSize			# Load a1 with size of array
	jal funct_Compute_Arr_Avg
	move $t0 $v0			# Move result to t0 (average)
	
	li $v0 1				# Print average (should be 64)
	move $a0 $t0
	syscall

terminate:
	li $v0 10				# Exit Program
	syscall
	
funct_Compute_Arr_Avg:	# a0 = array, a1 = size of array
	move $s0 $a0	# s0 = a0
	move $s1 $a1	# s1 = a1
	li $t0 0		# t0 = 0
	li $t2 0		# t2 = 0 (sum of array)
	
arr_Avg_Loop:
	beq $t0 $s1 compute_Arr_Avg_Done
	lw $t1 0($s0)	# Read integer in current cell of the array
	add $t2 $t2 $t1	# t2 = t2 + t1
	addi $t0 $t0 1	# Increment counter
	addi $s0 $s0 4	# Move to next cell in the array
	j arr_Avg_Loop
	
compute_Arr_Avg_Done:
	div $t2 $s1		# Divide sum of array by size of array
	mflo $v0		# Load quotient into v0
	jr $ra			# Jump to caller