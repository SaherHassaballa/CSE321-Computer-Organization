.data

prompt:     .asciiz "Enter an integer: "
positive:   .asciiz "Positive!!\n"
negative:   .asciiz "Negative!!\n"
zero:       .asciiz "Zero!!\n"

.text
    # if(num > 0 ) negative
    #elseif(num>0) positive
    #else zero



main:
    li      $v0,    4
    la      $a0,    prompt
    syscall
    li      $v0,    5
    syscall
    move    $t0,    $v0
if:
    bne     $t0,    $zero,      elseif
    la      $a0,    zero
    j       endif
elseif:
    bgtz    $t0,    else
    la      $a0,    negative
    j       endif
else:
    la      $a0,    positive
endif:
    li      $v0,    4
    syscall
exit:
    li      $v0,    10
    syscall