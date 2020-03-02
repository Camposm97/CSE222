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
.text
main:
	loop_1:
		jal display_Options
		jal ask_For_Int
		move $a0 $v0
		jal compute_Selected_Item
		print("\n")
		j loop_1
		
terminate:
	println("Goodbye!")
	li $v0 10	# End Program
	syscall

display_Options:
	println("1. Menu item 1")
	println("2. Menu item 2")
	println("3. Menu item 3")
	println("0. Quit")
	print("Please select from above menu (1-3) ")
	println("to execute ne function. Select 0 to quit")
	jr $ra
	
compute_Selected_Item:
	beqz $a0 terminate	# If a0 == 0, end program
	beq $a0 1 prntOption1
	beq $a0 2 prntOption2
	beq $a0 3 prntOption3
	jr $ra	# User didn't enter 1-3
	
	prntOption1:
		println("Item 1 was selected")
		jr $ra
	prntOption2:
		println("Item 2 was selected")
		jr $ra
	prntOption3:
		println("Item 3 was selected")
		jr $ra
		
ask_For_Int:
	li $v0 5
	syscall
	jr $ra
