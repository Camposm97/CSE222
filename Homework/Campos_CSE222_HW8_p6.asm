.macro prntStr(%s)
	li $v0 4
	la $a0 %s
	syscall
.end_macro
.data
x: .word 0
prompt: .asciiz "x = "
result: .asciiz "7x = "
newLine: .asciiz "\n"
.text
main:
	jal prompt_Int
	move $a0 $v0
	jal save_To_X
	jal compute_7x
	move $s0 $v0
	prntStr(result)
	li $v0 1
	move $a0 $s0
	syscall
	prntStr(newLine)
terminate:
	li $v0 10
	syscall
	
prompt_Int:
	prntStr(prompt)
	li $v0 5
	syscall
	jr $ra

# Saves contents of a0 to varX	
save_To_X:
	sw $a0 x
	jr $ra

# Returns value inside x
load_X:
	lw $v0 x	# v0 = x
	jr $ra

# v0 = a0 * a1
multiply:
	mult $a0 $a1
	mflo $v0	# v0 = product of a0 * a1
	jr $ra

# Returns result of v0 = 7 * x
compute_7x:
	sub $sp $sp 4	# Make space in the stack pointer
	sw $ra 0($sp)	# Save ra in the stack pointer
	jal load_X
	move $a0 $v0	# a0 = x
	li $a1 7		# a1 = 7
	jal multiply
	
	lw $ra 0($sp)
	addi $sp $sp 4
	jr $ra
