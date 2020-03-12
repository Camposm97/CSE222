.macro print(%str)	# Prints a string without print a new line
	.data
	string: .asciiz %str
	.text
	prntStr(string)
.end_macro

.macro println(%str)	# Prints a string with printing a new line
	printStr(%str)
	prntln()
.end_macro

.macro prntStr(%str)	# Prints a string from memory address
	li $v0 4
	la $a0 %str
	syscall
.end_macro

.macro prntInt(%n)	# Prints an integer
	li $v0 1
	move $a0 %n
	syscall
.end_macro

.macro done()		# Terminates the program
	li $v0, 10
	syscall
.end_macro

.macro prmptInt()		# Asks for integer
	li $v0 5
	syscall
.end_macro

.macro saveAddr(%ra)
	sub $sp $sp 4
	sw %ra 0($sp)
.end_macro

.macro loadAddr(%ra)
	lw $ra 0($sp)
	addi $sp $sp
.end_macro