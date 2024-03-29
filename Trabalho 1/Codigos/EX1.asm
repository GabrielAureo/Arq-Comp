;---------------------------------------------------
; Programa: EX 1 - TRABALHO 1
; Autores: GABRIEL AUREO
; Data: 02/09/2018
;---------------------------------------------------
ORG 60H
  N: DW 0
  PN: DW N ;PONTEIRO PRA N
  M: DW 0
  PM: DW M ;PONTEIRO PRA M
  RESULTADO: DW 0
  PRESULTADO: DW RESULTADO ;PONTEIRO PRO RESULTADO
  OP: DB 0

ORG 0

MAIN:
;ESCANEIA MODO DE OPERAÇÃO (ADIÇÃO OU SUBTRAÇÃO)
 SCANOP:
  IN 1
  AND #1
  JZ SCANOP
  IN 0
  STA OP
  ;VERIFICA SE OP É 1 OU 0
  LDA OP ;APESAR DO ACC JÁ CONTER O VALOR DE OP, ELE É CARREGADO NOVAMENTE PARA SETAR A FLAG Z
  JZ SCANVALS
  SUB #1
  JNZ SCANOP


 SCANVALS:
;PASSA O ENDEREÇO DO PRIMEIRO VALOR COMO ARGUMENTO PELA PILHA PARA RECEBER ENTRADA DO USUÁRIO
  LDA PN
  PUSH
  LDA PN +1
  PUSH
  JSR SCANW

;PASSA O ENDEREÇO DO SEGUNDO VALOR COMO ARGUMENTO PELA PILHA PARA RECEBER ENTRADA DO USUÁRIO
  LDA PM
  PUSH
  LDA PM + 1
  PUSH
  JSR SCANW

  LDA PN ;PASSA O PRIMEIRO ARGUMENTO DE OPERADOIS ATRAVÉS DA PILHA
  PUSH
  LDA PN +1
  PUSH
  LDA PM ;PASSA O SEGUNDO ARGUMENTO DE OPERADOIS ATRAVÉS DA PILHA
  PUSH
  LDA PM + 1
  PUSH
  LDA PRESULTADO ;PASSA O ENDEREÇO A SER CARREGADO O RESULTADO DE OPERADOIS ATRAVÉS DA PILHA
  PUSH
  LDA PRESULTADO + 1
  PUSH
  LDA OP ;PASSA A OPERAÇÃO A SER REALIZADA EM OPERADOIS ATRAVÉS DO ACUMULADOR
  JSR OPERADOIS ;CHAMA A SUBROTINA OPERADOIS
  OUT 0
  HLT

END MAIN

ORG 300

;VARIAVEIS SCANB

SP0: DW 0
INPUT: DW 0

ORG 500
;SUBROTINA QUE SCANEIA ENTRADA E GUARDA EM UM PONTEIRO PASSADO PELA PILHA
SCANW:
  STS SP0

  POP
  POP

  POP
  STA INPUT +1
  POP
  STA INPUT

;LÊ A PARTE BAIXA DO NÚMERO DE 16 BITS
INPUTLOW:
  IN 1
  AND #1
  JZ INPUTLOW
  IN 0
  STA @INPUT

;INCREMENTA O ENDEREÇO APONTADO POR INPUT, A FIM DE APONTAR PARA A PARTE ALTA DA VARIÁVEL DE SAÍDA
  LDS INPUT
  POP
  STS INPUT

;LÊ A PARTE ALTA DO NÚMERO DE 16 BITS
INPUTHIGH:
  IN 1
  AND #1
  JZ INPUTHIGH
  IN 0
  STA @INPUT

;RESTAURA PONTEIRO DA PILHA E RETORNA
  LDS SP0
  RET

ORG 800
;VARIÁREIS DA ROTINA OPERADOIS
SP1: DW 0
MODO: DB 0
X: DW 0
Y: DW 0
Z: DW 0

ORG 900
OPERADOIS:
  STS SP1

  STA MODO

  POP
  POP

  POP
  STA Z + 1
  POP
  STA Z

  POP
  STA Y +1
  POP
  STA Y

  POP
  STA X +1
  POP
  STA X

;VERIFICA SE É UMA ADIÇÃO OU SUBTRAÇÃO
  LDA MODO
  SUB #1
  JNZ ADICAO

  LDA @X
  SUB @Y
  STA @Z

  LDS Z
  POP
  STS Z
  LDS X
  POP
  STS X
  LDS Y
  POP
  STS Y

  LDA @X
  SBC @Y
  STA @Z
  JMP RETORNO

ADICAO:
  LDA @X
  ADD @Y
  STA @Z

  LDS Z
  POP
  STS Z
  LDS X
  POP
  STS X
  LDS Y
  POP
  STS Y

  LDA @X
  ADC @Y
  STA @Z

RETORNO:
  STA @Z
  JC OVERFLOW
  LDA #0
  JMP FINAL
OVERFLOW:
  LDA #1
FINAL:
  LDS SP1
  RET

