print:

; write line new
.ln:
    mov rsi, ln
    call print.char
    ret

; write symbol
; input:
;   rsi - char
.char:
    push rsi

    mov rsi, rsp
    xor rdx, rdx
    inc rdx
    call system.write

    pop rsi
    ret

; write integer
; input:
;   rsi - integer
.integer:
    push rsi
    add rsi, 0
    js .write_sign
    jmp .start_separation

    .write_sign:
        push rsi

        mov rsi, '-'
        call print.char

        pop rsi
        neg rsi
        jmp .start_separation

    .start_separation:
        mov rax, rsi
        xor rdx, rdx
        xor rcx, rcx
        jmp .separation

    .separation:
        mov rbx, 10
        cdq
        div rbx
        add rdx, '0'
        push rdx        ; .write => pop rsi
        inc rcx
        cmp rax, 0
        je .write
        jmp .separation
    
    .write:
        cmp rcx, 0
        je .end

        pop rsi         ; .separation => push rdx
        push rcx

        call print.char

        pop rcx
        dec rcx

        jmp .write
    
    .end:
        pop rsi
        ret

println:
    .__return:
        push rsi
        call print.ln
        pop rsi
        ret
    
    .char:
        call print.char
        call .__return
        ret

    .integer:
        call print.integer
        call .__return
        ret