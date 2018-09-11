/;---------------------------------------------------
; Programa: LEITOR DECIMAL
; Autor: GABRIEL AUREO
; Data: 11/09/2018
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
  HLT
END MAIN

ORG 500
SPL: DW 0
PTVAL: DW 0
SINAL: DB 0
DIG: DB 0
MIDX: DB 0
PARTIAL: DW 0
PTPARTIAL: DW PARTIAL
TOTAL:DW 0

ASCII EQU 030H
MINUS EQU 02AH
TRALHA EQU 023H

ORG 2000

LEITOR:
  STS SPL
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
  SUB #TRALHA
  JZ INPUTEND
  LDA DIG
  SUB #MINUS
  JNZ VALINPUT
  LDA #1
  STA SINAL

INPUT:
  IN 3
  AND #1
  JZ INPUT
  IN 2
  STA DIG
  SUB #MINUS ;VERIFICA SE USUÁRIO COLOCOU UM SINAL NO MEIO DA ENTRADA
  JZ INPUT
  LDA DIG
  SUB #TRALHA
  JZ INPUTEND
VALINPUT:
  LDA DIG
  SUB #ASCII
  STA DIG

  LDA #0CCH
  SUB TOTAL
  LDA #00CH
  SBC TOTAL +1
  JZ LIMITE
  JN INPUT ;USUÁRIO TENTOU ENTRAR COM UM VALOR MAIOR QUE 32770 OU MENOR QUE -32770, QUE GERARIA UM SINAL INVERTIDO
  JMP LOADTOTAL

LIMITE:
  LDA SINAL
  AND #1
  ADD #7
  SUB DIG
  JN INPUT ;USUÁRIO TENTOU ENTRAR COM 32768 OU 32769, QUE SÃO VALORES NEGATIVOS

LOADTOTAL:
  LDS TOTAL
  STS PARTIAL

SHIFT10:
  LDS SPL
  LDA PTPARTIAL
  PUSH
  LDA PTPARTIAL+1
  PUSH
  JSR MUL10

  LDA PARTIAL + 1
  SUB TOTAL +1
  ;CASO NEGATIVO, OCORREU OVERFLOW NO SHIFT DECIMAL
  JN INPUT

  LDA PARTIAL
  ADD DIG
  STA PARTIAL
  LDA PARTIAL + 1
  ADC #0
  STA PARTIAL + 1

  LDS PARTIAL
  STS TOTAL

  JMP INPUT

INPUTEND:
  LDA SINAL
  AND #1
  JN LOAD

COMPLEMENT:
  LDA #0
  SUB TOTAL
  STA TOTAL
  LDA #0
  SBC TOTAL +1
  STA TOTAL+1

LOAD:
  LDS TOTAL
  STS @PTVAL

  LDS SPL
  RET

ORG 7000
SPM: DW 0
P: DW 0 ;PARCIAL
T: DW 0 ;TOTAL
PT: DW 0 ;PONTEIRO PRO RESULTADO
CSTOR: DB 0 ;GUARDA O CARRY DO SHIFT DA PARTE BAIXA PARA SER ADICIONADO APÓS REALIZAR O SHIFT NA PARTE ALTA
IDX: DB 0


ORG 5000
MUL10:
  STS SPM
  POP
  POP
  POP
  STA PT + 1
  POP
  STA PT

  LDS @PT
  STS P
  STS T

  LDA #0
  STA IDX

MLOOP:
  LDA T
  SHL
  STA T
  LDA #0
  ADC #0
  STA CSTOR
  LDA T+1
  SHL
  ADD CSTOR
  STA T+1
  LDA IDX
  ADD #1
  STA IDX
  SUB #3
  JN MLOOP

  LDA P
  SHL
  STA P
  LDA #0
  ADC #0
  STA CSTOR
  LDA P+1
  SHL
  ADD CSTOR
  STA P+1

  LDA T
  ADD P
  STA T

  LDA T+1
  ADC P+1
  STA T+1

  LDS T
  STS @PT

  LDS SPM
  RET


