.text
addi $s0 $0 1	# s0 = 1
addi $s1 $0 0	# s1 = 0
addi $t0 $0 128	# t0 = 128

loop: 
	beq $s0 $t0 done	# If s0 == t0 then jump to done
	sll $s0 $s0 1	# s0 = s0 << 1
	addi $s1 $s1 1	# s1 = s1 + 1
	j loop		# Jump to loop
done:
	li $v0 1		# Print s0 as int
	move $a0 $s0	# a0 = s0
	syscall
	
	
	li $v0 10 # Terminate Program
	syscall