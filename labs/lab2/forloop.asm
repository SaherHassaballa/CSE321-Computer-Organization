.data

prompt:     .asciiz "Enter the number of values(n): "
result:     .asciiz "The sum = "
newLine:    .asciiz "\n"


.text

main:

    li      $v0,    4
    la      $a0,    prompt
    syscall
    li      $v0,    5
    syscall

    move    $t1,    $v0

    li      $t0,    0

    li      $t2,    0

    for     :
    bgt     $t0,    $t1,    endfor
    addi    $t0,    $t0,    1

    addi    $t2,    $t2,    1
    j       for

    endfor  :
    move    $a0,    $t2
    li      $v0,    1
    syscall

    exit    :
    li      $v0,    10
    syscall