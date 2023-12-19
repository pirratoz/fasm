format ELF64 executable
entry main

include '../../utils/equivalents.inc'
include '../../utils/system.inc'
include '../../utils/print.inc'

source_array db "Source Array:", ln, 0
source_array.length = $ - source_array

sorted_array db "Sorted Array:", ln, 0
sorted_array.length = $ - sorted_array

array dq 15, 10, 3, 4, 1, 0, -50, 68, 7, 2, 5, -2, 4
array.element_size = 8
array.size = ($ - array) / array.element_size

print_array:
    xor rcx, rcx
    jmp .for

    .for:
        mov rsi, [array + array.element_size * rcx]

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
    mov rcx, array.size

    .first_for:
        cmp rcx, 0
        je .end

        dec rcx
        push rcx

        push 0          ; starting index of the second loop

        .second_for:
            pop rcx     ; take number_current_element
            push rcx

            mov rax, [array + array.element_size * rcx]
            mov rbx, [array + array.element_size * (rcx + 1)]

            cmp rax, rbx
            jng .continue_for

            mov [array + array.element_size * (rcx + 1)], rax
            mov [array + array.element_size * rcx], rbx
            
            .continue_for: nop

            pop rcx
            inc rcx
            push rcx

            add rcx, 2
            cmp rcx, array.size
            jbe .second_for

            pop rcx     ; take number_current_element (clean stack)

        pop rcx
        
        jmp .first_for

    .end:
        ret


main:
    mov rsi, source_array
    mov rdx, source_array.length
    call system.write
    call print_array
    
    call array_sort
    
    mov rsi, sorted_array
    mov rdx, sorted_array.length
    call system.write
    call print_array

    call system.exit
