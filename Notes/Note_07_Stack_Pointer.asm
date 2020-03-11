.data
num1: .word 0
.text
main:
	li $t0 7
	
	li $sp 0
	sub $sp $sp 4
	sw $t0 0($sp)
	sw $t0 num1
	lw $t0 0($sp)
	addi $sp $sp 4
	
	li $v0 1
	move $a0 $t0
	syscall
	
terminate:
	li $v0 10
	syscall