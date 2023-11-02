
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
JMP restore_coords_and_exit ; DEBUG


; #_0AC09A: LDX.b #$01
; #_0AC09C: JSR OverworldMap_CheckForPendant
; #_0AC09F: BCS .skip_draw_1

; #_0AC0A1: JSR OverworldMap_CheckForCrystal
; #_0AC0A4: BCS .skip_draw_1

; #_0AC0A6: LDA.l $7EF3C7
; #_0AC0AA: ASL A
; #_0AC0AB: TAX

; #_0AC0AC: LDA.l WorldMapIcon_posx_spr1+1,X
; #_0AC0B0: BMI .skip_draw_1

; #_0AC0B2: STA.l $7EC10B

; #_0AC0B6: LDA.l WorldMapIcon_posx_spr1+0,X
; #_0AC0BA: STA.l $7EC10A

; #_0AC0BE: LDA.l WorldMapIcon_posy_spr1+1,X
; #_0AC0C2: STA.l $7EC109

; #_0AC0C6: LDA.l WorldMapIcon_posy_spr1+0,X
; #_0AC0CA: STA.l $7EC108

; ;---------------------------------------------------------------------------------------------------

; #_0AC0CE: LDA.l WorldMapIcon_tile_spr1+1,X
; #_0AC0D2: BEQ .dont_adjust_1

; #_0AC0D4: CMP.b #$64
; #_0AC0D6: BEQ .is_crystal_3

; #_0AC0D8: LDA.b $1A
; #_0AC0DA: AND.b #$10
; #_0AC0DC: BNE .skip_draw_1

; .is_crystal_3
; #_0AC0DE: JSR WorldMapIcon_AdjustCoordinate

; ;---------------------------------------------------------------------------------------------------

; .dont_adjust_1
; #_0AC0E1: JSR WorldMap_CalculateOAMCoordinates
; #_0AC0E4: BCC .skip_draw_1

; #_0AC0E6: LDA.l $7EF3C7
; #_0AC0EA: ASL A
; #_0AC0EB: TAX

; #_0AC0EC: LDA.l WorldMapIcon_tile_spr1+1,X
; #_0AC0F0: BEQ .is_red_x_1

; #_0AC0F2: STA.b $0D

; #_0AC0F4: LDA.l WorldMapIcon_tile_spr1+0,X
; #_0AC0F8: STA.b $0C

; #_0AC0FA: LDA.b #$02
; #_0AC0FC: BRA .continue_1

; ;---------------------------------------------------------------------------------------------------

; .is_red_x_1
; #_0AC0FE: LDA.b $1A

; #_0AC100: LSR A
; #_0AC101: LSR A
; #_0AC102: LSR A

; #_0AC103: AND.b #$03
; #_0AC105: TAX

; #_0AC106: LDA.l WorldMap_RedXChars,X
; #_0AC10A: STA.b $0D

; #_0AC10C: LDA.b #$32
; #_0AC10E: STA.b $0C

; #_0AC110: LDA.b #$00

; ;---------------------------------------------------------------------------------------------------

; .continue_1
; #_0AC112: STA.b $0B

; #_0AC114: LDX.b #$0D
; #_0AC116: JSR WorldMap_HandleSpriteBlink

; ;===================================================================================================

; .skip_draw_1
; #_0AC119: LDX.b #$02
; #_0AC11B: JSR OverworldMap_CheckForPendant
; #_0AC11E: BCS .skip_draw_2

; #_0AC120: JSR OverworldMap_CheckForCrystal
; #_0AC123: BCS .skip_draw_2

; #_0AC125: LDA.l $7EF3C7
; #_0AC129: ASL A
; #_0AC12A: TAX

; #_0AC12B: LDA.l WorldMapIcon_posx_spr2+1,X
; #_0AC12F: BMI .skip_draw_2

; #_0AC131: STA.l $7EC10B

; #_0AC135: LDA.l WorldMapIcon_posx_spr2+0,X
; #_0AC139: STA.l $7EC10A

; #_0AC13D: LDA.l WorldMapIcon_posy_spr2+1,X
; #_0AC141: STA.l $7EC109

; #_0AC145: LDA.l WorldMapIcon_posy_spr2+0,X
; #_0AC149: STA.l $7EC108

; ;---------------------------------------------------------------------------------------------------

; #_0AC14D: LDA.l WorldMapIcon_tile_spr2+1,X
; #_0AC151: BEQ .dont_adjust_2

; #_0AC153: CMP.b #$64
; #_0AC155: BEQ .is_crystal_7

; #_0AC157: LDA.b $1A
; #_0AC159: AND.b #$10
; #_0AC15B: BNE .skip_draw_2

; .is_crystal_7
; #_0AC15D: JSR WorldMapIcon_AdjustCoordinate

; ;---------------------------------------------------------------------------------------------------

; .dont_adjust_2
; #_0AC160: LDX.b #$0C
; #_0AC162: JSR WorldMap_CalculateOAMCoordinates
; #_0AC165: BCC .skip_draw_2

; #_0AC167: LDA.l $7EF3C7
; #_0AC16B: ASL A
; #_0AC16C: TAX

; #_0AC16D: LDA.l WorldMapIcon_tile_spr2+1,X
; #_0AC171: BEQ .is_red_x_2

; #_0AC173: STA.b $0D

; #_0AC175: LDA.l WorldMapIcon_tile_spr2+0,X
; #_0AC179: STA.b $0C

; #_0AC17B: LDA.b #$02
; #_0AC17D: BRA .continue_2

; ;---------------------------------------------------------------------------------------------------

; .is_red_x_2
; #_0AC17F: LDA.b $1A

; #_0AC181: LSR A
; #_0AC182: LSR A
; #_0AC183: LSR A

; #_0AC184: AND.b #$03
; #_0AC186: TAX

; #_0AC187: LDA.l WorldMap_RedXChars,X
; #_0AC18B: STA.b $0D

; #_0AC18D: LDA.b #$32
; #_0AC18F: STA.b $0C

; #_0AC191: LDA.b #$00

; ;---------------------------------------------------------------------------------------------------

; .continue_2
; #_0AC193: STA.b $0B

; #_0AC195: LDX.b #$0C
; #_0AC197: JSR WorldMap_HandleSpriteBlink

; ;===================================================================================================

; .skip_draw_2
; #_0AC19A: LDX.b #$03
; #_0AC19C: JSR OverworldMap_CheckForCrystal
; #_0AC19F: BCS .skip_draw_3

; #_0AC1A1: LDA.l $7EF3C7
; #_0AC1A5: ASL A
; #_0AC1A6: TAX

; #_0AC1A7: LDA.l WorldMapIcon_posx_spr3+1,X
; #_0AC1AB: BMI .skip_draw_3

; #_0AC1AD: STA.l $7EC10B

; #_0AC1B1: LDA.l WorldMapIcon_posx_spr3+0,X
; #_0AC1B5: STA.l $7EC10A

; #_0AC1B9: LDA.l WorldMapIcon_posy_spr3+1,X
; #_0AC1BD: STA.l $7EC109

; #_0AC1C1: LDA.l WorldMapIcon_posy_spr3+0,X
; #_0AC1C5: STA.l $7EC108

; ;---------------------------------------------------------------------------------------------------

; #_0AC1C9: LDA.l WorldMapIcon_tile_spr3+1,X
; #_0AC1CD: BEQ .dont_adjust_3

; #_0AC1CF: CMP.b #$64
; #_0AC1D1: BEQ .is_crystal_4

; #_0AC1D3: LDA.b $1A
; #_0AC1D5: AND.b #$10
; #_0AC1D7: BNE .skip_draw_3

; .is_crystal_4
; #_0AC1D9: JSR WorldMapIcon_AdjustCoordinate

; ;---------------------------------------------------------------------------------------------------

; .dont_adjust_3
; #_0AC1DC: LDX.b #$0B
; #_0AC1DE: JSR WorldMap_CalculateOAMCoordinates
; #_0AC1E1: BCC .skip_draw_3

; #_0AC1E3: LDA.l $7EF3C7
; #_0AC1E7: ASL A
; #_0AC1E8: TAX

; #_0AC1E9: LDA.l WorldMapIcon_tile_spr3+1,X
; #_0AC1ED: BEQ .is_red_x_3

; #_0AC1EF: STA.b $0D

; #_0AC1F1: LDA.l WorldMapIcon_tile_spr3+0,X
; #_0AC1F5: STA.b $0C

; #_0AC1F7: LDA.b #$02
; #_0AC1F9: BRA .continue_3

; ;---------------------------------------------------------------------------------------------------

; .is_red_x_3
; #_0AC1FB: LDA.b $1A

; #_0AC1FD: LSR A
; #_0AC1FE: LSR A
; #_0AC1FF: LSR A

; #_0AC200: AND.b #$03
; #_0AC202: TAX

; #_0AC203: LDA.l WorldMap_RedXChars,X
; #_0AC207: STA.b $0D

; #_0AC209: LDA.b #$32
; #_0AC20B: STA.b $0C

; #_0AC20D: LDA.b #$00

; ;---------------------------------------------------------------------------------------------------

; .continue_3
; #_0AC20F: STA.b $0B

; #_0AC211: LDX.b #$0B
; #_0AC213: JSR WorldMap_HandleSpriteBlink

; ;---------------------------------------------------------------------------------------------------

; .skip_draw_3
; #_0AC216: LDX.b #$04
; #_0AC218: JSR OverworldMap_CheckForCrystal
; #_0AC21B: BCS .skip_draw_4

; #_0AC21D: LDA.l $7EF3C7
; #_0AC221: ASL A
; #_0AC222: TAX

; #_0AC223: LDA.l WorldMapIcon_posx_spr4+1,X
; #_0AC227: BMI .skip_draw_4

; #_0AC229: STA.l $7EC10B

; #_0AC22D: LDA.l WorldMapIcon_posx_spr4+0,X
; #_0AC231: STA.l $7EC10A

; #_0AC235: LDA.l WorldMapIcon_posy_spr4+1,X
; #_0AC239: STA.l $7EC109

; #_0AC23D: LDA.l WorldMapIcon_posy_spr4+0,X
; #_0AC241: STA.l $7EC108

; ;---------------------------------------------------------------------------------------------------

; #_0AC245: LDA.l WorldMapIcon_tile_spr4+1,X
; #_0AC249: BEQ .dont_adjust_4

; #_0AC24B: CMP.b #$64
; #_0AC24D: BEQ .is_crystal_6

; #_0AC24F: LDA.b $1A
; #_0AC251: AND.b #$10
; #_0AC253: BNE .skip_draw_4

; .is_crystal_6
; #_0AC255: JSR WorldMapIcon_AdjustCoordinate

; ;---------------------------------------------------------------------------------------------------

; .dont_adjust_4
; #_0AC258: LDX.b #$0A
; #_0AC25A: JSR WorldMap_CalculateOAMCoordinates
; #_0AC25D: BCC .skip_draw_4

; #_0AC25F: LDA.l $7EF3C7
; #_0AC263: ASL A
; #_0AC264: TAX

; #_0AC265: LDA.l WorldMapIcon_tile_spr4+1,X
; #_0AC269: BEQ .is_red_x_4

; #_0AC26B: STA.b $0D

; #_0AC26D: LDA.l WorldMapIcon_tile_spr4+0,X
; #_0AC271: STA.b $0C

; #_0AC273: LDA.b #$02
; #_0AC275: BRA .continue_4

; .is_red_x_4
; #_0AC277: LDA.b $1A

; #_0AC279: LSR A
; #_0AC27A: LSR A
; #_0AC27B: LSR A

; #_0AC27C: AND.b #$03
; #_0AC27E: TAX

; #_0AC27F: LDA.l WorldMap_RedXChars,X
; #_0AC283: STA.b $0D

; #_0AC285: LDA.b #$32
; #_0AC287: STA.b $0C

; #_0AC289: LDA.b #$00

; ;---------------------------------------------------------------------------------------------------

; .continue_4
; #_0AC28B: STA.b $0B

; #_0AC28D: LDX.b #$0A
; #_0AC28F: JSR WorldMap_HandleSpriteBlink

; ;---------------------------------------------------------------------------------------------------

; .skip_draw_4
; #_0AC292: LDX.b #$05
; #_0AC294: JSR OverworldMap_CheckForCrystal
; #_0AC297: BCS .skip_draw_5

; #_0AC299: LDA.l $7EF3C7
; #_0AC29D: ASL A
; #_0AC29E: TAX

; #_0AC29F: LDA.l WorldMapIcon_posx_spr5+1,X
; #_0AC2A3: BMI .skip_draw_5

; #_0AC2A5: STA.l $7EC10B

; #_0AC2A9: LDA.l WorldMapIcon_posx_spr5+0,X
; #_0AC2AD: STA.l $7EC10A

; #_0AC2B1: LDA.l WorldMapIcon_posy_spr5+1,X
; #_0AC2B5: STA.l $7EC109

; #_0AC2B9: LDA.l WorldMapIcon_posy_spr5+0,X
; #_0AC2BD: STA.l $7EC108

; ;---------------------------------------------------------------------------------------------------

; #_0AC2C1: LDA.l WorldMapIcon_tile_spr5+1,X
; #_0AC2C5: BEQ .dont_adjust_5

; #_0AC2C7: CMP.b #$64
; #_0AC2C9: BEQ .is_crystal_5

; #_0AC2CB: LDA.b $1A
; #_0AC2CD: AND.b #$10
; #_0AC2CF: BNE .skip_draw_5

; .is_crystal_5
; #_0AC2D1: JSR WorldMapIcon_AdjustCoordinate

; ;---------------------------------------------------------------------------------------------------

; .dont_adjust_5
; #_0AC2D4: LDX.b #$09

; #_0AC2D6: JSR WorldMap_CalculateOAMCoordinates
; #_0AC2D9: BCC .skip_draw_5

; #_0AC2DB: LDA.l $7EF3C7
; #_0AC2DF: ASL A
; #_0AC2E0: TAX

; #_0AC2E1: LDA.l WorldMapIcon_tile_spr5+1,X
; #_0AC2E5: BEQ .is_red_x_5

; #_0AC2E7: STA.b $0D

; #_0AC2E9: LDA.l WorldMapIcon_tile_spr5+0,X
; #_0AC2ED: STA.b $0C

; #_0AC2EF: LDA.b #$02
; #_0AC2F1: BRA .continue_5

; ;---------------------------------------------------------------------------------------------------

; .is_red_x_5
; #_0AC2F3: LDA.b $1A
; #_0AC2F5: LSR A
; #_0AC2F6: LSR A
; #_0AC2F7: LSR A

; #_0AC2F8: AND.b #$03
; #_0AC2FA: TAX

; #_0AC2FB: LDA.l WorldMap_RedXChars,X
; #_0AC2FF: STA.b $0D

; #_0AC301: LDA.b #$32
; #_0AC303: STA.b $0C

; #_0AC305: LDA.b #$00

; ;---------------------------------------------------------------------------------------------------

; .continue_5
; #_0AC307: STA.b $0B

; #_0AC309: LDX.b #$09
; #_0AC30B: JSR WorldMap_HandleSpriteBlink

; ;---------------------------------------------------------------------------------------------------

; .skip_draw_5
; #_0AC30E: LDX.b #$06
; #_0AC310: JSR OverworldMap_CheckForCrystal
; #_0AC313: BCS .restore_coords_and_exit

; #_0AC315: LDA.l $7EF3C7
; #_0AC319: ASL A
; #_0AC31A: TAX

; #_0AC31B: LDA.l WorldMapIcon_posx_spr6+1,X
; #_0AC31F: BMI .restore_coords_and_exit

; #_0AC321: STA.l $7EC10B

; #_0AC325: LDA.l WorldMapIcon_posx_spr6+0,X
; #_0AC329: STA.l $7EC10A

; #_0AC32D: LDA.l WorldMapIcon_posy_spr6+1,X
; #_0AC331: STA.l $7EC109

; #_0AC335: LDA.l WorldMapIcon_posy_spr6+0,X
; #_0AC339: STA.l $7EC108

; ;---------------------------------------------------------------------------------------------------

; #_0AC33D: LDA.l WorldMapIcon_tile_spr6+1,X
; #_0AC341: BEQ .dont_adjust_6

; #_0AC343: CMP.b #$64
; #_0AC345: BEQ .is_crystal_2

; #_0AC347: LDA.b $1A
; #_0AC349: AND.b #$10
; #_0AC34B: BNE .restore_coords_and_exit

; .is_crystal_2
; #_0AC34D: JSR WorldMapIcon_AdjustCoordinate

; ;---------------------------------------------------------------------------------------------------

; .dont_adjust_6
; #_0AC350: LDX.b #$08
; #_0AC352: JSR WorldMap_CalculateOAMCoordinates
; #_0AC355: BCC .restore_coords_and_exit

; #_0AC357: LDA.l $7EF3C7
; #_0AC35B: ASL A
; #_0AC35C: TAX

; #_0AC35D: LDA.l WorldMapIcon_tile_spr6+1,X
; #_0AC361: BEQ .is_red_x_6

; #_0AC363: STA.b $0D

; #_0AC365: LDA.l WorldMapIcon_tile_spr6+0,X
; #_0AC369: STA.b $0C

; #_0AC36B: LDA.b #$02
; #_0AC36D: BRA .continue_6

; ;---------------------------------------------------------------------------------------------------

; .is_red_x_6
; #_0AC36F: LDA.b $1A

; #_0AC371: LSR A
; #_0AC372: LSR A
; #_0AC373: LSR A

; #_0AC374: AND.b #$03
; #_0AC376: TAX

; #_0AC377: LDA.l WorldMap_RedXChars,X
; #_0AC37B: STA.b $0D

; #_0AC37D: LDA.b #$32
; #_0AC37F: STA.b $0C

; #_0AC381: LDA.b #$00

; ;---------------------------------------------------------------------------------------------------

; .continue_6
; #_0AC383: STA.b $0B

; #_0AC385: LDX.b #$08
; #_0AC387: JSR WorldMap_HandleSpriteBlink

; ;---------------------------------------------------------------------------------------------------


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





