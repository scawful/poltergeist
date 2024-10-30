pushpc
org $06899C ; LDA.l $7EF159
SpritePrep_BlindMaiden:
JSL NewSpritePrepBlindMaiden
NOP #$04


org $1EE8C4
JSL NewSpriteBlindMaiden
NOP #$02


pullpc



NewSpritePrepBlindMaiden:
LDA.l $7EF0D9
AND.b #$08
BNE .kill_the_girl

; center it on the pentagram
LDA.w $0D00, X : SEC : SBC.b #$08 : STA.w $0D00, X ; Y Coordinate Low Byte
LDA.w $0D10, X : CLC : ADC.b #$08 : STA.w $0D10, X ; X Coordinate Low Byte


RTL


.kill_the_girl
STZ.w $0DD0,X
RTL



NewSpriteBlindMaiden:
TYA
EOR.b #$03
STA.w $0EB0,X
 ; ^^^ restored code ^^^

PHB : PHK : PLB

LDA.w SprTimerE, X : BNE .skipMovement
INC.w $0E80, X
LDA.w $0E80, X : TAY
CMP.b #$2F : BCC .continue
STZ.w $0E80, X
.continue
LDA.b #$02 : STA.w SprTimerE, X 
LDA.w SineTable, Y : STA.w $0F70, X
.skipMovement

JSL Sprite_MoveLong

PLB
RTL
; small sine table since i don't feel like finding one in game already existing
SineTable: 



db $04, $05, $05, $06, $06, $06, $07, $07
db $07, $08, $08, $08, $08, $08, $08, $08
db $07, $07, $07, $06, $06, $06, $05, $05
db $04, $03, $03, $02, $02, $02, $01, $01
db $01, $00, $00, $00, $00, $00, $00, $00
db $01, $01, $01, $02, $02, $02, $03, $03







