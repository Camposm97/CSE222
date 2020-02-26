.text
	li $v0 5
	syscall
	move $t0 $v0
	
	li $t1 2
	div $t0 $t1 # Divide t0 by t1
	mfhi $t0	# Move hi to t0