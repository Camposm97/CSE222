.macro prntStr(%str)
	li $v0 4
	la $a0 %str
	syscall
.end_macro
.macro prntInt(%n)
	li $v0 1
	move $a0 %n
	syscall
.end_macro
.macro prntHex(%n)
	li $v0 34
	move $a0 %n
	syscall
.end_macro
.data
arr1: .word 10, 9, 8, 0, 7, 5, 4, 1, 3, 2
newLine: .asciiz "\n"
sum: .word 117
.text
main:
	#li $t2 117
	lw $t2 sum
	
	li $v0 1
	move $a0 $t2
	syscall
j terminate
	la $t0 arr1		# Loads the address of the array (specifically the first cell, the first four bytes of the array))
	addi $t0 $t0 4	# Move to next cell of the array
	
	lw $t1 arr1		# Load int from the array
	
	prntHex($t0)	# Print the address of that integer
	prntStr(newLine)	# Print new line
	prntInt($t1)	# Print the value of t1
terminate:
	li $v0 10
	