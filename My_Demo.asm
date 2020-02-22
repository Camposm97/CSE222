.include "Macro_Keys.asm"

.data
	quesName: .asciiz "What's your name?"
	quesNum: .asciiz "What's your favorite number?"
	
	newLine: .asciiz "\n"
	num: .word 32
	name: .space 20
	
.text
main:
	prntlnInt(num)
	prntlnStr(quesName)

	li $v0, 8	# Read String
	la $a0, name	# a0 = name
	li $a1, 20	# a1 = 20 
	syscall

	prntlnStr(quesNum)
	prmptInt()
	
	sw $v0, num # Store entered number into 
	
	prntlnInt(num)
	exit()
