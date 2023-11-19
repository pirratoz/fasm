format ELF64 executable
entry main

include '../../utils/equivalents.inc'
include '../../utils/system.inc'
include '../../utils/print.inc'


main:
    mov rsi, '1'
    call print.char

    mov rsi, 48
    call print.char

    call print.ln

    call system.exit
