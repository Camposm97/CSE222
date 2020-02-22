.data # data segment where you decalre your variables
var1: .word 10	
var2: .word 20
var3: .word 0
str1: .asciiz "Hello MIPS!\n"
# .word and .asciiz are all data directive,
# tells mips compiler this is a data segment

.text
main:	
	prntln()
	li $v0, 4	# load integral
	la $a0, str1	# store address of str1 in a0 (argument #0)
	syscall		# execute instruction
	
	# registers are on your right
	# la = load address
	# li = load register
	# syscall = system call
	# Should remember the codes (read int/print/text)
	
	lw $t0, var1		# load word var1 into t0
	lw $t1, var2		# load word var2 into t1
	add $t2, $t1, $t2	# t2 = t1 + t2
	sw $t2, var3		# store word: t2 to var3
	
	# be careful with what registers you're using,
	# you can overwrite other reigsters without knowing
	
 	li $v0, 10 	# load v0 with code 10 (terminates program)
	syscall		# I'm dizzy qua :( tonto oi??????? T_T
