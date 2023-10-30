pushpc
org $05F177
JSL NewBootCheck
skip 2
LDY.b #$00
NOP #8

org $05F1FB
LDY.b #$1E ; give flippers

STZ $02E9

JSL Link_ReceiveItem

INC $0D80, X

LDA.b #$03 : STA $7EF3C7

RTS

pullpc


NewBootCheck:
LDA $7EF356 : BNE .alreadyhaveflippers
LDA $7EF374 : AND #$07 : BNE .notallpendant
LDA $7EF37A : AND #$01 : BNE .notallpendant
RTL ; we have everything just RTL vanilla code will handle the rest

.notallpendant
.alreadyhaveflippers
RTL ; code will be handled already