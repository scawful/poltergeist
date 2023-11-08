; ==============================================================================
; LW OVERWORLD MAP
; ==============================================================================

org $008E54 ;STZ $2115
JSL DMAOwMap
RTS


org $00E399 
JSL DMAOwMapGfx
RTL

; ==============================================================================
; DW OVERWORLD MAP
; ==============================================================================
org $008FF3
RTS ; do not do anything during the DW update we'll handle it in the LW routine




org $368000
LWWorldMap_Tiles:
incbin LWMapFinal.bin
LWWorldMap_Gfx:
incbin LWMapGfxFinal.bin

org $378000
DWWorldMap_Tiles:
incbin DWMapFinal.bin
DWWorldMap_Gfx:
incbin DWMapGfxFinal.bin


DMAOwMap:
LDA $8A : AND #$40 : BEQ .LWMAP
JMP .DWMAP
.LWMAP
STZ.w $2115

LDA.b #LWWorldMap_Tiles>>16
STA.w $4304

REP #$20

LDA.w #$1800
STA.w $4300

STZ.b $04
STZ.b $02

LDY.b #$01
LDX.b #$00

.next_quadrant
LDA.w #$0020
STA.b $06

LDA.l .vram_offset,X
STA.b $00

.next_row
LDA.b $00
STA.w $2116

CLC
ADC.w #$0080
STA.b $00

LDA.b $02
CLC
ADC.w #LWWorldMap_Tiles
STA.w $4302

LDA.w #$0020
STA.w $4305

STY.w $420B

CLC
ADC.b $02
STA.b $02

DEC.b $06
BNE .next_row

INC.b $04
INC.b $04

LDX.b $04
CPX.b #$08
BNE .next_quadrant

SEP #$20

RTL

.vram_offset
dw $0000, $0020, $1000, $1020

.DWMAP
STZ.w $2115

LDA.b #DWWorldMap_Tiles>>16
STA.w $4304

REP #$20

LDA.w #$1800
STA.w $4300

STZ.b $04
STZ.b $02

LDY.b #$01
LDX.b #$00

.next_quadrant2
LDA.w #$0020
STA.b $06

LDA.l .vram_offset,X
STA.b $00

.next_row2
LDA.b $00
STA.w $2116

CLC
ADC.w #$0080
STA.b $00

LDA.b $02
CLC
ADC.w #DWWorldMap_Tiles
STA.w $4302

LDA.w #$0020
STA.w $4305

STY.w $420B

CLC
ADC.b $02
STA.b $02

DEC.b $06
BNE .next_row2

INC.b $04
INC.b $04

LDX.b $04
CPX.b #$08
BNE .next_quadrant2

SEP #$20

RTL



DMAOwMapGfx:

LDA $8A : AND #$40 : BNE .DWMAP
LDA.b #LWWorldMap_Gfx>>16 : STA $02

LDA.b #$80 : STA $2115

STZ $2116 : STZ $2117

REP #$10

LDY.w #LWWorldMap_Gfx : STY $00

LDY.w #$0000

.writeChr

LDA [$00], Y : STA $2119 : INY
LDA [$00], Y : STA $2119 : INY
LDA [$00], Y : STA $2119 : INY
LDA [$00], Y : STA $2119 : INY

CPY.w #$4000 : BNE .writeChr

SEP #$10

RTL

.DWMAP


LDA.b #DWWorldMap_Gfx>>16 : STA $02

LDA.b #$80 : STA $2115

STZ $2116 : STZ $2117

REP #$10

LDY.w #DWWorldMap_Gfx : STY $00

LDY.w #$0000

.writeChr2

LDA [$00], Y : STA $2119 : INY
LDA [$00], Y : STA $2119 : INY
LDA [$00], Y : STA $2119 : INY
LDA [$00], Y : STA $2119 : INY

CPY.w #$4000 : BNE .writeChr2

SEP #$10

RTL


SpritePalette:
    REP #$20

    ; Pendant 1 green -> orange.
    LDA.w #hexto555($A9A9A9) : STA.l $7EC696
    LDA.w #hexto555($E8E8E8) : STA.l $7EC698

    LDA.w #hexto555($FFB345) : STA.l $7EC69C
    LDA.w #hexto555($D58200) : STA.l $7EC69E

    ; Pendant 2 blue -> purple.
    LDA.w #hexto555($A9A9A9) : STA.l $7EC656
    LDA.w #hexto555($E8E8E8) : STA.l $7EC658

    LDA.w #hexto555($AD45FF) : STA.l $7EC65C
    LDA.w #hexto555($7C00D5) : STA.l $7EC65E

    ; Pendant 3 red -> green.
    LDA.w #hexto555($A9A9A9) : STA.l $7EC636
    LDA.w #hexto555($E8E8E8) : STA.l $7EC638

    LDA.w #hexto555($15FF36) : STA.l $7EC63C
    LDA.w #hexto555($00B51E) : STA.l $7EC63E

    ; Pendant 4 crystal -> yellow.
    LDA.w #hexto555($F8F8F8) : STA.l $7EC6D2

    LDA.w #hexto555($A9A9A9) : STA.l $7EC6D6
    LDA.w #hexto555($E8E8E8) : STA.l $7EC6D8
    LDA.w #hexto555($282828) : STA.l $7EC6DA
    LDA.w #hexto555($FFED23) : STA.l $7EC6DC
    LDA.w #hexto555($BFB400) : STA.l $7EC6DE


    SEP #$20

    ;JSL $0ED6C0

RTL


org $0ABA67
JSL SpritePalette




org $0ADB27
LWPalettes:
dw $0000, $0CA8, $150A, $10C9, $0CA7, $0886, $110B, $0043, $1D90, $29D2, $112D, $21B1, $1D6F, $25F4, $150B, $194E
dw $29F4, $1D2C, $3A78, $1D4C, $2DD1, $3E99, $0016, $216E, $3613, $14E9, $10C8, $2DF3, $192C, $2190, $531C

org $0ADC27
DWPalettes:
dw $0000, $0CA8, $10C9, $0CA7, $0043, $150A, $0886, $110B, $21B1, $112D, $29F4, $1D2C, $3A78, $46DB, $3A55, $29B0
dw $214C, $150B, $531C, $3613, $216E, $1D90, $29D2, $194E, $1D6F, $25F4, $1D4C, $0016, $14EA


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
LDA.b $8A : AND.b #$40 : BEQ .lwprizes

 ; X position
LDA.b #$00 : STA.l $7EC10B
LDA.b #$89 : STA.l $7EC10A ; Upper nybble control Zoomed low X pos
 ; Y position
LDA.b #$00 : STA.l $7EC109
LDA.b #$E4 : STA.l $7EC108 ; Upper nybble control Zoomed low Y pos
 ; Tile GFX
LDA.b #$66 : STA.b $0D
LDA.b #$34 : STA.b $0C
; Tile Size
LDA.b #$02 : STA.b $0B ; 02 = 16x16, 00 = 8x8 
LDA.b #$0E : STA.l $7EC025 ; OAM Slot used

JSR HandleMapDrawIcon

.skip_draw_dw
JMP restore_coords_and_exit

 .lwprizes
; Draw Amulet 1
LDA.l $7EF374 : AND #$04 : BNE .skip_draw_0
 ; X position
LDA.b #$0E : STA.l $7EC10B
LDA.b #$3E : STA.l $7EC10A
 ; Y position
LDA.b #$04 : STA.l $7EC109
LDA.b #$68 : STA.l $7EC108
 ; Tile GFX
LDA.b #$60 : STA.b $0D
LDA.b #$38 : STA.b $0C
; Tile Size
LDA.b #$02 : STA.b $0B ; 02 = 16x16, 00 = 8x8 
LDA.b #$0E : STA.l $7EC025 ; OAM Slot used
JSR HandleMapDrawIcon

.skip_draw_0


; Draw Amulet 1
LDA.l $7EF374 : AND #$02 : BNE .skip_draw_1
 ; X position
LDA.b #$0D : STA.l $7EC10B
LDA.b #$05 : STA.l $7EC10A
 ; Y position
LDA.b #$0D : STA.l $7EC109
LDA.b #$09 : STA.l $7EC108

LDA.b #$60 : STA.b $0D
LDA.b #$34 : STA.b $0C ; Tile GFX

LDA.b #$02 : STA.b $0B ; 02 = 16x16, 00 = 8x8 
LDA.b #$0D : STA.l $7EC025

JSR HandleMapDrawIcon
.skip_draw_1




; Draw Amulet 3
LDA.l $7EF374 : AND #$01 : BNE .skip_draw_2
 ; X position
LDA.b #$09 : STA.l $7EC10B
LDA.b #$34 : STA.l $7EC10A
 ; Y position
LDA.b #$00 : STA.l $7EC109
LDA.b #$0E : STA.l $7EC108

LDA.b #$60 : STA.b $0D
LDA.b #$32 : STA.b $0C ; Tile GFX

LDA.b #$02 : STA.b $0B ; 02 = 16x16, 00 = 8x8 
LDA.b #$0C : STA.l $7EC025



JSR HandleMapDrawIcon
.skip_draw_2


; Draw Amulet 1
LDA.l $7EF37A : AND #$01 : BNE .skip_draw_3
 ; X position
LDA.b #$00 : STA.l $7EC10B
LDA.b #$87 : STA.l $7EC10A
 ; Y position
LDA.b #$06 : STA.l $7EC109
LDA.b #$01 : STA.l $7EC108

LDA.b #$60 : STA.b $0D
LDA.b #$3C : STA.b $0C ; Tile GFX

LDA.b #$02 : STA.b $0B ; 02 = 16x16, 00 = 8x8 
LDA.b #$0B : STA.l $7EC025

JSR HandleMapDrawIcon
.skip_draw_3



; Draw Flute X
LDA.l $7EF34C : CMP #$01 : BNE .skip_draw_flute
 ; X position
LDA.b #$09 : STA.l $7EC10B
LDA.b #$00 : STA.l $7EC10A
 ; Y position
LDA.b #$02 : STA.l $7EC109
LDA.b #$74 : STA.l $7EC108

LDA.b #$68 : STA.b $0D
LDA.b #$3C : STA.b $0C ; Tile GFX

LDA.b #$00 : STA.b $0B ; 02 = 16x16, 00 = 8x8 
LDA.b #$0A : STA.l $7EC025

JSR HandleMapDrawIcon_noflash
.skip_draw_flute




JMP restore_coords_and_exit






HandleMapDrawIcon:
LDA.b $1A
AND.b #$10
BNE .skip_draw ; Timer to make it flash
.noflash
JSR WorldMapIcon_AdjustCoordinate
LDA.l $7EC025 : TAX
JSR WorldMap_CalculateOAMCoordinates
BCC .skip_draw
LDA.l $7EC025 : TAX
LDA.b #$02
JSR WorldMap_HandleSpriteBlink
.skip_draw
RTS



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

; ==============================================================================
