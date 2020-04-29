.include "Campos_Macros.asm"
.data
binArr: .space 32		# 32 bytes = 32 characters
binArrSize: .word 32	# Size of binArr
strPrmptSignMagNum: .asciiz "Your sign/magnitude binary number (32-Bit): "
newLine: .asciiz "\n"
space: .asciiz " "
.text
main:
	jal fillBinArr
	jal askForBinNum
	move $s7 $v0	# Save string t0 s7
	move $a0 $s7	# a0 = s7
	jal isValidBinNum
	beqz $v0 terminate
	#move $t0 $v0
	#print("Valid binary number?" )
	#prntInt($t0)
	prntStr(newLine)
	#jal readBinStr
# Exit Program
terminate:
	#jal displayBinArr
	jal isNegNum
	li $v0 10
	syscall

# =====================================[FUNCTIONS BELOW]=====================================
# Prompts user to enter binary number (sign/mag. format)
# Returns string
askForBinNum: # Input: "0000 0000 0000 0000 0000 0000 0000 0000"
	prntStr(strPrmptSignMagNum)
	li $v0 8
	la $a0 binArr
	prmptStr(40)	# Prompt string
	move $s0 $a0	# Move string to s0
	prntStr(newLine)
	move $v0 $s0	# v0 = s0
	jr $ra

# Checks format of string
# a0 = string
# Return 1 if valid
isValidBinNum:
	saveAddr()
	move $s0 $a0	# s0 = a0
	li $s1 40		# s1 = 40 (length of string)
	li $t0 0		# Counter
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
# Stores string in binArr, if string isn't all 1s or 0s then the function will return a 0
# a0 = entered string
readBinStr:
	saveAddr()
	move $s0 $a0	# s0 = entered string
	la $s1 binArr	# Load address of binArr
	lw $s2 binArrSize	# Load size of binArr
	li $t0 0		# t0 = 0 (counter)
readStrLoop:
	beq $t0 $s2 doneReadStr	# If t0 == s2, then jump
	
	lb $a0 0($s0)		# load character from string into t1
	
	jal isBinChar
	beqz $v0 doneReadStr	# If v0 == 0, then jump to done
	
	sb $a0 0($s1)		# Save character to binArr
	prntChar($a0)
	#prntStr(space)
	
	addi $t0 $t0 1	# Increment counter
	addi $s0 $s0 1	# Move to next cell in the array
	addi $s1 $s1 1	# Move to next cell of the binArr
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



# Fills binArr with zeros
fillBinArr:
	saveAddr()
	la $s0 binArr
	lw $s1 binArrSize
	li $t0 0	# t0 = counter
	li $t1 48	# t1 = 48
fillLoop:
	sb $t1 0($s0)
	addi $t0 $t0 1	# Increment counter
	addi $s0 $s0 1	# Move to next cell
	bne $t0 $s1 fillLoop
	loadAddr()
	jr $ra



# Checks if binary number (binArr) is negative in sign/magnitude format
isNegNum:
	saveAddr()
	la $s0 binArr
	lb $t0 0($s0)
	print("Negative? ")
	prntChar($t0)
	prntStr(newLine)
	loadAddr()
	jr $ra



# Prints binArr on one line
displayBinArr:
	saveAddr()
	la $s0 binArr
	lw $s1 binArrSize	# counter
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
