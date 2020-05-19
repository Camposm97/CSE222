.data
input: .space 32
buffer: .space 4
inputSize: .word 32
stringInput: .asciiz "Input: "
stringOutput: .asciiz "Output: "
newLine: .asciiz "\n"

.text
main:
	li $v0 4
	la $a0 stringInput
	syscall
	
	li $v0 8
	la $a0 input
	li $a1 33
	syscall
	
	li $v0 4
	la $a0 newLine
	syscall
	
	la $s0 input	# s0 = input
	lb $t0 0($s0)	# load first char
	sub $t0 $t0 48	# Parse to int
	andi $t0 $t0 1	# t0 = t0 AND 1
	
	beqz $t0 returnInput	# If t0 == '0', returnInput
startConverting:	# Else start conversion to two's comp
	li $v0 4	# Print output
	la $a0 stringOutput
	syscall
	
	jal flipBits
	
	j done
returnInput:
	li $v0 4
	la $a0 stringOutput
	syscall
	jal displayResult
	j done
done:
	li $v0 10
	syscall
	
displayResult:	# Displays arrray of char in input
	la $s0 input
	lw $s1 inputSize
	li $t0 0	# counter
	li $a0 0	# for storing char from array
displayLoop:
	beq $t0 $s1 displayDone
	lb $a0 0($s0)	# Load char
	li $v0 11		# Print char
	syscall
	addi $t0 $t0 1
	addi $s0 $s0 1
	j displayLoop
displayDone:
	li $v0 4
	la $a0 newLine
	syscall
	jr $ra
	
flipBits:	# Flips all the bits in input except the msb
	

