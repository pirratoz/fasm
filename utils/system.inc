system:

; sys_exit
.exit:
    mov rax, 60
    xor rdi, rdi
    inc rdi
    syscall

; sys_write
; input:
;   rsi - string
;   rdx - length string
.write:
    xor rax, rax
    xor rdi, rdi
    inc rax
    inc rdi
    syscall
    ret
