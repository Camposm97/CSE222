.macro print(%str)	# Very powerful
	.data
	s: .asciiz %str
	.text
	prntStr(s)
.end_macro

.macro println(%str)	# Too powerful
	printStr(%str)
	prntln()
.end_macro

.macro prntStr(%str)
	li $v0 4
	la $a0 %str
	syscall
.end_macro

.macro prntInt(%n)
	li $v0, 1
	move $a0, %n
	syscall
.end_macro

.macro done()
	li $v0, 10
	syscall
.end_macro

.macro prmptInt()
	li $v0, 5
	syscall
.end_macro
