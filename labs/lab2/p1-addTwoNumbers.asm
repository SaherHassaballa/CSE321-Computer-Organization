.data
firstNum:   .asciiz "Enter first number: "
secondNum:  .asciiz "Enter second number: "
resultMsg:  .asciiz "The result is: "
newline:    .asciiz "\n"

.text
main:
    # --- Ask for first number ---
    li      $v0, 4                  # print string
    la      $a0, firstNum
    syscall

    li      $v0, 5                  # read integer
    syscall
    move    $t0, $v0                # store first number in $t0

    # --- Ask for second number ---
    li      $v0, 4
    la      $a0, secondNum
    syscall

    li      $v0, 5
    syscall
    move    $t1, $v0                # store second number in $t1

    # --- Print result message ---
    li      $v0, 4
    la      $a0, resultMsg
    syscall

    # --- Add the two numbers ---
    add     $a0, $t0, $t1           # put result in $a0 for printing

    # --- Print result (integer) ---
    li      $v0, 1
    syscall

    # --- Print newline ---
    li      $v0, 4
    la      $a0, newline
    syscall

    # --- Exit program ---
    li      $v0, 10
    syscall
