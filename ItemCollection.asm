

DoItemCount:

LDA.b #$01 : STA.w $1E83 ; Free Random RAM Address

LDA.l $7EF280 : BEQ +
INC.w $1E83 ; OW Map
+
LDA.l $7EF340 : BEQ +
INC.w $1E83
+
LDA.l $7EF341 : BEQ +
INC.w $1E83
+
LDA.l $7EF342 : BEQ +
INC.w $1E83
+
LDA.l $7EF344 : BEQ +
INC.w $1E83
+
LDA.l $7EF345 : BEQ +
INC.w $1E83
+
LDA.l $7EF346 : BEQ +
INC.w $1E83
+
LDA.l $7EF347 : BEQ +
INC.w $1E83
+
LDA.l $7EF348 : BEQ +
INC.w $1E83
+
LDA.l $7EF349 : BEQ +
INC.w $1E83
+
LDA.l $7EF34A : BEQ +
INC.w $1E83
+
LDA.l $7EF34B : BEQ +
INC.w $1E83
+


LDA.l $7EF34C : CMP.b #$01 : BNE +
INC.w $1E83
+
LDA.l $7EF34C : CMP.b #$02 : BCC +
INC.w $1E83 : INC.w $1E83
+


LDA.l $7EF34D : BEQ +
INC.w $1E83
+
LDA.l $7EF34E : BEQ +
INC.w $1E83
+
LDA.l $7EF34F : CMP.b #$01 : BNE + ; ALL 4 BOTTLES
INC.w $1E83
+
LDA.l $7EF34F : CMP.b #$02 : BNE + ; ALL 4 BOTTLES
INC.w $1E83 : INC.w $1E83
+
LDA.l $7EF34F : CMP.b #$03 : BNE + ; ALL 4 BOTTLES
INC.w $1E83 : INC.w $1E83 : INC.w $1E83
+
LDA.l $7EF34F : CMP.b #$04 : BNE + ; ALL 4 BOTTLES
INC.w $1E83 : INC.w $1E83 : INC.w $1E83 : INC.w $1E83 
+
LDA.l $7EF350 : BEQ +
INC.w $1E83
+
;LDA.l $7EF351 : BEQ + ; No byrna
;INC.w $1E83
;+
LDA.l $7EF352 : BEQ +
INC.w $1E83
+
LDA.l $7EF353 : BEQ +
INC.w $1E83
+
LDA.l $7EF354 : CMP.b #$02 : BNE + ; Titan mitts
INC.w $1E83
+
LDA.l $7EF355 : BEQ +
INC.w $1E83
+
LDA.l $7EF356 : BEQ +
INC.w $1E83
+
LDA.l $7EF357 : BEQ + ; pearl remove it to save some space  since we always have it
INC.w $1E83
+
LDA.l $7EF35B : CMP.b #$01 : BEQ + ; BLUE MAIL 
INC.w $1E83 ; count is 43 here
+

LDA.l $7EF37A : AND.b #$01 : BEQ +
INC.w $1E83
+

LDA.l $7EF374 : AND.b #$01 : BEQ +
INC.w $1E83
+

LDA.l $7EF374 : AND.b #$02 : BEQ +
INC.w $1E83
+

LDA.l $7EF374 : AND.b #$04 : BEQ +
INC.w $1E83 ; count is 47 here
+

LDA.l $7EF359 : CMP #$02 : BNE +
INC.w $1E83 ; count is 49 here
+

LDA.l $7EF35A : CMP #$02 : BNE +
INC.w $1E83 ; count is 50 here (with the hearts below)
+

LDA.l $7EF37B : BEQ + ; half magic
INC.w $1E83
+

PHX
; there is 14 heart we can collect so
LDA.l $7EF36C : SEC : SBC #$18 ; Remove the 3 heart we start with
; then divide that value by 8
LSR : LSR : LSR
TAX ; move that to X
; increase progression by that amount
-
INC.w $1E83
DEX : BNE -
PLX

; $1E83 should set on 0x22 for 100%
; so to get a precentage you do ($1E83 / 0x23) * 100
LDA.b #$00 : STA.l $7EF406
; Do a x3 and store that in percent
LDA.w $1E83 : ASL : STA.l $7EF405

.endCount
; Restored code
LDA.b #$1A
STA.b $10
RTL

pushpc

org $00EB038+$08D4
; ITEMS COLLECTED
db $9F, $65, $70, $61, $69, $6F, $9F
db $5F, $6B, $68, $68, $61, $5F, $70, $61, $60, $9F, $23

db $04, $23
db $9F, $8B, $96, $87, $8F, $95, $9F
db $85, $91, $8E, $8E, $87, $85, $96, $87, $86, $9F, $2A

org $0E8000
incbin fontdata2


org $0EB07E : dw $3CC0 ; tile 35 (yellow J)
org $0EB08C : dw $3CD0 ; tile 42 (yellow Q)



org $02A18A ; Before going into credits
JSL DoItemCount

org $0EBC9E ; skip some code setting the death count
JMP $BCBA

pullpc