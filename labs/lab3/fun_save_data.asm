func_add:
    addi    $sp,        $sp,    -4
    sw      $ra,        0($sp)

    add     $a0,        $a0,    $a1

    lw      $ra,        0($sp)
    addi    $sp,        $sp,    4
    jr      $ra
main:
    # caller save ra
    addi    $sp,        $sp,    -4
    sw      $ra,        0($sp)

    li      $a0,        10
    li      $a1,        20
    # caller save a0
    addi    $sp,        $sp,    -4
    sw      $a0,        0($sp)


    jal     func_add

    li      $v0,        1
    syscall

    lw      $a0,        0($sp)
    addi    $sp,        $sp,    4

    li      $v0,        1
    syscall

    lw      $ra,        0($sp)
    addi    $sp,        $sp,    4
    jr      $ra