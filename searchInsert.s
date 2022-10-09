.data
data: .word 1, 3, 5, 6  # data[] = {1, 3, 5, 6}
size: .word 4           # array size = 4
tar1: .word 5           # target1 = 5  
tar2: .word 2           # target2 = 2
tar3: .word 7           # target3 = 7
str:  .string "The insert position is "
n1:   .string "\n"

.text
# s1 = data base address
# s2 = array size
# s3 = target
# s4 = index

# t0 = l
# t1 = u
# t2 = mid

main:
    la		s1, data        # s1 = address
    lw		s2, size        # s2 = 4
    lw		s3, tar1        # s3 = 5
	addi	t0, x0, 0       # s5 = 0
    addi	t1, s2, -1      # s6 = size - 1 = 3
	jal		ra, loop    	# jump and link to loop
    jal		ra, print       # jump and link to print
	addi	t0, x0, 0       # s5 = 0
    addi	t1, s2, -1      # s6 = size - 1 = 3
    lw		s3, tar2        # s3 = 2
	jal		ra, loop        # jump and link to loop
    jal		ra, print       # jump and link to print
	addi	t0, x0, 0       # s5 = 0
    addi	t1, s2, -1      # s6 = size - 1 = 3
    lw 		s3, tar3        # s3 = 7
    jal		ra, loop        # jump and link to loop
    jal		ra, print       # jump and link to print
	
    li		a7, 10          # System call: Exit
    ecall

loop:
	slt		t6, t1, t0      # if u < l , t6 = 1
	bne		t6, zero, return
    add		t2, t0, t1      # mid = l + u
    srli	t2, t2, 1       # mid = mid / 2
    slli	t3, t2, 2       # offset = mid * 4
    add  	t4, s1, t3      # address = base address + offset
    lw		t5, 0(t4)       # t5 = data[mid]    
    beq		s3, t5, equal	# if target == data[mid], go to equal
    blt 	s3, t5, less	# if target < data[mid], go to less
    addi	t0, t2, 1       # if target > data[mid], down = mid + 1 
    j		loop			# jump to loop

equal:
	addi	s4, t2, 0    	# s4 = mid
	ret						# return to main
	
less:
    addi	t1, t2, -1		# if target < data[mid], up = mid - 1
	j		loop			# jump to loop

return:
    addi	s4, t0, 0	    # s4 = l
    ret						# return to main

print:
    la		a0, str			# load string
    li		a7, 4			# System call: PrintString
    ecall
    addi	a0, s4, 0		# load result
    li		a7, 1			# System call: PrintInt
    ecall
	la		a0, n1
	li		a7, 4
	ecall
    ret						# return to main
