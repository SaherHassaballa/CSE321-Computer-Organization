.data
msg:    .asciiz "Enter n: "
res:    .asciiz "Fibonacci = "

.text
        .globl  main

main:
    li      $v0,        4
    la      $a0,        msg
    syscall

    li      $v0,        5
    syscall
    move    $a0,        $v0

    jal     fib_iter

    li      $v0,        4
    la      $a0,        res
    syscall

    move    $a0,        $v0
    li      $v0,        1
    syscall

    li      $v0,        10
    syscall


fib_iter:
    li      $t0,        0
    li      $t1,        1

    beq     $a0,        $zero,  return_zero

loop:
    beq     $a0,        1,      return_one
    add     $t2,        $t0,    $t1
    move    $t0,        $t1
    move    $t1,        $t2
    addi    $a0,        $a0,    -1
    j       loop

return_zero:
    move    $v0,        $t0
    jr      $ra

return_one:
    move    $v0,        $t1
    jr      $ra
