;---------------------------------------------------
; Programa: EX 10 - LISTA 1
; Autor: GABRIEL AUREO DE OLIVEIRA CAMPOS
; Data:30/08/2018
;---------------------------------------------------
org 100
  pares: dw 0
  impares: dw 0
  i: db 0
  pt: dw x
  x: dw 2,3,4,5,6,7,8,9,10,11


org 0

  sta i
  jmp LOOP

LOOPCHK:
  lda i
  add #1
  sta i
  lda #11
  sub i
  jn LOOPEND

LOOP:
  lda i
  shl
  add #x
  sta pt

  lda @pt
  and #1
  jnz IMPAR
  lda pares
  add @pt
  sta pares
  jmp LOOPREPEAT

IMPAR:
  lda impares
  add @pt
  sta impares

LOOPREPEAT:
  jmp LOOPCHK

LOOPEND:
  hlt

