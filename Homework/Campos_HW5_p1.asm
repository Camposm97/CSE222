.macro prntStr(%str)
	li $v0 4
	la $a0 %str
	syscall
.end_macro
.data
arr: .space 80  # Create array with size of 20
arrSize: .word 20
newLine: .asciiz "\n"
tab: .asciiz "\t"
.text
main:
    	la $a0 arr         # Load address of arr into a0
    	lw $a1 arrSize     # Load int in a1
    	jal funct_Fib_Arr  # Call function to fill array with fib numbers
    	
    	la $s0 arr		# Load address of array into s0
    	lw $s1 arrSize	# Load integer into s1
    	li $t0 0		# Set t0 = 0 (counter)
    	li $t1 2		# Set t1 = 2 (for getting half of array size)
    	div $s1 $t1		# Divide size of array by 2
    	mflo $t1		# Move quotient to t1
loop_1:
	beq $t0 $s1 terminate	# If t0 == s1, exit loop
	lw $s2 0($s0)		# Load integer from array and store in s2
	
	li $v0 1			# Print integer value in s2
	move $a0 $s2
	syscall
	
	prntStr(tab)
	
	addi $t0 $t0 1		# Increment counter
	addi $s0 $s0 4		# Move to next cell of the array
	beq $t0 $t1 prntln	# If t0 == t1, then print new line
	j loop_1
prntln:
	prntStr(newLine)
	j loop_1

terminate:
    	li $v0 10       # Terminate program
    	syscall

funct_Fib_Arr:		# Takes a0 as array and a1 as size
    	move $s0 $a0		# Move array to s0
    	move $s1 $a1		# Move int to s1
    	li $t0 1 		# Set t0 = 1 (counter)
    	li $t1 0		# Set t1 = 0 (num1)
    	li $t2 1		# Set t2 = 0 (num2)
    	li $t3 0		# Set t3 = 0 (sum)
    	
    	sw $t1 0($s0)	# Save num1 to array
    	addi $s0 $s0 4	# Move to next cell

arr_Loop:
	beq $t0 $s1 arr_Loop_Done	# If t0 == s1, exit loop
    	sw $t2 0($s0)			# Save num2 to array
    	add $t3 $t1 $t2			# sum = num1 + num2
    	move $t1 $t2			# num1 = num2
    	move $t2 $t3			# num2 = sum
    	addi $t0 $t0 1			# Increment counter
    	addi $s0 $s0 4			# Move to next cell in the array
    	j arr_Loop
arr_Loop_Done:
    	jr $ra
