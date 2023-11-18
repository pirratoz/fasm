format ELF64 executable
entry main

include '../../utils/equivalents.inc'
include '../../utils/system.inc'

MY_TEXT db 'Hello World', ln, 0
MY_TEXT.LENGTH = $ - MY_TEXT


main:
    mov rsi, MY_TEXT
    mov rdx, MY_TEXT.LENGTH

    call system.write
    call system.exit
