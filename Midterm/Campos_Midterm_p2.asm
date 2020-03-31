.macro prntStr(%str)
	li $v0 4
	la $a0 %str
	syscall
.end_macro
.macro prntInt(%x)
	li $v0 1
	move $a0 %x
	syscall
.end_macro
.data
arr: .space 64
arrSize: .word 16
space: .asciiz " "
newLine: .asciiz "\n"
strEven: "Number of even integers: "
strOdd: "Number of odd integers: "
.text
main:
	la $s0 arr
	lw $s1 arrSize
	li $t0 0
fill_Loop:
	beq $t0 $s1 done_Fill
	jal emit_Int
	sw $v0 0($s0)	# Save integer to array
	addi $t0 $t0 1	# Increment counter
	addi $s0 $s0 4	# Move to next cell of the array
	j fill_Loop
done_Fill:	
	# Set up registers to display the array
	la $s0 arr
	lw $s1 arrSize
	li $t0 0
display_Loop:
	beq $t0 $s1 done_Display
	lw $a0 0($s0)	# Read int from array
	li $v0 1		# Print integer
	syscall
	
	prntStr(space)
	
	addi $t0 $t0 1	# Increment counter
	addi $s0 $s0 4	# Move to next cell in the array
	j display_Loop
done_Display:
	prntStr(newLine)
	la $a0 arr
	lw $a1 arrSize
	jal parseArray
	move $s0 $v0	# s0 = num of even integers
	move $s1 $v1	# s1 = num of odd integers
	
	prntStr(strEven)
	prntInt($s0)
	prntStr(newLine)
	prntStr(strOdd)
	prntInt($s1)
	prntStr(newLine)
terminate:
	li $v0 10
	syscall
	
emit_Int:
	li $a1 99	# Upperbound = 99
	li $v0 42	# Emit random integer
	syscall
	addi $a0 $a0 1	# Add 1 to set lower bound and upper bound [1, 100]
	move $v0 $a0	# Move result to v0
	jr $ra
	
isEven:
	sub $sp $sp 4
	sw $ra 0($sp)
	
	srl $t9 $a0 1
	sll $t9 $t9 1
	seq $v0 $a0 $t9	# If a0 == t9 then the number is even (v0 = 1)
	
	lw $ra 0($sp)
	addi $sp $sp 4
	jr $ra

# a0 = array
# a1 = size of array
# v0 = even count
# v1 = odd count
parseArray:
	sub $sp $sp 4
	sw $ra 0($sp)
	move $s0 $a0
	move $s1 $a1
	li $t0 0
	li $t2 0	# even counter
	li $t3 0	# odd counter
loop:
	beq $t0 $s1 done_Loop
	lw $a0 0($s0)	# Read int
	
	#move $a0 $t1
	jal isEven
	addi $t0 $t0 1	# Increment counter
	addi $s0 $s0 4	# Move to next int
	beqz $v0 oddCount
evenCount:
	addi $t2 $t2 1
	j loop
oddCount:
	addi $t3 $t3 1
	j loop
done_Loop:
	move $v0 $t2
	move $v1 $t3
	lw $ra 0($sp)
	addi $sp $sp 4
	jr $ra