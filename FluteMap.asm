pushpc
org $0AB811
LDX.b #$05 ; 6 flute spot


FluteMenuNumbers:
org $0AB75B
.chargfx
db $7F
db $79
db $6C
db $6D
db $6E
db $6F

db $7C
db $7D

.pos_x_low
db $70
db $CF
db $10
db $B8
db $f0
db $D8

db $70
db $F0

.pos_x_high
db $09
db $01
db $08
db $0e
db $03
db $0D

db $07
db $0E

.pos_y_low
db $54
db $20
db $C0
db $C0
db $00
db $00

db $30
db $80

.pos_y_high
db $03
db $07
db $07
db $07
db $0B
db $0D

db $0F
db $0F

.bits
db $80
db $40
db $20
db $10
db $08
db $04
db $02
db $01


org $0AB7CB
NOP
JSL MapHandle6Icon
STA.w $1AF0

org $1BBE4B
CMP #$000C
org $1BBE50
NOP #5
;CPX.w #$049C


org $098CA0
LDA.b $20
STA.b $00

LDA.b $22
STA.b $02
NOP #2

pullpc


MapHandle6Icon:
LDA.w $1AF0 : BMI .setTo6
CMP #$06 : BCC .return
LDA #$00
RTL

.setTo6
LDA #$05
.return
RTL



