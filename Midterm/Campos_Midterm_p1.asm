.macro prntStr(%str)
	li $v0 4
	la $a0 %str
	syscall
.end_macro
.data
strPromptInt: .asciiz "Please enter an integer: "
strIsMultOf2: .asciiz "The number you entered is a multiple of 2"
strNotMultOf2: .asciiz "The number you entered is NOT a multiple of 2"
newLine: .asciiz "\n"
.text
main:
	prntStr(strPromptInt)# Print string
	li $v0 5	# Prompt integer
	syscall
	move $a0 $v0	# Move integer to a0
	jal is_Multiple_Of_2
	move $a0 $v0	# Move result to a0
	jal display_Result

terminate:
	li $v0 10
	syscall
	
is_Multiple_Of_2:
	and $v0 $v0 1	# v0 = v0 & 1
	jr $ra
	
display_Result:
	bnez $a0 is_Not_Mult_Of_2
	# ELse is it a multiple of 2
	prntStr(strIsMultOf2)
	prntStr(newLine)
	j done_Display
is_Not_Mult_Of_2:
	prntStr(strNotMultOf2)
	prntStr(newLine)
done_Display:
	jr $ra