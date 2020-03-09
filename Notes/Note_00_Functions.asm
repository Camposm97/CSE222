.macro prntStr(%str)
	li $v0 4
	la $a0 %str
	syscall
.end_macro
.macro prntln()
	.data 
	newLine: .asciiz "\n"
	.text 
	prntStr(newLine)
.end_macro
.macro println(%str)
	.data 
	s: .asciiz %str
	.text 
	prntStr(s) 
	prntln()
.end_macro
.text
# The way a function works (at least to my understanding) is that when you call it using "jal" 
# MIPS will save where the program called the function in the register $ra then run the code 
# inside the function.  
#
# If you have nested functions then you need to save the return address to the stack pointer so 
# the program can return where it was before calling the functions.
main:
	println("Main Method")		# Print a string
	sub $sp $sp 12			# Subtract 12 from $sp and store in it self
	jal functionA			# Call function A, save return address to $ra
	println("End of Program.")	# Print a string
	li $v0 10				# Terminate program
	syscall
	
functionA:
# The reason I substracted 12 from stack pointer is because I need to make space to save the 
# return addresses once the functions are all done and can return to their caller, thus back
# to the main method of the program.
	sw $ra 0($sp)			# Save word ($ra) to $sp[0] - $sp[3] since a word is 32 bits
	println("Function A")		# Print a string proving we're in function A
	jal functionB			# Call function B, save return address to $ra
	println("Goodbye Function A")	# Print a string proving we're back in function A after calling function B
	lw $ra 0($sp)			# Load return address from stack pointer to $ra
	jr $ra					# Jump to return register (return address)
	
functionB:
	sw $ra 4($sp)			# Save return address to $sp[4] - $sp[7] since word is 4 bytes
	println("Function B")		# Print a string proving we're in function B
	jal functionC			# Call function C, save return address to $ra
	println("Goodbye Function B")	# Print a string pvoing we're back in function B after calling function C
	lw $ra 4($sp)			# Load return address (4 bytes) from stack pointer to $ra
	jr $ra					# Jump to return register (return address)
	
functionC:
	sw $ra 8($sp)			# Save return address to $sp[8] - $sp[11] since word is 4 bytes
	println("Function C")		# Print a string proving we're in function C
	println("Goodbye Function C")	# Print a string we're still in function C before end of function
	lw $ra 8($sp)			# Load return address from stack pointer
	jr $ra					# Jump to return address 
