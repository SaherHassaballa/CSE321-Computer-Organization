fact_func:
    addi    $sp,        $sp,    -4
    sw      $ra,        0($sp)

    addi    $sp,        $sp,    -4
    sw      $s0,        0($sp)

    li      $s0,        1               # int i
    li      $v0,        1
    for     :
    bgt     $s0,        $a0,    end_for
    mul     $v0,        $s0,    $v0
    addi    $s0,        $s0,    1
    j       for


end_for:
    lw      $s0,        0($sp)
    addi    $sp,        $sp,    4
    lw      $ra,        0($sp)
    addi    $sp,        $sp,    4
    jr      $ra




main:
    addi    $sp,        $sp,    -4
    sw      $ra,        0($sp)

    li      $a0,        4               # factorial

    jal     fact_func

    move    $a0,        $v0

    li      $v0,        1
    syscall

    lw      $ra,        0($sp)
    addi    $sp,        $sp,    4
    jr      $ra