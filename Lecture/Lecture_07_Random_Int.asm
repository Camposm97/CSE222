.data
newLine: .asciiz "\n"
isOddStr: .asciiz " - It is an odd number"
isEvenStr: .asciiz " - It is an even number"

.text
main:
	li $v0 42		# Generated int [0, 100)
	li $a1 100		# Set upper bound to 100
	syscall
	
	move $t0 $a0	# Move generated int to t0
	
	li $v0 1		# Print t0
	move $a0 $t0	# a0 = t0
	syscall
	
	srl $t1 $t0 1	# t1 = t0 >> 1
	sll $t1 $t1 1	# t1 = t1 << 1
	seq $t2 $t1 $t0	# If t1 == t0 then t2 = 1 else t2 = 0
	
	#li $v0 4		# Print new line
	#la $a0 newLine
	#syscall
	
	beqz $t2 isOdd	# If t2 == 0 then jump to isOdd label
	j isEven		# Else jump to isEven label
isOdd:
	li $v0 4		# Print number is odd
	la $a0 isOddStr
	syscall
	
	li $v0 4		# Print new line
	la $a0 newLine
	syscall
	j main		# Jump to main label. Program ends when I get an even number.
isEven:
	li $v0 4		# Print number is even
	la $a0 isEvenStr
	syscall
	
	li $v0 4		# Print new line
	la $a0 newLine
	syscall
	j done
done:
	li $v0 10		# Terminate program
	syscall
	
	