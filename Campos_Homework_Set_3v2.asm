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
	prnt(str)
.end_macro
.macro println(%str)
	.data
	str: .asciiz %str
	.text
	prntln(str)
.end_macro
.macro prntInt()
	li $v0 1
	syscall
.end_macro

.data
newLine: .asciiz "\n"
var1: .word 32
var2: .word 34
var3: .word 43

.text
main:
	println("I am a college student at SCCC")
	jal askForInt
	sw $v0 var1
	lw $a0 var2
	lw $a1 var3
	jal compareTwoInts
	jal askForInt
	move $s0 $v0
	jal askForInt
	move $s1 $v0
	
	
terminate:
	li $v0 10
	syscall
	
askForInt:
	print("Please enter an integer: ")
	li $v0 5
	syscall
	jr $ra
	
compareTwoInts:
	slt $t0 $a0 $a1
	beqz $t0 prntWay2
	j prntWay1
prntWay1:
	prntInt()
	print(", ")
	move $a0 $a1
	prntInt()
	j compareTwoIntsReturn

prntWay2:
	move $t0 $a0
	move $a0 $a1
	prntInt()
	print(", ")
	move $a0 $t0

	prntInt()
	j compareTwoIntsReturn

compareTwoIntsReturn:
	prntln(newLine)
	jr $ra

isIntEven:	# Takes one argument (a0)
	srl $t0, $a0, 1	# t0 = a0 >> 1
	sll $t0, $v0, 1	# t0 = t0 << 1
	seq $v0, $a0, $t0	# If a0 == t0 then v0 = 1
	jr $ra