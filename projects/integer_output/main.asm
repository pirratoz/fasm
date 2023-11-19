format ELF64 executable
entry main

include '../../utils/equivalents.inc'
include '../../utils/system.inc'
include '../../utils/print.inc'

A = 123
B = 0
C = 356
D = -369
; wrong !!!
E = 0x80000000


main:
    mov rsi, A
    call println.integer
    mov rsi, B
    call println.integer
    mov rsi, C
    call println.integer
    mov rsi, D
    call println.integer
    call system.exit
