.macro prnt(%str)
	.data
	str: .asciiz %str
	.text
	li $v0 4
	la $a0 str
	syscall
.end_macro

.text
	li $v0 42		# Generate random number
	li $a1 100
	syscall
	
	li $v0 1		# Print generated integer
	syscall
	
	move $s0 $v0	# s0 = v0 (entered integer)
	
	addi $t0 $0 2	# t0 = 2
	beq $s0 1 isPrime	# If s0 == 1 then jump to isPrime label
	beq $s0 2 isPrime	# If s0 == 2 then jump to isPrime label
	beq $t0 3 isPrime	# If s0 == 3 then jump to isPrime label
	beq $t0 5 isPrime
	beq $t0 7 isPrime
loop:
	rem $t1 $s0 $t0	# t1 = s0 % t0
	addi $t0 $t0 1	# t0 = t0 + 1
	beq $t1 0 isContra	# If the remainder = 0 then jump to isContra label
	j loop
	
isPrime: 
	prnt("Is prime\n")
	j done
isContra:
	prnt("Is contrapositive\n")
	j done
done:

	li $v0 10
	syscall