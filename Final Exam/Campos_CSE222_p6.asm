.macro saveAddr()
	addi $sp $sp -4
	sw $ra 0($sp)
.end_macro
.macro loadAddr()
	lw $ra 0($sp)
	addi $sp $sp 4
.end_macro
.macro prntStr(%s)
	li $v0 4
	la $a0 %s
	syscall
.end_macro
.macro prntInt(%x)
	li $v0 1
	move $a0 %x
	syscall
.end_macro
.macro emitInt()
	li $v0 42
	li $a1 101
	syscall
.end_macro
.data
arr: .space 40
arrSize: .word 10
arrResult: .space 8
resultStr1: .asciiz "The maximum element "
resultStr2: .asciiz " is found at location "
.text
main:
	jal funct_Fill_Arr
	jal funct_Get_Info_From_Array
# Display Result Array
	la $s0 arrResult	# Load array result into s0
	lw $t0 0($s0)		# load number
	lw $t1 4($s0)		# load index
	prntStr(resultStr1)
	prntInt($t0)
	prntStr(resultStr2)
	prntInt($t1)
	
terminate:
	li $v0 10
	syscall

funct_Get_Info_From_Array:
	li $v0 0	# Index
	li $t0 0	# Counter (i)
	li $t8 0	# arr[i]
	li $t9 0	# arr[index]
	li $s7 4	# Byte size of Integer
	lw $s1 arrSize	# Load size
	mult $s7 $s1	# 4 * size (to get space of int array)
	mflo $s1	# s1 = space of int array
loopInfo:
	lw $t8 arr($t0)	# Read int from arr[i]
	lw $t9 arr($v0)	# Read int from arr[index]
	blt $t8 $t9 skipUpdate	# If t8 < t9, skip update
	move $v0 $t0	# index = i (UPDATE INDEX)
skipUpdate:
	addi $t0 $t0 4	# Increment Counter by 4
	bne $t0 $s1 loopInfo
	# Now save arr[index] and index
	la $s0 arrResult	# Load arrResult into s0
	lw $t0 arr($v0)		# Load arr[index]
	
	sw $t0 0($s0)		# Save arr[index] at arrResult[0]
	
	# Divide index by 4 to get the REAL index because integers are 4 bytes pf space
	div $v0 $s7		
	mflo $v0		# Load quotient into v0
	sw $v0 4($s0)		# Save index at arrResult[1]
	jr $ra
	
funct_Fill_Arr:
	li $t0 0	# Counter
	la $s0 arr	# Load array
	lw $s1 arrSize	# Load size
loopFill:
	emitInt()
	sw $a0 0($s0)	# Save random int to array
	addi $t0 $t0 1	# Increment counter
	addi $s0 $s0 4	# Move to next cell
	bne $t0 $s1 loopFill
	jr $ra
	