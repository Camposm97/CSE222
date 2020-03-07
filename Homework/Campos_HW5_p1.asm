.data
arr: .space 80  # Create array with size of 20
arrSize: .word 20

.text
main:
    la $a0 arr          # Load address of arr into a0
    lw $a1 arrSize      # Load int in a1
    jal funct_Fib_Arr   # Call function to fill array with fib numbers

terminate:
    li $v0 10       # Terminate program
    syscall

funct_Fib_Arr:      # Takes a0 as array and a1 as size
    move $s0 $a0    # Move array to s0
    move $s1 $a1    # Move int to s1
    li $t0 0        # Set t0 = 0 (counter)
    li $t1 0        # Set t1 = 0 (number 1)
    li $t2 1        # Set t2 = 0 (number 2)
    li $t3 0        # Set t3 = 0 (sum)

arr_Loop:
    beq $t0 $s1 arr_Loop_Done   # If t0 == s1, exit loop
    sw $t3 0($s0)               # Save t3 to array
    add $t3 $t1 $t2             # t3 = t1 + t2
    addi $t0 $t0 1              # Increment counter
    addi $s0 $s0 4              # Move to next cell in the array
    j arr_Loop
arr_Loop_Done:

    jr $ra