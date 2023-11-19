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
