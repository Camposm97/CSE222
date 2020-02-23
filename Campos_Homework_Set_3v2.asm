.macro prnt(%str)
	li $v0 4
	la $a0 %str
	syscall
.end_macro

.macro prntln(%str)
	prnt(%str)
	prnt(newLine)
.end_macro

.macro print(%str)
	.data
	str: .asciiz %str
	.text
	prnt(%str)
.end_macro

.macro println(%str)
	.data
	str: .asciiz %str
	.text
	prntln(str)
.end_macro

.data
newLine: .asciiz "\n"
ask: .asciiz "This is a question"
.text
main:
	println(ask)

terminate:
	li $v0 10
	syscall