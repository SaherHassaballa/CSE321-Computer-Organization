fib_rec:
    addi    $sp,        $sp,    -8
    sw      $ra,        4($sp)
    sw      $a0,        0($sp)

    li      $t0,        1
    ble     $a0,        $t0,    base_case

    addi    $a0,        $a0,    -1
    jal     fib_rec
    move    $t1,        $v0

    lw      $a0,        0($sp)
    addi    $a0,        $a0,    -2
    jal     fib_rec

    add     $v0,        $v0,    $t1
    j       end_rec

base_case:
    move    $v0,        $a0

end_rec:
    lw      $ra,        4($sp)
    addi    $sp,        $sp,    8
    jr      $ra
