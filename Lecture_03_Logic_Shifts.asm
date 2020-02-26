.data
msg3: .asciiz "even"
msg4: .asciiz "odd"

.text
# There are two ways to check if a number is odd or even.  
# You can either shift right logical then shift left logical
# the integer then compare the result to the original.  If
# they equal each other then the number is even else the number
# is odd.
# The other way is use andi $t0 0x00000001 and if the result is
# 0 then the number is odd else it is even.  
main:
	li $v0 5 		# Ask for integer
	syscall	
	move $t0 $v0		# Move entered integer into $t0
	
	#sra $t1 $t0 1		# $t1 = $t0 >> 1
	#sll $t1 $t1 1		# $t1 = $t1 << 1
	andi $t0 $t0 0x00000001
	#beq $t0 $t1 label_1	# If $t0 == $t1 then JUMP to label_1
	beqz $t0 label_1		# If $t0 == 0 then JUMP to label_1
	la $a0 msg4			# Else: Load address of msg4 into $a0
	j label_2			# JUMP to label_2
	
label_1:
	la $a0 msg3		# Load address of msg3 into a0

label_2:
	li $v0 4		# Print string
	syscall