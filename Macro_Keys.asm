.macro printStr(%str)	# Very powerful
	.data
	myLabel: .asciiz %str
	.text
	prntStr(myLabel)
.end_macro

.macro printlnStr(%str)	# Too powerful
	printStr(%str)
	prntln()
.end_macro

.macro prntStr(%str)
	li $v0, 4
	la $a0, %str
	syscall
.end_macro

.macro prntlnStr(%str)
	prntStr(%str)
	prntStr(newLine)
.end_macro

.macro prntln()
	prntStr(newLine)
.end_macro

.macro prntInt(%int)
	li $v0, 1
	lw $a0, %int
	syscall
.end_macro

.macro prntlnInt(%int) 
	prntInt(%int)
	prntln()
.end_macro

.macro exit()
	li $v0, 10
	syscall
.end_macro

.macro prmptInt()
	li $v0, 5
	syscall
.end_macro
