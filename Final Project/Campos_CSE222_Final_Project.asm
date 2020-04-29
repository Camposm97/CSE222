.include "Campos_Macros.asm"
.data
strBinNum: .space 40		# 40 bytes = 40 chars
strBinNumSize: .word 40		# Size of strBinNum
strHeader: .asciiz "========================================[Campos_CSE222_Final_Project]========================================"
strPrmptSignMagNum: .asciiz "Sign/Magnitude Binary Number (32-Bit): "
strInvalidInput: .asciiz "Invalid input: "
strRequirements: .asciiz "Fill out all 32 bits with spaces between for every 4 bits."
strExample: .asciiz "Example: 0000 0000 0000 0000 0000 0000 0000 0000"
newLine: .asciiz "\n"
space: .asciiz " "
.text
main:
	prntlnStr(strHeader)
	jal askForBinNum
	la $a0 strBinNum
	lw $a1 strBinNumSize
	addi $a1 $a1 -1
	jal isValidBinNum
	beqz $v0 invalidInput
	la $a0 strBinNum
	lw $a1 strBinNumSize
	jal convertToDecimal
	j terminate
invalidInput:
	prntStr(strInvalidInput)
	prntlnStr(strBinNum)
	prntlnStr(strRequirements)
	prntlnStr(strExample)
	prntStr(newLine)
	j main
# Exit Program
terminate:
	exit()

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
# a1 = length of string
# Return 1 if valid
isValidBinNum:
	saveAddr()
	move $s0 $a0		# s0 = string
	move $s1 $a1		# s1 = string length
	li $t0 0			# Counter
validBinLoop:
	beq $t0 $s1 doneValidBinLoop
	lb $t1 0($s0)	# Read character
	move $a0 $t1
	jal isBinChar
	move $v1 $v0	# v1 = v0
	jal isSpaceChar
	or $v0 $v0 $v1	# v0 = v0 OR v1
	beqz $v0 doneValidBinLoop
	
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

# Takes a0 (binary string) and converts it to base 10 format
# a1 = length of string
convertToDecimal:
	saveAddr()
	move $s0 $a0	# Store string in s0
	move $s1 $a1	# Store length of string in s1
	#addi $s1 $s1 -1	# Decrement length of string by 1 (So we avoid the NUL char)
	li $s2 0		# This will hold the sum for computing value of the binary number in decimal
	li $s3 30		# Bit Counter
	li $t0 0		# Counter
	li $t1 0		# For storing read chars
	li $t2 1		# Most significant bit (msb = -1 or 1)
	li $t3 1		# t3 = 1 (For shifting)

	jal isNegNum
	addi $s0 $s0 1	# Next char
	addi $t0 $t0 1	# Increment counter
	bnez $v0 isNegative
	j iterate
isNegative:
	li $t2 -1
iterate:
	beq $t0 $s1 doneIterate
	lb $t1 0($s0)	# Read char
	move $a0 $t1	# Move char to a0
	jal isSpaceChar	# Is space char?
	bnez $v0 contIterate	# If true, then 
	addi $t1 $t1 -48	# Parse bit char to integer
	#sub $t4 $s1 $t0	# t4 = s1 - t0
	sllv $t4 $t3 $s3	# t4 = t3 << s3
	
	prntInt($t1)	# Print parsed int
	print(" * ")
	prntlnInt($t4)	# Print power
	
	mult $t1 $t4	# LO = t1 * t4
	mflo $t4		# t4 = LO
	add $s2 $s2 $t4	# sum = sum + t4
	addi $s3 $s3 -1	# Decrement bit counter
contIterate:
	addi $s0 $s0 1	# Next char
	addi $t0 $t0 1	# Increment counter
	j iterate
doneIterate:	
	prntStr(newLine)
	mult $t2 $s2
	mflo $s2
	prntlnInt($s2)
	move $v0 $s2
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

# Checks if binary number (strBinNum) is negative in sign/magnitude format
# a0 = string
isNegNum:
	saveAddr()
	lb $v0 0($a0)
	seq $v0 $v0 49	# If v0 == '1', then v0 = 1
	loadAddr()
	jr $ra
