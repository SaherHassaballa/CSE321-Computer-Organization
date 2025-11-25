bin:
    li      $s0,    8
    li      $s1,    1
    move    $s3,    $a0

    # 0000 1000 & الرقم بتاعنا

    for     :
    beqz    $s0,    end_for
    addi    $s0,    $s0,        -1
    sllv    $s1,    $s1,        $s0
    and     $s2,    $s1,        $s3
    li      $s1,    1

if:
    beqz    $s2,    else
    li      $a0,    1
    j       end_if
else:
    li      $a0,    0
end_if:
    li      $v0,    1
    syscall
    j       for

end_for:
    jr      $ra


endbin:
    jr      $ra

main:

    #save ra
    addi    $sp,    $sp,        -4
    sw      $ra,    0($sp)

    li      $a0,    8

    jal     bin

    lw      $ra,    0($sp)
    addi    $sp,    $sp,        4

endmain:
    jr      $ra