.macro prntStr(%str)
	li $v0 4
	la $a0 %str
	syscall
.end_macro
.data
arr1: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10		# Array with size of 10
arr1Size: .word 10	# Create an integer
space: .asciiz " "
newLine: .asciiz "\n"
	
.text
main:
	la $a0 arr1
	lw $a1 arr1Size
	jal displayArr
	
terminate:
	li $v0 10	# End Program
	syscall

# a0 = array
# a1 = size of array	
displayArr:
	move $s0 $a0	# Set s0 = a0
	move $s1 $a1	# Set s1 = a1
	li $t0 0		# Set t0 = 0 (counter)
	
displayLoop:
	beq $t0 $s1 displayDone
	lw $a0 0($s0)	# Load integer from the array
	li $v0 1		# Print integer
	syscall
	
	li $v0 4
	la $a0 space
	syscall
	
	addi $t0 $t0 1	# Increment counter
	addi $s0 $s0 4	# Move to the next cell in the array
	j displayLoop
	
displayDone:
	li $v0 4
	la $a0 newLine
	syscall
	jr $ra