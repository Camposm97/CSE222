.macro saveAddr()	# Saves return address to stack pointer
	sub $sp $sp 4	# Make space in stack pointer
	sw $ra 0($sp)
.end_macro
.macro loadAddr()	# Loads return address from stack pointer
	lw $ra 0($sp)
	addi $sp $sp 4
.end_macro
.macro prmptInt()
	li $v0 5
	syscall	# Integer stored in v0
.end_macro
.macro prmptStr(%n)	# Ask for a string with n characters
	li $v0 8
	li $a1 %n	# sets size of characters
	syscall
.end_macro
.macro prntStr(%s)
	li $v0 4
	la $a0 %s
	syscall
.end_macro
.macro prntChar(%c)
	li $v0 11
	move $a0 %c
	syscall
.end_macro

.data
strPrmptSignMagNum: .asciiz "Please enter a sign/magnitude binary number (32 bits): "
newLine: .asciiz "\n"
space: .asciiz " "
charArr: .space 32		# 32 bytes = 32 characters
# NOTES:
#	When entering the binary number, the number doesn't have to be 32 characters, you can leave it as
#	"011" for example.  However, the program will read it as a positive number.  So, if you wanted to enter a 
#	negative number you would have to enter all 32 bits with the msb being 1.
#
# TODO:
# 	Save the entered string into the 32 byte array.  When reading the entered string check each character
#	if it is a 1 or 0, if not then stop reading the string.  If the character is a 1 or 0, then save the
#	character to the char array (memory).  
#
.text
main:
	prntStr(strPrmptSignMagNum)
	prmptStr(33)		# Prompt string (limit is 33 characters)
	
	move $s0 $a0		# Store string into s0
	prntStr(newLine)
	
	li $t0 0		# t0 = 0 (counter)
loop:
	beq $t0 32 done
	
	lb $t1 0($s0)	# load character from string
	
	move $a0 $t1		# a0 = t1
	jal isNewLineChar
	beq $v0 1 done
	
	move $a0 $t1		# a0 = t1
	jal isNullChar
	beq $v0 1 done
	
	prntChar($t1)
	prntStr(space)
	
	addi $t0 $t0 1	# increment counter
	addi $s0 $s0 1	# move to next cell of the array
	j loop
done:

# Exit Program
terminate:
	li $v0 10
	syscall

# Checks if the character is null (a0 = character)
isNullChar:
	saveAddr()	
	seq $v0 $a0 0	# If a0 == '\0' then v0 = 1
	loadAddr()
	jr $ra
	
# Checks if the character is a new line (a0 = character)
isNewLineChar:
	saveAddr()
	seq $v0 $a0 10	# If a0 == '\n', then v0 = 1
	loadAddr()
	jr $ra
	
	
