myFunction:
    addi    $sp,    $sp,    -12
    sw      $ra,    8($sp)
    sw      $s0,    4($sp)
    sw      $s1,    0($sp)

    move    $s0,    $a0
    move    $s1,    $a1

    add     $v0,    $s0,    $s1

    lw      $s1,    0($sp)
    lw      $s0,    4($sp)
    lw      $ra,    8($sp)
    addi    $sp,    $sp,    12
    jr      $ra
