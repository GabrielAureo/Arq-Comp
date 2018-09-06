;---------------------------------------------------
; Programa: ULTIMATE PALINDROME ASSEMBLY DETECTOR NG404
; Autor: GABRIEL AUREO
; Data: 06/09/2018
;---------------------------------------------------

ORG 100

STR: STR "a cara rajada da jararaca"
DW 0
STRPOINTER: DW STR

ORG 0
MAIN:
LDA STRPOINTER
PUSH
LDA STRPOINTER+1
PUSH
JSR PALINDROMO
HLT
END

ORG 300

ORG 200
PALINDROMO:
