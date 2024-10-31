

DoItemCount:

LDA.b #$01 : STA.w $1E83 ; Free Random RAM Address - start at 1

LDA.l $7EF280 : BEQ + ; OW Map + 1 (2) .
INC.w $1E83 
+
LDA.l $7EF340 : BEQ + ; any bow + 1 (3) .
INC.w $1E83
+
LDA.l $7EF341 : BEQ + ; any boomerang + 1 (4) .
INC.w $1E83
+
LDA.l $7EF342 : BEQ + ; hookshot + 1 (5) .
INC.w $1E83
+
LDA.l $7EF344 : BEQ + ; mush or powder + 1 (6) .
INC.w $1E83
+
LDA.l $7EF345 : BEQ + ; fire rod + 1 (7) .
INC.w $1E83
+
LDA.l $7EF346 : BEQ + ; ice rod + 1 (8) .
INC.w $1E83
+
LDA.l $7EF347 : BEQ + ; turtle mask + 1 (9) .
INC.w $1E83
+
LDA.l $7EF348 : BEQ + ; deity mask + 1 (10) .
INC.w $1E83
+
LDA.l $7EF349 : BEQ + ; stalfos mask + 1 (11) .
INC.w $1E83
+
LDA.l $7EF34A : BEQ + ; lamp + 1 (12) .
INC.w $1E83
+
LDA.l $7EF34B : BEQ + ; hammer + 1 (13) .
INC.w $1E83
+

LDA.l $7EF34C : CMP.b #$01 : BNE + ; overrided by flute (other +1) if only shovel !
INC.w $1E83
+
LDA.l $7EF34C : CMP.b #$02 : BCC + ; any flute + 2 (15) .
INC.w $1E83 : INC.w $1E83
+


LDA.l $7EF34D : BEQ + ; bug catching net + 1 (16) .
INC.w $1E83
+
LDA.l $7EF34E : BEQ + ; book + 1 (17) .
INC.w $1E83
+
LDA.l $7EF35C : BEQ + ; 1 bottle count +1
INC.w $1E83
+
LDA.l $7EF35D : BEQ + ; 2 bottle count +2 (overrided by next one)
INC.w $1E83
+
LDA.l $7EF35E : BEQ + ; 3 bottle count +3 (overrided by next one)
INC.w $1E83
+
LDA.l $7EF35F : BEQ + ; 4 bottle count +4 (21) .
INC.w $1E83
+
LDA.l $7EF350 : BEQ + ; somaria + 1 (22) 
INC.w $1E83
+
LDA.l $7EF352 : BEQ + ; magic cape + 1 (23)
INC.w $1E83
+
LDA.l $7EF353 : BEQ + ; magic mirror + 1 (24)
INC.w $1E83
+
LDA.l $7EF354 : CMP.b #$02 : BNE + ; Titan mitts + 1 (25) .
INC.w $1E83
+
LDA.l $7EF355 : BEQ + ; boots + 1 (26) .
INC.w $1E83
+
LDA.l $7EF356 : BEQ + ; Flippers + 1 (27)
INC.w $1E83
+
LDA.l $7EF357 : BEQ + ; Moon Pearl + 1 (28)
INC.w $1E83
+
LDA.l $7EF35B : CMP.b #$01 : BNE + ; BLUE MAIL  + 1 (29)
INC.w $1E83 
+

LDA.l $7EF37A : AND.b #$01 : BEQ + ; Crystal 1 + 1 (30)
INC.w $1E83
+

LDA.l $7EF374 : AND.b #$01 : BEQ + ; Pendant 1 + 1 (31)
INC.w $1E83
+

LDA.l $7EF374 : AND.b #$02 : BEQ + ; Pendant 2 + 1 (32)
INC.w $1E83
+

LDA.l $7EF374 : AND.b #$04 : BEQ + ; Pendant 3 + 1 (33)
INC.w $1E83 
+

LDA.l $7EF359 : CMP #$02 : BNE + ; master sword + 1 (34)
INC.w $1E83
+

LDA.l $7EF35A : CMP #$02 : BNE + ; 2nd shield + 1 (35)
INC.w $1E83 
+

LDA.l $7EF37B : BEQ + ; half magic + 1 (36)
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
INC.w $1E83 ; 14 extra hearts + 14 (50)
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


oam_data:
db $A0, $B8, $00, $3B
db $B0, $B8, $02, $3B
db $C0, $B8, $04, $3B
db $D0, $B8, $06, $3B

db $E0, $66, $20, $3B ; percentage


db $40, $A0, $0C, $3B ; ghosttop
db $40, $B0, $2C, $3B ; ghostbot

db $68, $16, $24, $3B ; pumpkin
db $C0, $26, $22, $3B ; spooder

SetHighBitsOAM:
LDA.b #$02
STA.w $0A20
STA.w $0A21
STA.w $0A22
STA.w $0A23
STA.w $0A24
STA.w $0A25
STA.w $0A26
STA.w $0A27
STA.w $0A28
RTL
pushpc

org $00EB038+$08D4
; ITEMS COLLECTED
db $9F, $65, $70, $61, $69, $6F, $9F
db $5F, $6B, $68, $68, $61, $5F, $70, $61, $60, $9F, $9F

db $04, $23
db $9F, $8B, $96, $87, $8F, $95, $9F
db $85, $91, $8E, $8E, $87, $85, $96, $87, $86, $9F, $9F

;org $0E8000
;incbin fontdata2


;org $0EB07E : dw $3CC0 ; tile 35 (yellow J)
;org $0EB08C : dw $3CD0 ; tile 42 (yellow Q)



org $02A18A ; Before going into credits
JSL DoItemCount

org $0EBC9E ; skip some code setting the death count
JMP $BCBA






;---------------------------------------------------------------------------------------------------
org $0EC3FA
Credits_DrawTheEnd:
REP #$20

LDX.b #$22

.copy_next
LDA.l oam_data,X
STA.w $0800,X

DEX
DEX
BPL .copy_next

SEP #$20

JSL SetHighBitsOAM

RTS



pullpc




