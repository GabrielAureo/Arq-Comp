;---------------------------------------------------
; Programa: EX 1 - TRABALHO 1
; Autores: GABRIEL AUREO E GABRIEL RAPOSO
; Data: 02/09/2018
;---------------------------------------------------
ORG 60H
  N: DB 0
  M: DB 0
  OP: DB 0

ORG 0

MAIN:
  LDA #OP
  PUSH
  JSR SCANB

  LDA #N
  PUSH
  JSR SCANB

  LDA #M
  PUSH
  JSR SCANB

  LDA N
  PUSH
  LDA M
  PUSH

  LDA OP
  JSR OPERADOIS

  HLT

ORG 300

;VARIAVEIS SCANB

SP0: DW 0
INPUT: DW 0

ORG 500

SCANB:
  STS SP0

  POP
  POP

  POP
  STA INPUT

INPUTLOOP:
  IN 1
  AND #1
  JZ INPUTLOOP
  IN 0
  STA @INPUT

  LDS SP0
  RET

ORG 800

SP1: DW 0
MODO: DB 0
X: DB 0
Y: DB 0


ORG 1100
OPERADOIS:

  STS SP1

  STA MODO

  POP
  POP

  POP
  STA Y

  POP
  STA X

  SUB 1
  JNZ ADICAO

  LDA X
  SUB Y
  JMP RETORNA

ADICAO:
  LDA X
  ADD Y

RETORNA:
  OUT 0
  LDS SP1
  RET

