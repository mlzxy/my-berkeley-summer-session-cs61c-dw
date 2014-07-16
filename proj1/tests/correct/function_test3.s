.macro push (%arg)
add $sp,$sp,-4
sw %arg,0($sp)
.end_macro

.macro pop (%arg)
lw %arg,0($sp)
add $sp,$sp,4
.end_macro

.macro pushaa ()
push $a0
push $a1
.end_macro
.macro popaa ()
pop $a1
pop $a0
.end_macro
.data

LABEL0: .word 0
LABEL1: .word 0
	.text
	.globl main
	j  main


	main:
	move $v0,$zero
	pushaa
	la $v1,LABEL0
	lw $v0,0($v1)
	push $v1
	li $v0,10
	move $a1,$v0
	pop $a0
	sw $a1,0($a0)
	move $v0,$a1
	popaa
	move $v0,$zero
	pushaa
	la $v1,LABEL1
	lw $v0,0($v1)
	push $v1
	pushaa
	li $v0,10
	push $v0
	la $v1,LABEL0
	lw $v0,0($v1)
	push $v0
	jal fib
	pop $zero
	push $v0
	jal add1
	pop $zero
	move $a1,$v0
	pop $a0
	add $v0,$a0,$a1
	popaa
	move $a1,$v0
	pop $a0
	sw $a1,0($a0)
	move $v0,$a1
	popaa
	pushaa
	la $v1,LABEL1
	lw $v0,0($v1)
	move $a0,$v0
	li $v0,1
	syscall
	popaa
	li $v0 10
	syscall
fib:
	push $ra
	pushaa
	add $v1,$sp,12
	lw $v0,0($v1)
	push $v0
	pushaa
	add $v1,$sp,24
	lw $v0,0($v1)
	push $v0
	li $v0,1
	move $a1,$v0
	pop $a0
	sub $v0,$a0,$a1
	popaa
	move $a1,$v0
	pop $a0
	move $v0,$zero
	beq $a0,$zero,LABEL2
	beq $a1,$zero,LABEL2
	li $v0,1
LABEL2:
	popaa
	beq $v0,$zero,LABEL4
	pushaa
	pushaa
	add $v1,$sp,20
	lw $v0,0($v1)
	push $v0
	li $v0,1
	move $a1,$v0
	pop $a0
	sub $v0,$a0,$a1
	popaa
	push $v0
	jal fib
	pop $zero
	push $v0
	pushaa
	add $v1,$sp,24
	lw $v0,0($v1)
	push $v0
	li $v0,2
	move $a1,$v0
	pop $a0
	sub $v0,$a0,$a1
	popaa
	push $v0
	jal fib
	pop $zero
	move $a1,$v0
	pop $a0
	add $v0,$a0,$a1
	popaa
	j LABEL3
LABEL4:
	add $v1,$sp,4
	lw $v0,0($v1)
LABEL3:
	pop $ra
	jr $ra
add1:
	push $ra
	pushaa
	add $v1,$sp,12
	lw $v0,0($v1)
	push $v0
	li $v0,1
	move $a1,$v0
	pop $a0
	add $v0,$a0,$a1
	popaa
	pop $ra
	jr $ra