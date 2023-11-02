pushpc
org $1EF204 ; check overlay of area00 for World MAP
LDA.l $7EF280

org $1EF20A
LDA.b #$1E ; Price of the map (30 rupees)

org $1EF213
JSL NewItemGiveShop
NOP #1

org $1EF3DE
dw 0, 16 : db $03, $02, $00, $00 ; 3
dw 0, 16 : db $03, $02, $00, $00 ; 3
dw 8, 16 : db $30, $02, $00, $00 ; 0
dw 0, 0  : db $42, $03, $00, $02 ; item small shield
dw 0, 12 : db $6C, $03, $00, $02 ; shadow

pullpc

;#_1EF213: STZ.w $0DD0,X
;#_1EF216: LDY.b #$04 ; ITEMGET 04


NewItemGiveShop:
STZ.w $0DD0,X
LDY.b #$33 ; ITEMGET 33 ( MAP )
LDA #$01 : STA $7EF280 ; set area 00 to non-zero
RTL



