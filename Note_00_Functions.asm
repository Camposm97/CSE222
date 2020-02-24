.macro prntStr(%str)
	li $v0 4
	la $a0 %str
	syscall
.end_macro
.macro prntln()
	.text newLine: .asciiz "\n"
	.data prntStr(newLine)
.end_macro
.macro println(%str)
	.data
	str: .asciiz %str
	.text
	prntStr(str)
	prntln()
.end_macro

.text
main: