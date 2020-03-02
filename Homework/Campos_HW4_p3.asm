.data
mon: .asciiz "Monday"
tue: .asciiz "Tuesday"
wed: .asciiz "Wednesday"
thu: .asciiz "Thursday"
fri: .asciiz "Friday"
sat: .asciiz "Saturday"
sun: .asciiz "Sunday"
newLine: .asciiz "\n"

.text
main:
	li $v0 42	# Generate random integer
	li $a1 7
	syscall
	
	move $s0 $a0	# Move generated int to s0
	
compute_Day:
	beq $s0 1 load_Mon	# If s0 == 1 print Monday
	beq $s0 2 load_Tue	# If s0 == 2 print Tuesday
	beq $s0 3 load_Wed	# If s0 == 3 print Wednesday 
	beq $s0 4 load_Thu	# If s0 == 4 print Thursday
	beq $s0 5 load_Fri	# If s0 == 5 print Friday
	beq $s0 6 load_Sat	# If s0 == 6 print Saturday
	beq $s0 0 load_Sun	# If s0 == 0 print Sunday

	load_Mon:
		la $a0 mon
		j compute_Day_Done
	load_Tue:
		la $a0 tue
		j compute_Day_Done
	load_Wed:
		la $a0 wed
		j compute_Day_Done
	load_Thu:
		la $a0 thu
		j compute_Day_Done
	load_Fri:
		la $a0 fri
		j compute_Day_Done
	load_Sat:
		la $a0 sat
		j compute_Day_Done
	load_Sun:
		la $a0 sun
		j compute_Day_Done
compute_Day_Done:
	li $v0 4	# Print day
	syscall
	
	li $v0 4	# Print new line
	la $a0 newLine
	syscall
	
terminate:
	li $v0 10	# Exit program
	syscall


	