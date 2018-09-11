;---------------------------------------------------
; Programa:
; Autor:
; Data:
;---------------------------------------------------

ORG 100
VALOR: DW 0
PVAL: DW VALOR

ORG 0
MAIN:
  LDA PVAL
  PUSH
  LDA PVAL +1
  PUSH
  JSR LEITOR
END MAIN

ORG 1000
SP0: DW 0
PTVAL: DW 0
SINAL: DB 0
DIG: DB 0
I: DB 0
MIDX: DB 0
PARTIAL: DW 0
PTPARTIAL: DW PARTIAL

ASCII EQU 030H
MINUS EQU 02AH
TRALHA EQU 023H

ORG 2000

LEITOR:
  STS SP0
  POP
  POP
  POP
  STA PTVAL + 1
  POP
  STA PTVAL

FRSTINPUT:
  IN 3
  AND #1
  JZ FRSTINPUT
  IN 2
  STA DIG
  AND #MINUS
  JNZ VALINPUT
  LDA #1
  STA DIG

INPUT:
  IN 3
  AND #1
  JZ INPUT
  IN 2
  STA DIG
  AND #MINUS ;VERIFICA SE USUÁRIO COLOCOU UM SINAL NO MEIO DA ENTRADA
  JZ INPUT
  LDA DIG
  AND #TRALHA
  JZ INPUTEND
VALINPUT:
  LDA DIG
  SUB #ASCII
  STA DIG

MULTIPLY:





REPEAT:
  LDA I
  ADD #1
  STA I

  LDA DIG
  STA @PTDIGITOS

  LDS PTDIGITOS
  POP
  STS PTDIGITOS
  JMP INPUT
 INPUTEND:
 HLT

ORG 5000
SP1: DW 0
D: DB 0 ;DIGITO
P: DW 0 ;PARCIAL
T: DW 0 ;TOTAL
PT: DW 0 ;PONTEIRO PRO RESULTADO
IDX: DB 0


ORG 4000
MUL10:
  STS SP1
  STA D
  STA P
  POP
  POP
  POP
  LDA PT + 1
  POP
  LDA PT

MLOOP:
  LDA P
  SHL
  STA P
  LDA P+1
  ADC #0
  STA P+1
  LDA IDX
  ADD #1
  SUB #3
  JN MLOOP

  LDS P
  STS T

  LDA T
  SHL
  STA T
  LDA T+1
  ADC #0
  STA T+1

  LDS T
  STS @PT

  LDS SP1
  RET





