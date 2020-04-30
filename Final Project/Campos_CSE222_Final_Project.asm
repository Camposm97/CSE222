.macro saveAddr()	# Saves return address to stack pointer
	sub $sp $sp 4	# Make space in stack pointer
	sw $ra 0($sp)
.end_macro
.macro loadAddr()	# Loads return address from stack pointer
	lw $ra 0($sp)
	addi $sp $sp 4
.end_macro
.macro prntInt(%x)
	li $v0 1
	move $a0 %x
	syscall
.end_macro
.macro prntlnInt(%x)
	prntInt(%x)
	prntStr(newLine)
.end_macro
.macro prntStr(%s)
	li $v0 4
	la $a0 %s
	syscall
.end_macro
.macro prntlnStr(%s)
	prntStr(%s)
	prntStr(newLine)
.end_macro
.macro prntIntAsBin(%x)
	li $v0 35
	move $a0 %x
	syscall
.end_macro
.data
strBinNum: .space 40		# 40 bytes = 40 chars
strBinNumSize: .word 40		# Size of strBinNum
strHeader: .asciiz "========================================[Campos_CSE222_Final_Project]========================================"
strPrmptSignMagNum: .asciiz "Input [32-Bit Sign/Magnitude Binary Number]: "
strInvalidInput: .asciiz "Invalid input: "
strRequirements: .asciiz "Fill out all 32 bits with spaces between for every 4 bits."
strExample: .asciiz "Example: 0000 0000 0000 0000 0000 0000 0000 0000"
strResult: .asciiz "Output [32-Bit Two's Complement Binary Number]: "
newLine: .asciiz "\n"
.text
main:
	prntlnStr(strHeader)
	jal askForBinNum	# Prompt user for signed binary number
	la $a0 strBinNum	# Load arguments
	lw $a1 strBinNumSize
	jal isValidBinNum	# Check if entered string is valid
	beqz $v0 invalidInput
	la $a0 strBinNum	# Load arguments
	lw $a1 strBinNumSize
	jal convertBinStrToDecimal
	move $s0 $v0	# Move result to s0
	prntStr(strResult)
	prntIntAsBin($s0)	# Print result as binary (two's complement)
	j terminate
invalidInput:		# String is invalid, re-prompt user
	prntStr(strInvalidInput)
	prntlnStr(strBinNum)
	prntlnStr(strRequirements)
	prntlnStr(strExample)
	prntStr(newLine)
	j main
terminate:	# Exit Program
	li $v0 10
	syscall

# =====================================[FUNCTIONS BELOW]=====================================
# Prompts user to enter binary number (sign/mag. format)
askForBinNum: # Input Example: "0000 0000 0000 0000 0000 0000 0000 0000"
	prntStr(strPrmptSignMagNum)
	li $v0 8			# Prompt string
	la $a0 strBinNum	# Store result -> strBinNum
	li $a1 40			# 40 character limit
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
	addi $s1 $s1 -1		# Decrement string length to avoid NUL char at the end
	li $t0 0			# t0 = counter
validBinLoop:
	beq $t0 $s1 doneValidBinLoop
	lb $t1 0($s0)	# Read character
	move $a0 $t1	# Set a0 = t1
	jal isBinChar	# Check if is 1 or 0
	move $v1 $v0	# v1 = v0
	jal isSpaceChar	# Check if is space char
	or $v0 $v0 $v1	# v0 = v0 OR v1
	beqz $v0 doneValidBinLoop
	
	addi $t0 $t0 1	# Increment counter
	addi $s0 $s0 1	# Next char
	j validBinLoop
doneValidBinLoop:
	seq $v0 $t0 $s1	# v0 = 1 if valid binary number
	loadAddr()
	jr $ra

# Takes a0 (binary string) and converts it to base 10 format
# a1 = length of string
convertBinStrToDecimal:
	saveAddr()
	move $s0 $a0	# Store string in s0
	move $s1 $a1	# Store length of string in s1
	addi $s1 $s1 -1	# Decrement length of string by 1 (avoids the NUL char)
	li $s2 0		# This will hold the RESULT for computing value of the binary numbers in decimal
	li $s3 30		# Bit Counter (Used for shifting)
	li $t0 0		# Counter
	li $t1 0		# For storing read chars
	li $t2 1		# Most significant bit (msb = -1 or 1)
	li $t3 1		# t3 = 1 (For shifting)
	li $t4 0		# For storing temp results

	jal isNegNum	# Check if msb is 1
	addi $s0 $s0 1	# Next char
	addi $t0 $t0 1	# Increment counter
	bnez $v0 isNegative	# If v0 == 1, then jump
	j iterateLoop
isNegative:
	li $t2 -1
iterateLoop:
	beq $t0 $s1 doneIterate
	lb $t1 0($s0)		# Read char
	move $a0 $t1		# Move char to a0
	jal isSpaceChar		# Is space char?
	bnez $v0 contIterate	# If true, then jump
	# If false, then compute result of that bit
	addi $t1 $t1 -48		# Parse bit char to integer
	sllv $t4 $t3 $s3		# t4 = t3 << s3
	mult $t1 $t4	# LO = t1 * t4
	mflo $t4		# t4 = LO (temp result)
	add $s2 $s2 $t4	# Add temp result to s2
	addi $s3 $s3 -1	# Decrement bit counter
contIterate:
	addi $s0 $s0 1	# Next char
	addi $t0 $t0 1	# Increment counter
	j iterateLoop
doneIterate:	
	mult $t2 $s2	# LO = msb's result * s2
	mflo $s2		# s2 = LO (final result)
	move $v0 $s2	# Store final result in v0
	loadAddr()
	jr $ra

# Checks if a0 is a '1' or '0'
# Return value in v0
isBinChar:
	saveAddr()
	seq $t8 $a0 48	# If a0 == '0', then t8 = 1
	seq $t9 $a0 49	# If a0 == '1', then t9 = 1
	or $v0 $t8 $t9	# v0 = t8 OR t9
	loadAddr()
	jr $ra

# Checks if a0 is a space
# Return value in v0
isSpaceChar:
	saveAddr()
	seq $v0 $a0 32	# If a0 == ' ', then v0 = 1
	loadAddr()
	jr $ra

# Checks if binary number (strBinNum) is negative in sign/magnitude format
# a0 = string
isNegNum:
	saveAddr()
	lb $v0 0($a0)	# Read first char of string (msb)
	seq $v0 $v0 49	# If v0 == '1', then v0 = 1
	loadAddr()
	jr $ra