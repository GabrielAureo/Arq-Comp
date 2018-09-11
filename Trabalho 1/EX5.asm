;---------------------------------------------------
; Program: ULTIMATE PALINDROME DETECTOR
; Author: GABRIEL AUREO
; Date: 06/09/2018
;---------------------------------------------------

ORG 100
PALINDROMO: STR "a cara rajada da jararaca"
DW 0
PALINPNTR: DW PALINDROMO

ORG 0
MAIN:

LDA PALINPNTR
PUSH
LDA PALINPNTR +1
PUSH
JSR PALINDROMOCHK

HLT
END MAIN

ORG 2000
SP: DW 0
STR: DW 0
PTR: DW 0
DIG: DB 0
LEN: DB 0

ACENTOS: STR "ÁÀÂÃâáàâãÉÈÊéèêÍÌÎíìîÓÒÔóòôÚÙÛÜúùûü"
DW 0
SUBST: STR "aaaaaaaaeeeeeeiiiiiioooooouuuuuuuu"
DW 0

ORG 1000
PALINDROMOCHK:
STS SP
POP
POP

POP
STA STR + 1
POP
STA STR

LDS STR
STS PTR

POP
STA LEN

ITERASTR:
LDA @PTR
STA DIG
OR #0
JZ ITERAFIM

LDS PTR
POP
STS PTR
JMP ITERASTR

ITERAFIM:



LDS SP
RET
















