format ELF64 executable
entry main

include '../../utils/equivalents.inc'
include '../../utils/system.inc'
include '../../utils/print.inc'

source_array db "Source Array:", ln, 0
source_array.length = $ - source_array

sorted_array db "Sorted Array:", ln, 0
sorted_array.length = $ - sorted_array

array dd 15, 10, 3, 4, 1, 0, 50, 68, 7, 2, 5, 2, 4
array.element_size = 4
array.size = ($ - array) / array.element_size


; note: does not work with negative numbers


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
    xor rcx, rcx
    mov rcx, array.size

    .first_for:
        cmp rcx, 0
        je .end

        dec rcx
        push rcx

        xor rcx, rcx
        push rcx

        .second_for:
            pop rcx     ; take number_current_element
            push rcx

            mov eax, [array + array.element_size * rcx]
            inc rcx
            mov ebx, [array + array.element_size * rcx]
            dec rcx

            cmp eax, ebx
            jg .move_left
            jmp .continue_for

            .move_left:
                inc rcx
                mov [array + array.element_size * rcx], eax
                dec rcx
                mov [array + array.element_size * rcx], ebx
            
            .continue_for:
                nop

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
