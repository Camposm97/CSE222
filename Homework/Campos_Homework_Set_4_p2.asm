.macro prntStr(%str)
	li $v0 4
	la $a0 %str
	syscall
.end_macro
.macro print(%str)
	.data
	string: .asciiz %str
	.text
	prntStr(string)
.end_macro
.macro println(%str)
	print(%str)
	print("\n")
.end_macro
.macro prntInt(%n)
	li $v0 1
	move $a0 %n
	syscall
.end_macro
.text
main:
	jal ask_For_Int
	move $a0 $v0	# Move enterd integer to argument
	jal compute_Sum

terminate:
	li $v0 10
	syscall
			
ask_For_Int:
	print("Please enter an integer: ")
	li $v0 5
	syscall
	jr $ra
	
compute_Sum:
	print("sum = (")
	move $t0 $a0		# t0 = a0 (entered integer)
	loop_1:
		li $t1 2
		slt 
		prntInt($t1)
		print(" + ")
		j loop_1
	print(")")
compute_Sum_Done:
	jr $ra
	
	