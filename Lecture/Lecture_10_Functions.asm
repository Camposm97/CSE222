.macro print(%str)
	.data
	string: .asciiz %str
	.text
	li $v0 4
	la $a0 string
	syscall
.end_macro
.text
main:
	li $a0 2		# a0 = 2
	li $a1 3		# a1 = 3
	li $a2 4		# a2 = 4
	li $a3 5		# a3 = 5
	jal diff_Of_Sums
	move $s1 $v0		# Move result in s1
	
	print("The difference of the sums is ")
	
	li $v0 1
	move $a0 $s1
	syscall
	
	print("\n")
	
	li $v0 10
	syscall

diff_Of_Sums:	# Takes in arguments a0 - a3
	add $a0 $a0 $a1	# a0 = a0 + a1
	add $a2 $a2 $a3	# a2 = a2 + a3
	sub $v0 $a0 $a2	# v0 = a0 = a2
	jr $ra