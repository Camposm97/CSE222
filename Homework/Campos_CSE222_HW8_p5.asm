.macro prntInt(%var)
	li $v0 1
	lw $a0 %var
	syscall
.end_macro
.macro prntStr(%str)
	li $v0 4
	la $a0 %str
	syscall
.end_macro
.data
var1: .word 0
var2: .word 0
comma: .asciiz ", "
newLine: .asciiz "\n"
.text
main:
	jal emit_Int
	sw $v0 var1
	jal emit_Int
	sw $v0 var2
	
	lw $s0 var1
	lw $s1 var2
	bgt $s1 $s0 swap_Vars
	j display_Vars
swap_Vars:
	sw $s1 var1
	sw $s0 var2
display_Vars:
	prntInt(var1)
	prntStr(comma)
	prntInt(var2)
	prntStr(newLine)
terminate:
	li $v0 10
	syscall
	
emit_Int:	# [0, 10]
	li $v0 42
	li $a1 11
	syscall
	move $v0 $a0	# Move generated int to v0
	jr $ra
	
	
