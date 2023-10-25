;=====================================================================================
;The Legend of Zelda: Omega v2.00 ASM
;By Letterbomb, Zarby89, Jared_Brian_
;=====================================================================================

lorom
org $2A8000

;-------------------------------------------------------------------------------------
;L2 Shield Menu Palette Change
;-------------------------------------------------------------------------------------

pushpc

org $0DF872
    db $28
org $0DF876

    db $28
org $0DF874

    db $68
org $0DF878

    db $68

pullpc

;-------------------------------------------------------------------------------------
;L2 Tunic Palette Change
;-------------------------------------------------------------------------------------

pushpc

org $0DF88A
    db $30
    
org $0DF88C
    db $70

org $0DF88E
    db $30

org $0DF890
    db $70

pullpc

;-------------------------------------------------------------------------------------
;L1 Tunic Palette Change
;-------------------------------------------------------------------------------------

pushpc

org $0DF884
db $6C

org $0DF886
db $2C

org $0DF882
db $2C

org $0DF888
db $6C

pullpc

;-------------------------------------------------------------------------------------
;World Map Disable (TEMP CODE)
;-------------------------------------------------------------------------------------

pushpc

org $0288FD ; Replace a BEQ by a BRA (dungeon map removed)
db $80

org $02A55E ; Replace a BEQ by a BRA (overworld map removed)
db $80

pullpc

;-------------------------------------------------------------------------------------
;Sword and Shield Textbox Fix
;-------------------------------------------------------------------------------------

pushpc

org $08C2DD
dw $FFFF

pullpc

;-------------------------------------------------------------------------------------
;Intro Prison Palette
;-------------------------------------------------------------------------------------

pushpc

org $0CF002
db $12

pullpc

;-------------------------------------------------------------------------------------
;Intro Throne Room Blockset
;-------------------------------------------------------------------------------------

pushpc

org $0CEF91 ; The Blockset for the Throne Room in the Intro.
db $0C ; Change to whatever Blockset you want.

pullpc

;-------------------------------------------------------------------------------------
;Intro Agahnim Room Blockset
;-------------------------------------------------------------------------------------

pushpc

org $0CF08C ; The Blockset for Agahnim's room in the Intro.
db $09 ; Change to whatever Blockset you want.

pullpc

;-------------------------------------------------------------------------------------
;Tavern Backdoor Fix
;-------------------------------------------------------------------------------------

pushpc

org $02D7AA
db $FF

pullpc

;-------------------------------------------------------------------------------------
;New Equipment Menu Code
;-------------------------------------------------------------------------------------

pushpc

org $0DE372
DrawItem:

org $0DED09
; $6ED09 - "EQUIPMENT"
.equipmentChars
dw $2479, $247A, $247B, $247C, $248C, $24F5, $24F5, $24F5

; $6ED19 - "DUNGEON ITEM"
.dungeonChars
dw $2469, $246A, $246B, $246C, $246D, $246E, $246F, $24F5

org $0DED29
DrawEquipment:
{
    REP #$30
        
    ; Draw the 4 corners of the border for this section
    LDA.w #$28FB : AND $00 : STA $154C
    ORA.w #$8000 : STA $174C
    ORA.w #$4000 : STA $1772
    EOR.w #$8000 : STA $1572
        
    LDX.w #$0000
    LDY.w #$0006
    
    .drawVerticalEdges
        LDA.w #$28FC : AND $00 : STA $158C, X
        ORA.w #$4000 : STA $15B2, X
        
        TXA : CLC : ADC.w #$0040 : TAX
        
    DEY : BPL .drawVerticalEdges
        
    LDX.w #$0000
    LDY.w #$0011
    
    .drawHorizontalEdges
        LDA.w #$28F9 : AND $00 : STA $154E, X
        ORA.w #$8000 : STA $174E, X
        
    INX #2 : DEY : BPL .drawHorizontalEdges
        
    LDX.w #$0000
    LDY.w #$0011
    LDA.w #$24F5
    
    .drawBoxInterior
        STA $158E, X : STA $15CE, X : STA $160E, X : STA $164E, X
        STA $168E, X : STA $16CE, X : STA $170E, X
        
    INX #2 : DEY : BPL .drawBoxInterior
        
    LDX.w #$0000
    LDY.w #$0000
    
    LDA.w #$20D7 : AND $00
    
    .drawDashedSeparator
        STA $114E, X
        
    INX #2 : DEY : BPL .drawDashedSeparator
        
    LDX.w #$0000
    LDY.w #$0006
    
    .drawBoxTitle
        LDA $ED09, X : AND $00 : STA $158E, X
        LDA $ED19, X : AND $00 : STA $15A4, X
        
    INX #2 : DEY : BPL .drawBoxTitle
        
LDA.w #$2122 : STA $1154

  LDA.w #$1624 : STA $00
  LDA $7EF36B : AND.w #$00FF : STA $02
  LDA.w #$F911 : STA $04
        
  JSR DrawItem
    
    REP #$30
        
    LDA.w #$1612 : STA $00
        
    LDA $7EF359 : AND.w #$00FF : CMP.w #$00FF : BNE .hasSword
        LDA.w #$0000
    
    .hasSword
    
                   STA $02
    LDA.w #$F839 : STA $04
        
    JSR DrawItem
        
    SEP #$30
        
    RTS
}

warnpc $0DEE21

pullpc

;-------------------------------------------------------------------------------------
;Item Moving Code
;-------------------------------------------------------------------------------------

pushpc

org $0DEE24
db $18 
db $16 ; Shield Move
org $0DEE3F
db $1E 
db $16 ; Tunic Move
org $0DEE76
db $EC ; Big Key Move
org $0DEEA2
db $EC
db $15 ; Map Move
org $0DEF53
db $6C ; Compass Move
org $0DECEC
db $E4 ; Moon Pearl Move
org $0DE7BA
db $D8 ; Gloves Move
org $0DE7D0
db $D2 ; Pegasus Boots Move
org $0DE7E6
db $DE ; Zora Flippers Move

pullpc

;-------------------------------------------------------------------------------------
;New Do Menu Code
;-------------------------------------------------------------------------------------

pushpc

org $0DE6B6
    DrawAbilityText:
    {
        REP #$30
        
        LDX.w #$0000
        LDY.w #$0000
        LDA.w #$20F2
    
    .drawBoxInterior
    
        STA $115A, X : STA $114A, X
        STA $160E, X : STA $164E, X
        STA $168E, X : STA $16CE, X
        
        STA $170C, X : INX #2
        
        DEY : BPL .drawBoxInterior
        
        ; get data from ability variable (set of flags for each ability)
        LDA $7EF378 : AND.w #$FF00 : STA $02
        
        LDA.w #$0003 : STA $04
        
        LDY.w #$0000 : TYX
    
    .nextLine
    
        LDA.w #$0004 : STA $06
    
    .nextAbility
    
        ASL $02 : BCC .lacksAbility
        
        ; Draws the ability strings if Link has the ability
        ; (2 x 5 tile rectangle for each ability)
        LDA $F959, X : STA $158C, Y
        LDA $F95B, X : STA $1554, Y
        LDA $F95D, X : STA $158C, Y
        LDA $F95F, X : STA $158C, Y
        LDA $F961, X : STA $158C, Y
        LDA $F963, X : STA $15CC, Y
        LDA $F965, X : STA $15CC, Y
        LDA $F967, X : STA $15CC, Y
        LDA $F969, X : STA $15CC, Y
        LDA $F96B, X : STA $15CC, Y
    
    .lacksAbility
    
        TXA : CLC : ADC.w #$0014 : TAX
        TYA : CLC : ADC.w #$000A : TAY
        
        DEC $06 : BNE .nextAbility
        
        TYA : CLC : ADC.w #$0058 : TAY
        
        DEC $04 : BNE .nextLine
        
        ; draw the 4 corners of the box containing the ability tiles
        LDA.w #$2121 : AND $00 : STA $1152
        ORA.w #$8000 : STA $1164
        ORA.w #$4000 : STA $1166
        EOR.w #$8000 : STA $1572
        
        LDX.w #$0000
        LDY.w #$0000
    
    .drawVerticalEdges
    
        LDA.w #$2083 : AND $00 : STA $1156, X
        ORA.w #$2000 : STA $1144, X
        
        TXA : CLC : ADC.w #$0040 : TAX
        
        DEY : BPL .drawVerticalEdges
        
        LDX.w #$0000
        LDY.w #$0000
    
    .drawHorizontalEdges
    
        LDA.w #$2123 : AND $00 : STA $1158, X
        ORA.w #$8000 : STA $174E, X
        
        INX #2
        
        DEY : BPL .drawHorizontalEdges
        
        ; Draw 'A' button icon
        LDA.w #$2124 : STA $115E
        LDA.w #$20F0 : STA $1146
        LDA.w #$20F1 : STA $1148
        LDA.w #$20D4 : STA $1160
        
        SEP #$30
        
        RTS
    }

warnpc $0DE7B7

pullpc

;-------------------------------------------------------------------------------------
;Pendant/Crystal Menu Code
;-------------------------------------------------------------------------------------

pushpc

org $0DE860

    ; $6E860-$6E9C7 DATA
    ; Progress box data

    ; Pendants
    ; $6E860
    dw $3CFB, $3CF9, $3CF9, $3CF9, $3CF9, $3CF9, $3CF9, $3CF9, $3CF9, $7CFB
    ; $6E874
    dw $3CFC, $2521, $2522, $2523, $2524, $253F, $24F5, $24F5, $24F5, $7CFC
    ; $6E888
    dw $3CFC, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $7CFC
    ; $6E89C
    dw $3CFC, $24F5, $24F5, $24F5, $213B, $213C, $24F5, $24F5, $24F5, $7CFC
    ; $6E8B0
    dw $3CFC, $24F5, $24F5, $24F5, $213D, $213E, $24F5, $24F5, $24F5, $7CFC
    ; $6E8C4
    dw $3CFC, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $7CFC
    ; $6E8D8
    dw $3CFC, $24F5, $213B, $213C, $24F5, $24F5, $213B, $213C, $24F5, $7CFC
    ; $6E8EC
    dw $3CFC, $24F5, $213D, $213E, $24F5, $24F5, $213D, $213E, $24F5, $7CFC
    ; $06E900
    dw $BCFB, $BCF9, $BCF9, $BCF9, $BCF9, $BCF9, $BCF9, $BCF9, $BCF9, $FCFB

    ; Crystals
    ; $06E914
    dw $3CFB, $3CF9, $3CF9, $3CF9, $3CF9, $3CF9, $3CF9, $3CF9, $3CF9, $7CFB
    ; $06E928
    dw $3CFC, $252F, $2534, $2535, $2536, $2537, $24F5, $24F5, $24F5, $7CFC
    ; $06E93C
    dw $3CFC, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $7CFC
    ; $06E950
    dw $3CFC, $24F5, $213B, $213C, $24F5, $24F5, $213B, $213C, $24F5, $7CFC
    ; $06E964
    dw $3CFC, $24F5, $213D, $213E, $24F5, $24F5, $213D, $213E, $24F5, $7CFC
    ; $06E978
    dw $3CFC, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $7CFC
    ; $06E98C
    dw $3CFC, $24F5, $213B, $213C, $24F5, $24F5, $E147, $A147, $24F5, $7CFC
    ; $06E9A0
    dw $3CFC, $24F5, $213D, $213E, $24F5, $24F5, $2146, $2147, $24F5, $7CFC
    ; $06E9B4
    dw $BCFB, $BCF9, $BCF9, $BCF9, $BCF9, $BCF9, $BCF9, $BCF9, $BCF9, $FCFB

warnpc $0DE9C8

pullpc

;-------------------------------------------------------------------------------------
;Item Selected Box
;-------------------------------------------------------------------------------------

pushpc

org $0DE647
    ; *$6E647-$6E6B5 LOCAL
    DrawUnknownBox:
    {
        REP #$30
        
        ; draw 4 corners of a box
        LDA.w #$2CFB : AND $00 : STA $116A
        ORA.w #$8000 : STA $12AA
        ORA.w #$4000 : STA $12BC
        EOR.w #$8000 : STA $117C
        
        LDX.w #$0000 
        LDY.w #$0003
    
    ; the lines these tiles make are vertical
    .drawBoxVerticalSides
    
        LDA.w #$2CFC : AND $00 : STA $11AA, X
        ORA.w #$4000 : STA $11BC, X
        
        TXA : CLC : ADC.w #$0040 : TAX
        
        DEY : BPL .drawBoxVerticalSides
        
        LDX.w #$0000
        LDY.w #$0007
    
    ; I say horizontal b/c the lines the sides make are horizontal
    .drawBoxHorizontalSides
    
        LDA.w #$2CF9 : AND $00 : STA $116C, X
        ORA.w #$8000 : STA $12AC, X
        
        INX #2
        
        DEY : BPL .drawBoxHorizontalSides
        
        LDX.w #$0000
        LDY.w #$0007
        LDA.w #$24F5
    
    .drawBoxInterior
    
        STA $11AC, X : STA $11EC, X : STA $122C, X : STA $126C, X
        
        INX #2
        
        DEY : BPL .drawBoxInterior
        
        SEP #$30
        
        RTS
    }

warnpc $0DE6B6

pullpc

;-------------------------------------------------------------------------------------
;Y Item Box
;-------------------------------------------------------------------------------------

pushpc

org $0DE3D9
    ;*$6E3D9-$6E646 LOCAL
    DrawYButtonItems:
    {
        REP #$30
        
        ; draw 4 corners of a box (for the equippable item section)
        LDA.w #$20FB : AND $00 : STA $11C2
        ORA.w #$8000 : STA $14C2
        ORA.w #$4000 : STA $14E6
        EOR.w #$8000 : STA $11E6
        
        LDX.w #$0000
        LDY.w #$000A
    
    .drawVerticalEdges
    
        LDA.w #$20FC : AND $00 : STA $1202, X
        ORA.w #$4000 : STA $1226, X
        
        TXA : CLC : ADC.w #$0040 : TAX
        
        DEY : BPL .drawVerticalEdges
        
        LDX.w #$0000
        LDY.w #$0010
    
    .drawHorizontalEdges
    
        LDA.w #$20F9 : AND $00 : STA $11C4, X
        ORA.w #$8000 : STA $14C4, X
        
        INX #2
        
        DEY : BPL .drawHorizontalEdges
        
        LDX.w #$0000
        LDY.w #$0010
        LDA.w #$24F5
    
    .drawBoxInterior
    
        STA $1204, X : STA $1204, X : STA $1204, X : STA $1244, X
        STA $1284, X : STA $12C4, X : STA $1304, X : STA $1344, X
        STA $1384, X : STA $13C4, X : STA $1404, X : STA $1444, X
        STA $1484, X
        
        INX #2
        
        DEY : BPL .drawBoxInterior
        
        ; Draw 'Y' button Icon?
        LDA.w #$20D5 : STA $1162
        LDA.w #$2082 : STA $1142
        LDA.w #$246E : STA $1204
        LDA.w #$246F : STA $1206
        
        ; Draw Bow and Arrow
        LDA.w #$1288 : STA $00
        LDA $7EF340 : AND.w #$00FF : STA $02
        LDA.w #$F629 : STA $04
        
        JSR DrawItem
        
        ; Draw Boomerang
        LDA.w #$128E : STA $00
        LDA $7EF341 : AND.w #$00FF : STA $02
        LDA.w #$F651 : STA $04
        
        JSR DrawItem
        
        ; Draw Hookshot
        LDA.w #$1294 : STA $00
        LDA $7EF342 : AND.w #$00FF : STA $02
        LDA.w #$F669 : STA $04
        
        JSR DrawItem
        
        ; Draw Bombs
        LDA.w #$129A : STA $00
        
        LDA $7EF343 : AND.w #$00FF : BEQ .gotNoBombs
        
        LDA.w #$0001
    
    .gotNoBombs
    
        STA $02
        
        LDA.w #$F679 : STA $04
        
        JSR DrawItem
        
        ; Draw mushroom or magic powder
        LDA.w #$12A0 : STA $00
        LDA $7EF344 : AND.w #$00FF : STA $02
        LDA.w #$F689 : STA $04
        
        JSR DrawItem
        
        ; Draw Fire Rod
        LDA.w #$1348 : STA $00
        LDA $7EF345 : AND.w #$00FF : STA $02
        LDA.w #$F6A1 : STA $04
        
        JSR DrawItem
        
        ; Draw Ice Rod
        LDA.w #$134E : STA $00
        LDA $7EF346 : AND.w #$00FF : STA $02
        LDA.w #$F6B1 : STA $04
        
        JSR DrawItem
        
        ; Draw Bombos Medallion    (NOW LAMP)
        LDA.w #$1354 : STA $00
        LDA $7EF347 : AND.w #$00FF : STA $02
        LDA.w #$F6F1 : STA $04
        
        JSR DrawItem
        
        ; Draw Ether Medallion     (NOW HAMMER)
        LDA.w #$135A : STA $00
        LDA $7EF348 : AND.w #$00FF : STA $02
        LDA.w #$F701 : STA $04
        
        JSR DrawItem
        
        ; Draw Quake Medallion     (NOW MUDORA)
        LDA.w #$1360 : STA $00
        LDA $7EF349 : AND.w #$00FF : STA $02
        LDA.w #$F741 : STA $04
        
        JSR DrawItem
        
        LDA.w #$1408 : STA $00
        LDA $7EF34A : AND.w #$00FF : STA $02
        LDA.w #$F799 : STA $04
        
        JSR DrawItem
        
        LDA.w #$140E : STA $00
        LDA $7EF34B : AND.w #$00FF : STA $02
        LDA.w #$F731 : STA $04
        
        JSR DrawItem ; Mirror
        
        LDA.w #$1414 : STA $00
        LDA $7EF34C : AND.w #$00FF : STA $02
        LDA.w #$F7C9 : STA $04
        
        JSR DrawItem
        
        ; Bug Catching Net (Bottle)
        LDA.w #$141A : STA $00
        LDA $7EF34D : AND.w #$00FF : STA $02
        LDA.w #$F751 : STA $04
        
        JSR DrawItem
        
        ; Draw Book Of Mudora
        LDA.w #$1244 : STA $00
        LDA $7EF34E : AND.w #$00FF : STA $02
        LDA.w #$F751 : STA $04
        
        JSR DrawItem
        
        LDA.w #$1420 : STA $00
        
        ; there is an active bottle
        LDA $7EF34F : AND.w #$00FF : TAX : BNE .haveSelectedBottle
        
        LDA.w #$0000
        
        BRA .noSelectedBottle
    
    .haveSelectedBottle
    
        LDA $7EF35B, X : AND.w #$00FF
        
    .noSelectedBottle
    
        STA $02
        
        LDA.w #$F751 : STA $04
        JSR DrawItem
        
        ; Draw Cane of Somaria
        LDA.w #$1244 : STA $00
        LDA $7EF350 : AND.w #$00FF : STA $02
        LDA.w #$F799 : STA $04
        JSR DrawItem
        
        ; Draw Cane of Byrna
        LDA.w #$1244 : STA $00
        LDA $7EF351 : AND.w #$00FF : STA $02
        LDA.w #$F7A9 : STA $04
        JSR DrawItem
        
        ; Draw Magic Cape
        LDA.w #$1244 : STA $00
        LDA $7EF352 : AND.w #$00FF : STA $02
        LDA.w #$F7B9 : STA $04
        JSR DrawItem
        
        ; Draw Magic Mirror
        LDA.w #$1244 : STA $00
        LDA $7EF353 : AND.w #$00FF : STA $02
        LDA.w #$20F2 : STA $04
        JSR DrawItem
        
        SEP #$30
        
        RTS
    }

warnpc $0DE647

pullpc

;-------------------------------------------------------------------------------------
;Crystal + Pendant Menu
;-------------------------------------------------------------------------------------

pushpc

org $0DE9C8
; *$6E9C8-$6EB39 LOCAL
DrawProgressIcons:
{
    REP #$30
        
    LDX.w #$0000
    
    .initCrystalDiagram
        LDA $E914, X : STA $12EA, X
        LDA $E928, X : STA $132A, X
        LDA $E93C, X : STA $136A, X
        LDA $E950, X : STA $13AA, X
        LDA $E964, X : STA $13EA, X
        LDA $E978, X : STA $142A, X
        LDA $E98C, X : STA $146A, X
        LDA $E9A0, X : STA $14AA, X
        LDA $E9B4, X : STA $14EA, X
        
        INX #2 : CPX.w #$0014
        
    BCC .initCrystalDiagram

    LDA.w #$146E               : STA $00
    LDA $7EF374 : AND.w #$0001 : STA $02
    LDA.w #$F8D1               : STA $04
        
    JSR DrawItem
        
    LDA.w #$13B6 : STA $00
    STZ $02
        
    LDA $7EF374 : AND.w #$0002 : BEQ .needWisdomPendant
        INC $02
    
    .needWisdomPendant
    
    LDA.w #$F8E1 : STA $04
        
    JSR DrawItem
        
    LDA.w #$13AE : STA $00
    STZ $02
        
    LDA $7EF374 : AND.w #$0004 : BEQ .needPowerPendant
        INC $02
    
    .needPowerPendant
    
    LDA.w #$F8F1 : STA $04
        
    JSR DrawItem
        
    LDA $7EF37A : AND.w #$0008
        
    BEQ .turtleRockNotDone
        LDA.w #$2CE4 : STA $1476
        LDA.w #$2CE5 : STA $1478
        LDA.w #$2D44 : STA $14B6
        LDA.w #$2D45 : STA $14B8
    
    .turtleRockNotDone
    
    SEP #$30
        
    RTS
}

warnpc $0DEB3A

pullpc


;-------------------------------------------------------------------------------------
;Item Table Stuff
;-------------------------------------------------------------------------------------

pushpc

org $0DFA16
db $03
db $02
db $0E
db $01
db $0A
db $05
db $06
db $09
db $04
db $0C
db $12
db $07
db $14
db $0B
db $0B
db $00
db $00
db $00
db $00
db $00

pullpc

;-------------------------------------------------------------------------------------
;Draw Selected Item Stuff
;-------------------------------------------------------------------------------------

pushpc

org $0DEB3A
DrawSelectedYButtonItem:
{
    REP #$30
        
    LDA $0202 : AND.w #$00FF : DEC A : ASL A : TAX
        
    LDY $FAD5, X
    LDA $0000, Y : STA $11B2
    LDA $0002, Y : STA $11B4
    LDA $0040, Y : STA $11F2
    LDA $0042, Y : STA $11F4
        
    LDA $0207 : AND.w #$0010 : BEQ .dontUpdate
        LDA.w #$3C61 : STA $FFC0, Y
        ORA.w #$4000 : STA $FFC2, Y
        
        LDA.w #$3C70 : STA $FFFE, Y
        ORA.w #$4000 : STA $0004, Y
        
        LDA.w #$BC70 : STA $003E, Y
        ORA.w #$4000 : STA $0044, Y
        
        LDA.w #$BC61 : STA $0080, Y
        ORA.w #$4000 : STA $0082, Y
        
        LDA.w #$3C60 : STA $FFBE, Y
        ORA.w #$4000 : STA $FFC4, Y
        ORA.w #$8000 : STA $0084, Y
        EOR.w #$4000 : STA $007E, Y
    
    .dontUpdate
    
    LDA $0202 : AND.w #$00FF : CMP.w #$0010 : BNE .bottleNotSelected
        LDA $7EF34F : AND.w #$00FF : BEQ .bottleNotSelected
            TAX
            
            LDA $7EF35B, X : AND.w #$00FF : DEC A : ASL #5 : TAX
            
            LDY.w #$0000
        
            .drawBottleDescription
        
                LDA $F449, X : STA $122C, Y
                LDA $F459, X : STA $126C, Y
                
                INX #2
                INY #2 : CPY.w #$0010
            BCC .drawBottleDescription
            
            JMP .finished
    
    .bottleNotSelected
    
    ; Magic Powder selected?
    LDA $0202 : AND.w #$00FF : CMP.w #$0005 : BNE .powderNotSelected
        LDA $7EF344 : AND.w #$00FF : DEC A : BEQ .powderNotSelected
            DEC A : ASL #5 : TAX
            
            LDY.w #$0000
    
        .writePowderDescription
    
            LDA $F549, X : STA $122C, Y
            LDA $F559, X : STA $126C, Y
            
            INX #2
        INY #2 : CPY.w #$0010 : BCC .writePowderDescription
        
        JMP .finished
    
    .powderNotSelected
    
    LDA $0202 : AND.w #$00FF : CMP.w #$0014 : BNE .mirrorNotSelected
        LDA $7EF353 : AND.w #$00FF : DEC A : BEQ .mirrorNotSelected
            DEC A : ASL #5 : TAX
        
            LDY.w #$0000
    
            .writeMirrorDescription
            
                LDA $F5A9, X : STA $122C, Y
                LDA $F5B9, X : STA $126C, Y
                
                INX #2
            INY #2 : CPY.w #$0010 : BCC .writeMirrorDescription
                
            JMP .finished
    
    .mirrorNotSelected
    
    LDA $0202 : AND.w #$00FF : CMP.w #$000D : BNE .fluteNotSelected
        LDA $7EF34C : AND.w #$00FF : DEC A : BEQ .fluteNotSelected
            DEC A : ASL #5 : TAX
            
            LDY.w #$0000
        
            .writeFluteDescription
        
                LDA $F5A9, X : STA $122C, Y
                LDA $F5B9, X : STA $126C, Y
                
                INX #2
            INY #2 : CPY.w #$0010 : BCC .writeFluteDescription
            
            BRA .finished
    
    .fluteNotSelected
    
    LDA $0202 : AND.w #$00FF : CMP.w #$0001 : BNE .bowNotSelected
        LDA $7EF340 : AND.w #$00FF : DEC A : BEQ .bowNotSelected
            DEC A : ASL #5 : TAX
            
            LDY.w #$0000
        
            .writeBowDescription
            
                LDA $F5C9, X : STA $122C, Y
                LDA $F5D9, X : STA $126C, Y
                
                INX #2
                
            INY #2 : CPY.w #$0010 : BCC .writeBowDescription
                
            BRA .finished
    
    .bowNotSelected
    
    TXA : ASL #4 : TAX
        
    LDY.w #$0000
    
    .writeDefaultDescription
    
        LDA $F1C9, X : STA $122C, Y
        LDA $F1D9, X : STA $126C, Y
        
        INX #2 
    INY #2 : CPY.w #$0010 : BCC .writeDefaultDescription
    
    .finished
    
    SEP #$30
        
    RTS
}

warnpc $0DECE9

pullpc 

;-------------------------------------------------------------------------------------
;Big Chest Item Check Stuff
;-------------------------------------------------------------------------------------

pushpc

org $0DEEB6 ; $6EEB6-$6EEDB LOCAL
CheckPalaceItemPossession:
{
    SEP #$30
        
    LDA $040C : LSR A
        
    JSL UseImplicitRegIndexedLocalJumpTable
        
    dw .no_item
    dw .hookshot ; Castle
    dw .hammer ; East
    dw .power_glove ; Desert
    dw .fire_rod ; Agah?
    dw .no_item
    dw .bow
    dw .mirror_shield
    dw .no_item
    dw .moon_pearl
    dw .blue_mail ; Hera
    dw .titans_mitt
    dw .cane_of_somaria ; Turtle Rock
    dw .red_mail
}

; $6EEDC-$6EEE0 JUMP LOCATION
.pool_CheckPalaceItemPossession:
{
    .failure
    
    STZ $02
    STZ $03
        
    RTS
    
    .bow
    
        LDA $7EF340
    
    .no_item
    .compare
    
        BEQ .failure
    
    .success
    
        LDA.b #$01 : STA $02
                     STZ $03
        
        RTS
    
    .power_glove
    
        LDA $7EF354 : BRA .compare
    
    .hookshot
    
        LDA $7EF341 : BRA .compare
    
    .hammer
    
        LDA $7EF34B : BRA .compare
    
    .cane_of_somaria
    
        LDA $7EF350 : BRA .compare
    
    .fire_rod
    
        LDA $7EF346 : BRA .compare
    
    .blue_mail
    
        LDA $7EF35B : BRA .compare
    
    .moon_pearl
    
        LDA $7EF357 : BRA .compare
    
    .titans_mitt
    
        LDA $7EF354 : DEC A : BRA .compare
    
    .mirror_shield
    
        LDA $7EF35A : CMP.b #$03 : BEQ .success
        
        STZ $02
        STZ $03
        
        RTS
    
    .red_mail
    
        LDA $7EF35B : CMP.b #$02 : BEQ .success
        
    STZ $02
    STZ $03
        
    RTS
}

warnpc $0DEF39

pullpc

;-------------------------------------------------------------------------------------
;Item Select Draw + Cursor Stuff
;-------------------------------------------------------------------------------------

pushpc

org $0DFA93
; $6FA93-$6FAFC DATA
{
    dw $F629, $F651, $F669, $F679, $F689, $F6A1, $F6B1, $F6F1
    dw $F701, $F741, $F799, $F731, $F7C9, $F731, $F741, $F751
    dw $F799, $F7A9, $F7B9, $F7C9, $F7E9, $F801, $F811, $F821
    dw $F831, $F839, $F861, $F881, $F751, $F751, $F751, $F751
    dw $F901
    
    ; $6FAD5
    dw $1288, $128E, $1294, $129A, $12A0, $1348, $134E, $1354
    dw $135A, $1360, $1408, $140E, $1414, $141A, $1420, $1244
    dw $1244, $1244, $1244, $1244    
}

warnpc $0DFAFD

pullpc

;-------------------------------------------------------------------------------------
;Menu Item Name Display ASM
;-------------------------------------------------------------------------------------

pushpc

; LETTER KEY:
; 00 = BUG-CATCHING NET PT. 1
; 01 = BUG-CATCHING NET PT. 2
; 02 = BUG-CATCHING NET PT. 3
; 03 = BUG-CATCHING NET PT. 4
; 04 = BUG-CATCHING NET PT. 5
; 05 = BUG-CATCHING NET PT. 6
; 06 = BUG-CATCHING NET PT. 7
; 07 = BUG-CATCHING NET PT. 8
; 08 = BUG-CATCHING NET PT. 9
; 09 = BUG-CATCHING NET PT. 10
; 50 = A
; 51 = B
; 52 = C
; 53 = D
; 54 = E
; 55 = F
; 56 = G
; 57 = H
; 58 = I
; 59 = J
; 5A = K
; 5B = L
; 5C = M
; 5D = N
; 5E = O
; 5F = P
; 60 = Q
; 61 = R
; 62 = S
; 63 = T
; 64 = U
; 65 = V
; 66 = W
; 67 = X
; 68 = Y
; 69 = Z
; 6A = -
; 6B = BOW & ARROWS PT. 1
; 6C = BOW & ARROWS PT. 2
; 6E = BOW & ARROWS PT. 3
; 6F = BOW & ARROWS PT. 4
; 70 = BOOMERANG PT. 1
; 71 = BOOMERANG PT. 2
; 72 = BOOMERANG PT. 3
; 73 = BOOMERANG PT. 4
; 74 = BOOMERANG PT. 5
; 75 = BOOMERANG PT. 6
; 76 = BOOMERANG PT. 7
; 77 = BOOMERANG PT. 8
; 78 = BOW & SILVER ARROWS
; 79 = BOW & SILVER ARROWS
; 7A = BOW & SILVER ARROWS
; 7B = BOW & SILVER ARROWS
; 7C = BOW & ARROWS + BOW & SILVER ARROWS PT. 1
; 7D = BOW & ARROWS + BOW & SILVER ARROWS PT. 2
; 7E = BOW & ARROWS + BOW & SILVER ARROWS PT. 3
; 7F = BOW & ARROWS + BOW & SILVER ARROWS PT. 4

; BOW NAME DISPLAY
org $0DF1C9
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5   ; TOP LINE
    dw $2551, $255E, $2566, $24F5, $24F5, $24F5, $24F5, $24F5   ; BOTTOM LINE

; BOW & ARROWS NAME DISPLAY
org $0DF5C9
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5   ; TOP LINE
    dw $256B, $256C, $256E, $256F, $257C, $257D, $257E, $257F   ; BOTTOM LINE

; BOW (SILVERS) NAME DISPLAY
org $0DF5E9
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5   ; TOP LINE
    dw $2551, $255E, $2566, $24F5, $24F5, $24F5, $24F5, $24F5   ; BOTTOM LINE

; BOW & SILVER ARROWS NAME DISPLAY
org $0DF609
    dw $256B, $256C, $24F5, $256E, $256F, $24F5, $24F5, $24F5   ; TOP LINE
    dw $2578, $2579, $257A, $257B, $257C, $257D, $257E, $257F   ; BOTTOM LINE

; BOOMERANG NAME DISPLAY
org $0DF1E9
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5   ; TOP LINE
    dw $2570, $2571, $2572, $2573, $2574, $2575, $2576, $2577   ; BOTTOM LINE

; HOOKSHOT NAME DISPLAY
org $0DF209
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5   ; TOP LINE
    dw $2557, $255E, $255E, $255A, $2562, $2557, $255E, $2563   ; BOTTOM LINE

; BOMB NAME DISPLAY
org $0DF229
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5   ; TOP LINE
    dw $2551, $255E, $255C, $2551, $2562, $24F5, $24F5, $24F5   ; BOTTOM LINE

; MUSHROOM NAME DISPLAY
org $0DF249
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5   ; TOP LINE
    dw $255C, $2564, $2562, $2557, $2561, $255E, $255E, $255C   ; BOTTOM LINE

; MAGIC POWDER NAME DISPLAY
org $0DF549
    dw $255C, $2550, $2556, $2558, $2552, $24F5, $24F5, $24F5   ; TOP LINE
    dw $24F5, $24F5, $255F, $255E, $2566, $2553, $2554, $2561   ; BOTTOM LINE

; FIREROD NAME DISPLAY
org $0DF269
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5   ; TOP LINE
    dw $2555, $2558, $2561, $2554, $24F5, $2561, $255E, $2553   ; BOTTOM LINE

; ICEROD NAME DISPLAY
org $0DF289
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5   ; TOP LINE
    dw $2558, $2552, $2554, $24F5, $2561, $255E, $2553, $24F5   ; BOTTOM LINE

; BOMBOS NAME DISPLAY
org $0DF2A9
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5   ; TOP LINE
    dw $255B, $2550, $255C, $255F, $24F5, $24F5, $24F5, $24F5   ; BOTTOM LINE

; ETHER NAME DISPLAY
org $0DF2C9
    dw $255C, $2550, $2556, $2558, $2552, $24F5, $24F5, $24F5   ; TOP LINE
    dw $24F5, $24F5, $2557, $2550, $255C, $255C, $2554, $2561   ; BOTTOM LINE

; QUAKE NAME DISPLAY
org $0DF2E9
    dw $2551, $255E, $255E, $255A, $24F5, $255E, $2555, $24F5   ; TOP LINE
    dw $24F5, $24F5, $255C, $2564, $2553, $255E, $2561, $2550    ; BOTTOM LINE

; LAMP NAME DISPLAY
org $0DF309
    dw $2552, $2550, $255D, $2554, $24F5, $255E, $2555, $24F5   ; TOP LINE
    dw $24F5, $2562, $255E, $255C, $2550, $2561, $2558, $2550   ; BOTTOM LINE

; MAGIC HAMMER NAME DISPLAY
org $0DF329
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5   ; TOP LINE
    dw $2551, $2564, $2556, $24F5, $255D, $2554, $2563, $24F5   ; BOTTOM LINE

; SHOVEL NAME DISPLAY
org $0DF349
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5   ; TOP LINE
    dw $2562, $2557, $255E, $2565, $2554, $255B, $24F5, $24F5   ; BOTTOM LINE

; FLUTE NAME DISPLAY
org $0DF569
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5   ; TOP LINE
    dw $2555, $255B, $2564, $2563, $2554, $24F5, $24F5, $24F5   ; BOTTOM LINE

; FLUTE (BIRD) NAME DISPLAY
org $0DF589
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5   ; TOP LINE
    dw $2555, $255B, $2564, $2563, $2554, $24F5, $24F5, $24F5   ; BOTTOM LINE

; BUG-CATCHING NET NAME DISPLAY
org $0DF369
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5   ; TOP LINE
    dw $2551, $255E, $2563, $2563, $255B, $2554, $24F5, $24F5   ; BOTTOM LINE

; BOOK OF MUDORA NAME DISPLAY
org $0DF389
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5   ; TOP LINE
    dw $2551, $255E, $2563, $2563, $255B, $2554, $24F5, $24F5   ; BOTTOM LINE

; BOTTLE MUSHROOM NAME DISPLAY
org $0DF449
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5   ; TOP LINE
    dw $255C, $2564, $2562, $2557, $2561, $255E, $255E, $255C   ; BOTTOM LINE

; BOTTLE NAME DISPLAY
org $0DF469
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5   ; TOP LINE
    dw $2551, $255E, $2563, $2563, $255B, $2554, $24F5, $24F5   ; BOTTOM LINE

; LIFE MEDICINE NAME DISPLAY
org $0DF489
    dw $255B, $2558, $2555, $2554, $24F5, $24F5, $24F5, $24F5   ; TOP LINE
    dw $255C, $2554, $2553, $2558, $2552, $2558, $255D, $2554   ; BOTTOM LINE

; MAGIC MEDICINE NAME DISPLAY
org $0DF4A9
    dw $255C, $2550, $2556, $2558, $2552, $24F5, $24F5, $24F5   ; TOP LINE
    dw $255C, $2554, $2553, $2558, $2552, $2558, $255D, $2554   ; BOTTOM LINE

; CURE-ALL MEDICINE NAME DISPLAY
org $0DF4C9
    dw $2552, $2564, $2561, $2554, $256A, $2550, $255B, $255B   ; TOP LINE
    dw $255C, $2554, $2553, $2558, $2552, $2558, $255D, $2554   ; BOTTOM LINE

; FAERIE NAME DISPLAY
org $0DF4E9
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5   ; TOP LINE
    dw $2555, $2550, $2558, $2561, $2568, $24F5, $24F5, $24F5   ; BOTTOM LINE

; BEE NAME DISPLAY
org $0DF509
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5   ; TOP LINE
    dw $2551, $2554, $2554, $24F5, $24F5, $24F5, $24F5, $24F5   ; BOTTOM LINE

; GOOD BEE NAME DISPLAY
org $0DF529
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5   ; TOP LINE
    dw $2556, $255E, $255E, $2553, $24F5, $2551, $2554, $2554   ; BOTTOM LINE

; CANE OF SOMARIA NAME DISPLAY
org $0DF3C9
    dw $2552, $2550, $255D, $2554, $24F5, $255E, $2555, $24F5   ; TOP LINE
    dw $24F5, $2562, $255E, $255C, $2550, $2561, $2558, $2550   ; BOTTOM LINE

; CANE OF BYRNA NAME DISPLAY
org $0DF3E9
    dw $2552, $2550, $255D, $2554, $24F5, $255E, $2555, $24F5   ; TOP LINE
    dw $24F5, $24F5, $24F5, $2551, $2568, $2561, $255D, $2550   ; BOTTOM LINE

; MAGIC CAPE NAME DISPLAY
org $0DF409
    dw $255C, $2550, $2556, $2558, $2552, $24F5, $24F5, $24F5   ; TOP LINE
    dw $24F5, $24F5, $24F5, $2552, $2550, $255F, $2554, $24F5   ; BOTTOM LINE

; UNUSED MAP (MIRROR) NAME DISPLAY
org $0DF429
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5   ; TOP LINE
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5   ; BOTTOM LINE

; MAGIC MIRROR NAME DISPLAY
org $0DF5A9
    dw $255C, $2550, $2556, $2558, $2552, $24F5, $24F5, $24F5   ; TOP LINE
    dw $24F5, $24F5, $255C, $2558, $2561, $2561, $255E, $2561   ; BOTTOM LINE

pullpc
