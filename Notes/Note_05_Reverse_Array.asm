.data
arr1: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
arr1Size: .word 10
.text
main:
	la $s0 arr1		# s0 = address of array
	lw $s1 arr1Size	# s1 = size
	move $t0 $s1	# Set t1 = s1
	
loop_Reverse:
	beqz $t0 done
	
	lw $t1 0($s0)
	
	
	j loop_Reverse

done:
	li $v0 10
	syscall