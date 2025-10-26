
.data                                   # data segment
hello:    .asciiz "name :saher ayman mounir ali\n"
id: .asciiz "id: 2001002002\n"
course: .asciiz "course: organization\n"

.text                                   # code segment
main:
    li $v0, 4                           # syscall 4 = print string
    la $a0, hello                       # load address of string
    syscall
    la $a0, id                       # load address of string
    syscall
    la $a0, course                       # load address of string
    syscall

    li $v0, 10                          # syscall 10 = exit
    syscall 