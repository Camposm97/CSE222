.macro saveAddr()	# Saves return address to stack pointer
	sub $sp $sp 4	# Make space in stack pointer
	sw $ra 0($sp)
.end_macro
.macro loadAddr()	# Loads return address from stack pointer
	lw $ra 0($sp)
	addi $sp $sp 4
.end_macro
.macro prmptInt()
	li $v0 5
	syscall	# Integer stored in v0
.end_macro
.macro prmptStr(%n)	# Ask for a string with n characters
	li $v0 8
	li $a1 %n	# sets size of characters
	syscall
.end_macro
.macro prntStr(%s)
	li $v0 4
	la $a0 %s
	syscall
.end_macro
.macro prntChar(%c)
	li $v0 11
	move $a0 %c
	syscall
.end_macro

# Checks if the character is null (a0 = character)
#isNullChar:
#	saveAddr()	
#	seq $v0 $a0 0	# If a0 == '\0' then v0 = 1
#	loadAddr()
#	jr $ra
	
# Checks if the character is a new line (a0 = character)
#isNewLineChar:
#	saveAddr()
#	seq $v0 $a0 10	# If a0 == '\n', then v0 = 1
#	loadAddr()
#	jr $ra
