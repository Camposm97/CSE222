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
	move $a1 $v0	# a1 = v0 (entered integer)
	jal compute_Sum

terminate:
	li $v0 10
	syscall
			
ask_For_Int:	# Prompts user to enter an integer
	print("Please enter an integer: ")
	li $v0 5
	syscall
	jr $ra
	
compute_Sum:
	print("sum = (")	# Print sum = with open parathesis
	move $s0 $a1	# t0 = a1 (entered integer)
	li $t0 0		# t0 = 0 (index)

	loop_1:		
		li $t1 2
		sllv $t1 $t1 $t0	# Shift t1 to the left t0 times
		prntInt($t1)	# Print integer
		addi $t0 $t0 1	# Increment t0 by 1
		beq $t0 $s0 compute_Sum_Done	# If t0 == s0 then exit loop
		print(" + ")	# Print plus sign
	j loop_1
	
compute_Sum_Done:
	print(")\n")	# Print close paranthesis
	jr $ra
	
