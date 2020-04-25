.include "Campos_Macros.asm"
.data
binArr: .space 32		# 32 bytes = 32 characters
binArrSize: .word 32
strPrmptSignMagNum: .asciiz "Please enter a sign/magnitude binary number (32-Bit): "
newLine: .asciiz "\n"
space: .asciiz " "

# NOTES:
#	When entering the binary number, the number doesn't have to be 32 characters, you can leave it as
#	"011" for example.  However, the program will read it as a positive number.  So, if you want to enter a 
#	negative number you have to enter all 32 bits with the msb being 1.
#
# TODO:
# 	Save the entered string into the 32 byte array.  When reading the entered string check each character
#	if it is a 1 or 0, if not then stop reading the string.  If the character is a 1 or 0, then save the
#	character to the char array (memory).  
#
.text
main:
	jal fillBinArr
	prntStr(strPrmptSignMagNum)
	prmptStr(33)		# Prompt string (limit is 33 characters)
	
	move $s0 $a0		# s0 = entered string
	prntStr(newLine)
	move $a0 $s0		# a0 = s0
	jal readSignMagnitudeBinStr
	prntStr(newLine)
# Exit Program
terminate:
	jal displayBinArr
	jal isBinNegInSignMag
	prntStr(newLine)
	li $v0 10
	syscall

# =====================================[FUNCTIONS BELOW]=====================================

# Reads the entered string that should be in sign/magnitude format
# Stores string in binArr
# a0 = entered string
readSignMagnitudeBinStr:
	saveAddr()
	move $s0 $a0		# s0 = entered string
	la $s1 binArr		# Load address of binArr
	lw $s2 binArrSize	# Load size of binArr
	li $t0 0			# t0 = 0 (counter)
readStrLoop:
	beq $t0 $s2 doneReadStr	# If t0 == size of binArr, the jump
	
	lb $a0 0($s0)		# load character from string into t1
	
	jal isBinNum
	beqz $v0 doneReadStr	# If v0 == 0, then jump to done
	
	sb $a0 0($s1)			# Save character to binArr
	prntChar($a0)
	#prntStr(space)
	
	addi $t0 $t0 1	# Increment counter
	addi $s0 $s0 1	# Move ot the next cell in the array
	addi $s1 $s1 1	# Move to the next cell of the binArr
	j readStrLoop
doneReadStr:
	loadAddr()
	jr $ra
	
# Checks if a character is a 1 or 0 (a0 = char)
isBinNum:
	saveAddr()
	seq $t8 $a0 48	# If a0 == '0', then t8 = 1
	seq $t9 $a0 49	# If a0 == '1', then t9 = 1
	or $v0 $t8 $t9	# v0 = t8 + t9
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
isBinNegInSignMag:
	saveAddr()
	la $s0 binArr
	lw $s1 binArrSize
	addi $s1 $s1 -1
	add $s0 $s0 $s1	# Move to last cell of array
	lb $a0 0($s0)
	prntChar($a0)
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