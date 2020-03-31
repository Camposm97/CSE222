.macro prntStr(%s)
	li $v0 4
	la $a0 %s
	syscall
.end_macro
.macro prntInt(%n)
	li $v0 1
	move $a0 %n
	syscall
.end_macro
.data
strCount: .asciiz "count="
strAverage: .asciiz "average="
strSum: .asciiz "sum="
newLine: .asciiz "\n"
.text
main:
	li $t0 0	# x
	li $t1 0 	# count
	li $s0 0	# sum
	
loop:
	li $v0 42
	li $a1 9
	syscall
	move $t0 $a0	# Move result to t0
	addi $t1 $t1 1	# Increment counter
	add $s0 $s0 $t0	# s0  = s0 + t0
	beq $t0 5 done_Loop
	j loop
done_Loop:
	div $s0 $t1 # s0 / t1
	mflo $s1	# s1 = average
	
	prntStr(strCount)
	prntInt($t1)
	prntStr(newLine)
	
	prntStr(strAverage)
	prntInt($s1)
	prntStr(newLine)
	
	prntStr(strSum)
	prntInt($s0)
	prntStr(newLine)
	
terminate:	
	li $v0 10
	syscall
