.macro prntStr(%str)
	li $v0 4
	la $a0 %str
	syscall
.end_macro
.data
	arr: .space 20	# Make space for array of integers
	askIntStr: .asciiz "Please enter an integer: "
	newLine: .asciiz "\n"
	comma: .asciiz ", "
.text
# The way an array works is that you need to allocate space so you can set values in the array using
# the keyword .space.  The reason I use 20 after .space is to allocate 20 bytes of space for integers
# because I want to have an array with a size of 5 (5 cells) and an integer is 4 bytes (20 / 4 = 5 cells).
# 
# The way a loop works is that you will define two labels and under one label you do whatever you want
# your program to do and then jump back to the label you defined.  To break out of the loop you need
# to use a branch keyword that can jump to the other label to continue the run of the program.
main:
	li $v0 0				# Set index pointer
	fillArrLoop:
		jal askForInt		# Ask for integer
		move $t1 $v0			# Move v0 value to t1
		sw $t1 arr($t0)		# Save value of t1 in arr at pointer
		addi $t0 $t0 4		# Increment pointer by 4
		bge $t0 20 cont_main	# If t0 > 20, then exit loop
		j fillArrLoop		# Else do another loop of fillArrLoop
cont_main:
	li $t0 0	# Reset index pointer to 0
	displayArrLoop:
		lw $t1 arr($t0)		# Load word from arr[t0] to t1
		
		li $v0 1			# Print integer
		move $a0 $t1			# Move value of t1 to a0
		syscall
		
		bge $t0 16 skipComma	# If t0 >= 16 then skip comma
		prntStr(comma)		# Print comma
	skipComma:
		addi $t0 $t0 4		# Increment pointer by 4
		bge $t0 20 terminate	# If t0 >= 20 then terminate program
		j displayArrLoop		# Else do another loop of displayArrLoop
	
terminate:
	prntStr(newLine)
	li $v0 10
	syscall
	
askForInt:
	prntStr(askIntStr)
	li $v0 5
	syscall
	jr $ra