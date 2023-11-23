format ELF64 executable
entry main

include '../../utils/equivalents.inc'
include '../../utils/system.inc'
include '../../utils/print.inc'

array dd 15, 10, 3, 12, 1, 0
array.element_size = 4
array.size = ($ - array) / array.element_size


print_array:
    xor rcx, rcx
    jmp .for

    .for:
        mov esi, [array + array.element_size * rcx]

        push rcx
        call print.integer
        pop rcx

        inc rcx
        cmp rcx, array.size
        je .end

        push rcx
        mov rsi, ' '
        call print.char
        pop rcx

        jmp .for
    
    .end:
        call print.ln
        ret


array_sort:

    .end:
        ret


main:
    call print_array
    call array_sort
    call print_array

    call system.exit
