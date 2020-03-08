.data
message: .asciiz "Em yeu anh qua di :)"
.text
main:
	li $v0 4
	la $a0 message
	syscall
done:
	li $v0 10
	syscall