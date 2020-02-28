.include "Macro_Keys.asm"

.data
	newLine: .asciiz "\n"
	num: .word 32
	name: .space 20
	
.text
main:
	printlnStr("Programs starts here!")
	prntlnInt(num)
	printlnStr("What's your name?")
	
	li $v0, 8		# Read String
	la $a0, name	# a0 = name
	li $a1, 20		# a1 = 20, the user can only enter a max of 20 characters
	syscall

	printlnStr("How old are you?")
	prmptInt()
	
	sw $v0, num # Store entered number into 
	
	printStr("You are ")
	prntInt(num)
	printStr(" years old")
	exit()
