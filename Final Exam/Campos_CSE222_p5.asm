.macro prntStr(%str)
	li $v0 4
	la $a0 %str
	syscall
.end_macro
.macro prntInt(%int)	
	li $v0 1
	move $a0 %int
	syscall
.end_macro
.data
prompt: .asciiz "Enter an integer: "
x: .word 0
newLine: .asciiz "\n"
.text
main:
	prntStr(prompt)
	li $v0 5	# Prompt for an integer
	syscall
	sw $v0 x	# save integer to x

	li $a0 5	# a0 = 5
	lw $a1 x	# a1 = x
	mult $a0 $a1	# 5 * x
	mflo $a0
	prntInt($a0)
	prntStr(newLine)
	lw $a0 x
	jal calc5xAnotherWay
	move $t0 $v0
	prntInt($t0)

terminate:
	li $v0 10	# Kill Program
	syscall
	
# a0 = x
calc5xAnotherWay:
	li $a1 5
	li $t0 0	# counter
	li $t1 0	# sum
loop:
	beq $t0 $a1 done
	add $t1 $t1 $a0
	addi $t0 $t0 1
	j loop
done:
	move $v0 $t1
	jr $ra