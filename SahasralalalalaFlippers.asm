pushpc
org $05F177
JSL NewBootCheck
skip 2
LDY.b #$00
NOP 08
pullpc


NewBootCheck:
LDA $7EF356 : BNE .alreadyhaveflippers
LDA $7EF374 : AND #$07 : BNE .notallpendant




.notallpendant
.alreadyhaveflippers
RTL ; code will be handled already