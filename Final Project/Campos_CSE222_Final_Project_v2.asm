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
.macro print(%str)
.data
	string: .asciiz %str
.text
	prntStr(string)
.end_macro
.macro println(%str)
	print(%str)
	prntStr(newLine)
.end_macro
.data
strBin: .space 33
strBinSize: .word 33
newLine: .asciiz "\n"
prompt: .asciiz "Enter your signed binary number: "
.text
main:
	println("Enter your signed binary number:")
	li $v0 8
	la $a0 strBin
	lw $a1 strBinSize
	syscall
	prntStr(newLine)
	
	la $a0 strBin
	lw $a1 strBinSize
	jal toTwosComp
	prntStr(strBin)
	prntStr(newLine)
	println("End of Program.")

terminate:
	li $v0 10
	syscall

# Converts string to two's complement
# a0 = binary string
# a1 = length of string
toTwosComp:
	saveAddr()
	move $s0 $a0	# s0 = string
	move $s1 $a1	# s1 = length of string
	addi $s1 $s1 -1
	li $t0 0	# counter
	li $a0 0	# loads character

readFirstBit:
	lb $a0 0($s0)		# Read first character
	beq $a0 48 isPositive	# Is a0 == '0', then we can just return the whole string as it is! :D
	# Else binary number is negative (start converting)
	addi $a0 $a0 -1	# Make a0 into '0'
	sb $a0 0($s0)	# Change sign of msb for conversion
flipBits:	# Visit each character and flip it
	beq $t0 $s1 doneFlipBits
	lb $a0 0($s0)
	jal flipBit
	sb $a0 0($s0)
	addi $t0 $t0 1	# counter++
	addi $s0 $s0 1	# next character
	j flipBits
doneFlipBits:	# Done flipping bits
	add $s0 $s0 -1
# Now add 1 to the binary number
	li $t0 0	# reset count
	li $a0 0	# clear value
addOneLoop:
	beq $t0 $s1 convertDone
	lb $a0 0($s0)
	jal flipBit
	sb $a0 0($s0)
	beq $a0 49 convertDone
	#li $v0 11	# Print character
	#syscall
	
	addi $t0 $t0 1	# counter++
	addi $s0 $s0 -1	# previous character
	j addOneLoop
isPositive:
	println("Binary number is positive!")
convertDone:
	prntStr(newLine)
	println("Converted string to two's comp!")
	loadAddr()
	jr $ra

# a0 = char
flipBit:
	saveAddr()
	beq $a0 48 isZero	# If a0 == '0', then flip to one
	# Else flip a0 to zero
	addi $a0 $a0 -1
	j flipDone
isZero:	# Flip to one
	addi $a0 $a0 1
flipDone:
	loadAddr()
	jr $ra