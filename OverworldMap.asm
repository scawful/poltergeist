
org $008E57
LDA #WorldMap_Tiles>>16 ; bank id

org $008E84 
ADC.w #WorldMap_Tiles ; bank offset


org $00E399 

; set source address bank to 0x18
LDA.b #WorldMap_Gfx>>16 : STA.b $02

; update vram address after writes to $2119
LDA.b #$80 : STA.w $2115

; vram target address = $0000 (word)
STZ.w $2116 : STZ.w $2117

REP #$10

LDY.w #WorldMap_Gfx : STY $00

org $368000
WorldMap_Tiles:
incbin orig4quadrantmap.bin
WorldMap_Gfx:
incbin origmapgfx.bin


org $0ADB27
Palettes:
dw #$21B1, #$46DB, #$0000, #$29B0, #$214C, #$0043, #$3A55, #$150B, #$216E, #$3613
dw #$29F4, #$110B, #$0886, #$1D4C, #$14E9, #$0CA8, #$150A, #$10C9, #$0CA7, #$1D90
dw #$29D2, #$112D, #$1D6F, #$3A78, #$1D2C, #$25F4, #$0016, #$194E, #$2DD1, #$3E99
dw #$2DF3, #$10C8, #$2190, #$192C, #$531C


org $0AC589
WorldMapIcon_AdjustCoordinate:

org $0AC51C
WorldMap_HandleSpriteBlink:


org $0ABF90
.dont_draw_link
LDA.l $7EC108
PHA

LDA.l $7EC109
PHA

LDA.l $7EC10A
PHA

LDA.l $7EC10B
PHA

;Removed mirror portal draw code

;Removed pyramid open code?

;---------------------------------------------------------------------------------------------------

.draw_prizes

; Draw Amulet 1
LDA.l $7EF374 : AND #$04 : BNE .skip_draw_0
 ; X position
LDA.b #$0E : STA.l $7EC10B
LDA.b #$0E : STA.l $7EC10A
 ; Y position
LDA.b #$04 : STA.l $7EC109
LDA.b #$08 : STA.l $7EC108


;---------------------------------------------------------------------------------------------------
LDA.b #$60
BEQ .dont_adjust_0

LDA.b $1A
AND.b #$10
BNE .skip_draw_0

JSR WorldMapIcon_AdjustCoordinate

.dont_adjust_0
LDX.b #$0E
JSR WorldMap_CalculateOAMCoordinates
BCC .skip_draw_0

LDA.b #$60 : STA.b $0D
LDA.b #$32 : STA.b $0C ; Tile GFX

LDA.b #$02
BRA .continue_0

.continue_0
STA.b $0B

LDX.b #$0E
JSR WorldMap_HandleSpriteBlink


.skip_draw_0


; Draw Amulet 1
LDA.l $7EF374 : AND #$01 : BNE .skip_draw_1
 ; X position
LDA.b #$0D : STA.l $7EC10B
LDA.b #$05 : STA.l $7EC10A
 ; Y position
LDA.b #$0D : STA.l $7EC109
LDA.b #$09 : STA.l $7EC108


;---------------------------------------------------------------------------------------------------
LDA.b #$60
BEQ .dont_adjust_1

LDA.b $1A
AND.b #$10
BNE .skip_draw_1

JSR WorldMapIcon_AdjustCoordinate

.dont_adjust_1
LDX.b #$0D
JSR WorldMap_CalculateOAMCoordinates
BCC .skip_draw_1

LDA.b #$60 : STA.b $0D
LDA.b #$34 : STA.b $0C ; Tile GFX

LDA.b #$02
BRA .continue_1

.continue_1
STA.b $0B

LDX.b #$0D
JSR WorldMap_HandleSpriteBlink


.skip_draw_1




; Draw Amulet 3
LDA.l $7EF374 : AND #$02 : BNE .skip_draw_2
 ; X position
LDA.b #$09 : STA.l $7EC10B
LDA.b #$04 : STA.l $7EC10A
 ; Y position
LDA.b #$00 : STA.l $7EC109
LDA.b #$0E : STA.l $7EC108


;---------------------------------------------------------------------------------------------------
LDA.b #$60
BEQ .dont_adjust_2

LDA.b $1A
AND.b #$10
BNE .skip_draw_2

JSR WorldMapIcon_AdjustCoordinate

.dont_adjust_2
LDX.b #$0C
JSR WorldMap_CalculateOAMCoordinates
BCC .skip_draw_2

LDA.b #$60 : STA.b $0D
LDA.b #$38 : STA.b $0C ; Tile GFX

LDA.b #$02
BRA .continue_2

.continue_2
STA.b $0B

LDX.b #$0C
JSR WorldMap_HandleSpriteBlink


.skip_draw_2




; Draw Amulet 1
LDA.l $7EF37A : AND #$01 : BNE .skip_draw_3
 ; X position
LDA.b #$00 : STA.l $7EC10B
LDA.b #$17 : STA.l $7EC10A
 ; Y position
LDA.b #$06 : STA.l $7EC109
LDA.b #$01 : STA.l $7EC108


;---------------------------------------------------------------------------------------------------
LDA.b #$60
BEQ .dont_adjust_3

LDA.b $1A
AND.b #$10
BNE .skip_draw_3

JSR WorldMapIcon_AdjustCoordinate

.dont_adjust_3
LDX.b #$0B
JSR WorldMap_CalculateOAMCoordinates
BCC .skip_draw_3

LDA.b #$60 : STA.b $0D
LDA.b #$34 : STA.b $0C ; Tile GFX

LDA.b #$02
BRA .continue_3

.continue_3
STA.b $0B

LDX.b #$0B
JSR WorldMap_HandleSpriteBlink


.skip_draw_3
JMP restore_coords_and_exit



warnpc $0AC387

org $0AC38A
restore_coords_and_exit:
PLA
STA.l $7EC10B

PLA
STA.l $7EC10A

PLA
STA.l $7EC109

PLA
STA.l $7EC108

RTS

WorldMap_CalculateOAMCoordinates:





