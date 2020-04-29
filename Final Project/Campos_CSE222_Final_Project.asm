.include "Campos_Macros.asm"
.data
strBinNum: .space 40		# 40 bytes = 40 chars
strBinNumSize: .word 40		# Size of strBinNum
strPrmptSignMagNum: .asciiz "Sign/Magnitude Binary Number (32-Bit): "
strBadInput: .asciiz "Invalid input!  Fill out all 32 characters with spaces between.  \nExample: 0000 0000 0000 0000 0000 0000 0000 0000"
newLine: .asciiz "\n"
space: .asciiz " "
.text
main:
	jal fillBinArr
	jal askForBinNum
	#move $s7 $v0	# Save string t0 s7
	#move $a0 $s7	# a0 = s7
	la $a0 strBinNum
	jal isValidBinNum
	beqz $v0 invalidInput
	#move $t0 $v0
	#print("Valid binary number?" )
	#prntInt($t0)
	prntStr(newLine)
	#jal readBinStr
	j terminate
invalidInput:
	prntStr(strBadInput)
	prntStr(newLine)
	

# Exit Program
terminate:
	#jal displayBinArr
	jal isNegNum
	print("Exiting Program.")
	li $v0 10
	syscall

# =====================================[FUNCTIONS BELOW]=====================================
# Prompts user to enter binary number (sign/mag. format)
askForBinNum: # Input: "0000 0000 0000 0000 0000 0000 0000 0000"
	prntStr(strPrmptSignMagNum)
	li $v0 8		# Prompt string
	la $a0 strBinNum	# Store result -> strBinNum
	li $a1 40		# 40 characters allowed
	syscall
	prntStr(newLine)
	jr $ra

# Checks format of string
# a0 = string
# Return 1 if valid
isValidBinNum:
	saveAddr()
	move $s0 $a0		# s0 = string
	lw $s1 strBinNumSize	# s1 = 40 (length of string)
	li $t0 0			# Counter
validBinLoop:
	beq $t0 $s1 doneValidBinLoop
	lb $t1 0($s0)	# Read character
	move $a0 $t1
	jal isBinChar
	move $v1 $v0	# v1 = v0
	jal isSpaceChar
	or $t2 $v0 $v1	# v0 = v0 OR v1
	beqz $t2 doneValidBinLoop
	#prntChar($t1)
	#prntStr(space)
	#prntInt($t2)
	#prntStr(space)
	#prntInt($t0)
	#prntStr(newLine)
	
	addi $t0 $t0 1	# Increment counter
	addi $s0 $s0 1	# Next Character
	j validBinLoop
doneValidBinLoop:
	seq $v0 $t0 $s1	# v0 = 1 if valid binary number
	loadAddr()
	jr $ra



# Reads the entered string (sign/mag binary number)
# Stores string in strBinNum, if string isn't all 1s or 0s then the function will return a 0
# a0 = entered string
readBinStr:
	saveAddr()
	move $s0 $a0	# s0 = entered string
	la $s1 strBinNum	# Load address of strBinNum
	lw $s2 strBinNumSize	# Load size of strBinNum
	li $t0 0		# t0 = 0 (counter)
readStrLoop:
	beq $t0 $s2 doneReadStr	# If t0 == s2, then jump
	
	lb $a0 0($s0)		# load character from string into t1
	
	jal isBinChar
	beqz $v0 doneReadStr	# If v0 == 0, then jump to done
	
	sb $a0 0($s1)		# Save character to strBinNum
	prntChar($a0)
	#prntStr(space)
	
	addi $t0 $t0 1	# Increment counter
	addi $s0 $s0 1	# Move to next cell in the array
	addi $s1 $s1 1	# Move to next cell of the strBinNum
	j readStrLoop
doneReadStr:
	prntStr(newLine)
	# If t0 == s2, then v0 = 1: means the program read all 32 chaaracters that are 1s and 0s
	seq $v0 $t0 $s2		
	loadAddr()
	jr $ra



# Checks if a0 is a '1' or '0'
# Return value in v0
isBinChar:
	saveAddr()
	seq $t8 $a0 48	# If a0 == '0', then t8 = 1
	seq $t9 $a0 49	# If a0 == '1', then t9 = 1
	or $v0 $t8 $t9	# v0 = t8 + t9
	loadAddr()
	jr $ra



# Checks if a0 is a space
# Return value in v0
isSpaceChar:
	saveAddr()
	seq $v0 $a0 32
	loadAddr()
	jr $ra



# Fills strBinNum with zeros
fillBinArr:
	saveAddr()
	la $s0 strBinNum
	lw $s1 strBinNumSize
	li $t0 0	# t0 = counter
	li $t1 48	# t1 = 48
fillLoop:
	sb $t1 0($s0)
	addi $t0 $t0 1	# Increment counter
	addi $s0 $s0 1	# Move to next cell
	bne $t0 $s1 fillLoop
	loadAddr()
	jr $ra



# Checks if binary number (strBinNum) is negative in sign/magnitude format
isNegNum:
	saveAddr()
	la $s0 strBinNum
	lb $t0 0($s0)
	print("Negative? ")
	prntChar($t0)
	prntStr(newLine)
	loadAddr()
	jr $ra



# Prints strBinNum on one line
displayBinArr:
	saveAddr()
	la $s0 strBinNum
	lw $s1 strBinNumSize	# counter
	#add $s0 $s0 $s1
	#addi $s0 $s0 -1
displayLoop:
	lb $a0 0($s0)	# Read character from array
	prntChar($a0)
	addi $s0 $s0 1	# Move to next cell
	addi $s1 $s1 -1	# Decrement counter
	bnez $s1 displayLoop
	prntStr(newLine)
	loadAddr()
	jr $ra
