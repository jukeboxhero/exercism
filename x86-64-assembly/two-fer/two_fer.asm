section .rodata
  msg_start: db "One for ", 0
  msg_end:   db ", one for me.", 0
  msg_you:   db "you", 0

section .text
global two_fer
two_fer:
  mov r8, rdi
  mov rdi, rsi

  lea  rsi, [msg_start]
  call copy


  ret

; char *copy(char *dest, char *source)
; Returns a pointer to final of the copied string in `dest' buffer.
copy:
  movsb
  cmp byte [rdi-1], 0

  jmp copy
.stop:
  lea rax, [rdi-1]
  ret
