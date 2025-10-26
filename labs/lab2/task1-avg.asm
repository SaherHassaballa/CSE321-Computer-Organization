.data
firstNum:   .asciiz "Enter first number: "
secondNum:  .asciiz "Enter second number: "
theridNum:  .asciiz "Enter third number: "
fourthNum:  .asciiz "Enter fourth number: "
resultMsg:  .asciiz "The sum is: "
avgMsg:     .asciiz "The average is: "
newline:    .asciiz "\n"

.text
            .globl  main
main:
    # --- read first number ---
    li      $v0,    4
    la      $a0,    firstNum
    syscall
    li      $v0,    5
    syscall
    move    $t0,    $v0

    # --- read second number ---
    li      $v0,    4
    la      $a0,    secondNum
    syscall
    li      $v0,    5
    syscall
    move    $t1,    $v0

    # --- read third number ---
    li      $v0,    4
    la      $a0,    theridNum
    syscall
    li      $v0,    5
    syscall
    move    $t2,    $v0

    # --- read fourth number ---
    li      $v0,    4
    la      $a0,    fourthNum
    syscall
    li      $v0,    5
    syscall
    move    $t3,    $v0

    # --- compute sum ---
    add     $t4,    $t0,        $t1         # t4 = t0 + t1
    add     $t5,    $t2,        $t3         # t5 = t2 + t3
    add     $t6,    $t4,        $t5         # t6 = sum

    # --- print sum ---
    li      $v0,    4
    la      $a0,    resultMsg
    syscall

    move    $a0,    $t6                     # put integer in $a0
    li      $v0,    1
    syscall

    # newline
    li      $v0,    4
    la      $a0,    newline
    syscall

    # --- compute integer average (sum / 4) ---
    li      $t7,    4
    div     $t6,    $t7                     # divide t6 by t7 -> quotient in LO
    mflo    $a0                             # move quotient to $a0

    # --- print average ---
    li      $v0,    4
    la      $a0,    avgMsg
    syscall

    mflo    $a0                             # ensure quotient in $a0 (again safe)
    li      $v0,    1
    syscall

    # print newline
    li      $v0,    4
    la      $a0,    newline
    syscall

    # exit
    li      $v0,    10
    syscall
