pushpc

org $1EA742 ; LDA $0E90, X : BNE .is_flying_tile
JML NewFlyingTileCheck
NOP #$01
Pirogusu:

org $06DC54
Sprite_DrawShadowLong:

org $1EBBBE
ReturnTile:
org $1EBBC1
ReturnPot:


org $1EBBDB ; LDA $0D10, X : STA $00
JSL FlyingPotLogic
NOP #$01


org $1EBC4F ; LDA $0DF0, X : BNE .delay
JML NewPotRising
NOP #$01

org $1EBC6F
NewFlyingPotDelayReturn:


org $1EBC6F ; INC $0E80, X : LDA $0E80, X
JML IsItSpinning
NOP #$02
spinningtile:


pullpc

IsItSpinning:
LDA.w $0E30, X : BEQ .flyingtile
JML $1EBC89 ; RTS not spinning
.flyingtile
INC $0E80, X : LDA $0E80, X
JML spinningtile


NewFlyingTileCheck:
LDA.w $0E90, X : BEQ .maybepirogusu
;JML $1EBBB9 ; jump to flying tile code
JML PotOrTile

.maybepirogusu
LDA.w $0E30, X : BEQ .Pirogusu

; set a bunch of parameters and set $0E90, X to on
LDA.b #$01 : STA $0E90, X ; will fall back on noraml flying tile code
; this portion will only be ran once

LDA.w $0F60, X : ORA #$40 : STA.w $0F60, X

LDA.b #$04 : STA.w $0E50, X

STZ.w $0BE0, X
STZ.w $0E50, X

STA.w $0E40, X
STA.w $0CD2, X
LDA.b #$08 : STA.w $0CAA, X
LDA.b #$0C : STA.w $0F50, X
REP #$20
LDA $0FDA : SEC : SBC #$0003 : STA $00
SEP #$20
LDA $00 : STA $0D00, X
LDA $01 : STA $0D20, X
LDA #$02 : STA $0E40, X
JML PotOrTile


.Pirogusu
JML Pirogusu

NewPotRising:
LDA.w $0E30, X : BEQ .flyingtile
LDA $0DF0, X : CMP #$3F : BNE +
JML $1EBC54
+

JML $1EBC63

.flyingtile
LDA $0DF0, X : BNE .delay
JML $1EBC54
.delay
JML $1EBC63



FlyingPotLogic:
LDA $0D10, X : STA $00 ; restored code
LDA.w $0E30, X : BEQ .flyingtile
PLA : PLA : PLA ; pop the RTL
; Waiting Pot here
REP #$20
LDA $0FD8 ; Sprite X
CLC : SBC $22 ; - Player X
BPL +
EOR #$FFFF
+
STA $00 ; Distance X (ABS)

LDA $0FDA ; Sprite Y
CLC : SBC $20 ; - Player Y
BPL +
EOR #$FFFF
+
; Add it back to X Distance
CLC : ADC $00 : STA $02 ; distance total X, Y (ABS)

CMP #$0050 : BCS .toofar
SEP #$20
LDA.b #$80 : STA $0DF0, X
INC.w $0D80, X ; increase sprite state
.toofar
SEP #$20
JML $1EBC00



.flyingtile
RTL










PotOrTile:
LDA.b #$30 : STA $0B89, X

LDA.w $0E30, X : BEQ .tile

JSL DrawPot
LDA $0D80, X : BEQ +
JSL Sprite_DrawShadowLong
+
JML ReturnPot
.tile
JML ReturnTile



DrawPot:
PHB : PHK : PLB
JSL Sprite_PrepOamCoord
LDA #$04
JSL OAM_AllocateFromRegionB
;JSL Sprite_OAM_AllocateDeferToPlayer

LDA $0DC0, X : CLC : ADC $0D90, X : TAY;Animation Frame
LDA .start_index, Y : STA $06


PHX
LDX .nbr_of_tiles, Y ;amount of tiles -1
LDY.b #$00
.nextTile

PHX ; Save current Tile Index?
    
TXA : CLC : ADC $06 ; Add Animation Index Offset

PHA ; Keep the value with animation index offset?

ASL A : TAX 

REP #$20

LDA $00 : CLC : ADC .x_offsets, X : STA ($90), Y
AND.w #$0100 : STA $0E 
INY
LDA $02 : CLC : ADC .y_offsets, X : STA ($90), Y
CLC : ADC #$0010 : CMP.w #$0100
SEP #$20
BCC .on_screen_y

LDA.b #$F0 : STA ($90), Y ;Put the sprite out of the way
STA $0E
.on_screen_y

PLX ; Pullback Animation Index Offset (without the *2 not 16bit anymore)
INY
LDA .chr, X : STA ($90), Y
INY
LDA .properties, X : STA ($90), Y

PHY 
    
TYA : LSR #2 : TAY
    
LDA .sizes, X : ORA $0F : STA ($92), Y ; store size in oam buffer
    
PLY : INY
    
PLX : DEX : BPL .nextTile

PLX

PLB
RTL



.start_index
db $00
.nbr_of_tiles
db 0
.x_offsets
dw 0
.y_offsets
dw 0
.chr
db $46
.properties
db $3C
.sizes
db $02


