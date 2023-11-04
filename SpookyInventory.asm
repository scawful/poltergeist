;=====================================================================================
;The Legend of Zelda: Omega v2.00 ASM
;By Letterbomb, Zarby89, Jared_Brian_
;=====================================================================================

;lorom
;org $2A8000

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
    ;db $2C
    
org $0DF88C
    ;db $6C

org $0DF88E
    ;db $2C

org $0DF890
    ;db $6C

pullpc

;-------------------------------------------------------------------------------------
;L1 Tunic Palette Change
;-------------------------------------------------------------------------------------

pushpc

org $0DF882
db $30

org $0DF884
db $70

org $0DF886
db $30

org $0DF888
db $70

pullpc

;-------------------------------------------------------------------------------------
;World Map Disable (TEMP CODE)
;-------------------------------------------------------------------------------------

pushpc

org $0288FD ; Replace a BEQ by a BRA (dungeon map removed)
db $80

;org $02A55E ; Replace a BEQ by a BRA (overworld map removed)
;db $80

pullpc

;-------------------------------------------------------------------------------------
;Sword and Shield Textbox Fix
;-------------------------------------------------------------------------------------

pushpc

org $08C2DD
;dw $FFFF

pullpc

;-------------------------------------------------------------------------------------
;Intro Prison Palette
;-------------------------------------------------------------------------------------

pushpc

org $0CF002
;db $12

pullpc

;-------------------------------------------------------------------------------------
;Intro Throne Room Blockset
;-------------------------------------------------------------------------------------

pushpc

org $0CEF91 ; The Blockset for the Throne Room in the Intro.
;db $0C ; Change to whatever Blockset you want.

pullpc

;-------------------------------------------------------------------------------------
;Intro Agahnim Room Blockset
;-------------------------------------------------------------------------------------

pushpc

org $0CF08C ; The Blockset for Agahnim's room in the Intro.
;db $09 ; Change to whatever Blockset you want.

pullpc

;-------------------------------------------------------------------------------------
;Tavern Backdoor Fix
;-------------------------------------------------------------------------------------

pushpc

org $02D7AA
;db $FF

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
    dw $20FB, $20F9, $20F9, $20F9, $20F9, $20F9, $20F9, $20F9, $20F9, $60FB
    ; $06E928
    dw $20FC, $252F, $2534, $2535, $2536, $2537, $24F5, $24F5, $24F5, $60FC
    ; $06E93C
    dw $20FC, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $60FC
    ; $06E950
    dw $20FC, $24F5, $313B, $313C, $24F5, $24F5, $313B, $313C, $24F5, $60FC
    ; $06E964
    dw $20FC, $24F5, $313D, $313E, $24F5, $24F5, $313D, $313E, $24F5, $60FC
    ; $06E978
    dw $20FC, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $60FC
    ; $06E98C
    dw $20FC, $24F5, $313B, $313C, $24F5, $24F5, $313B, $313C, $24F5, $60FC
    ; $06E9A0
    dw $20FC, $24F5, $313D, $313E, $24F5, $24F5, $313D, $313E, $24F5, $60FC
    ; $06E9B4
    dw $A0FB, $A0F9, $A0F9, $A0F9, $A0F9, $A0F9, $A0F9, $A0F9, $A0F9, $E0FB

warnpc $0DE9C8

pullpc

;-------------------------------------------------------------------------------------
;Crystal + Pendant Menu
;-------------------------------------------------------------------------------------

pushpc

org $0DE372
    DrawItem:

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

    ; 1st pendant
    LDA $7EF374 : AND.w #$0004 : BEQ .pendant1
        LDA.w #$212B : STA $13AE
        LDA.w #$212C : STA $13B0
        LDA.w #$212D : STA $13EE
        LDA.w #$212E : STA $13F0
    
    .pendant1
        
    ; 2nd pendant
    LDA.w #$13B6 : STA $00
    STZ $02
        
    LDA $7EF374 : AND.w #$0002 : BEQ .pendant2
        INC $02
    
    .pendant2
    
    LDA.w #$F8E1 : STA $04
    JSR DrawItem
        
    ; 3rd pendant
    LDA.w #$146E : STA $00
    STZ $02
        
    LDA $7EF374 : AND.w #$0001 : BEQ .pendant3
        INC $02
    
    .pendant3
    
    LDA.w #$F8F1 : STA $04
    JSR DrawItem

    ; 4th pendant
    LDA.w #$1476 : STA $00
    STZ $02
        
    LDA $7EF37A : AND.w #$0001 : BEQ .pendant4
        LDA.w #$292B : STA $1476
        LDA.w #$292C : STA $1478
        LDA.w #$292D : STA $14B6
        LDA.w #$292E : STA $14B8
    
    .pendant4

    
    SEP #$30
        
    RTS
}

warnpc $0DEB3A

pullpc

;-------------------------------------------------------------------------------------

pushpc

;Equipment Menu Color Change
org $0DED2C
db $FB
db $3C ; Corners

org $0DED4C
db $FC
db $3C ; Vertical Edge

org $0DED69
db $F9
db $3C ; Horizontal Edge

pullpc

;-------------------------------------------------------------------------------------

pushpc

;Item Display Menu Color Change
org $0DE64A
db $FB 
db $20 ; Corners

org $0DE66A
db $FC
db $20 ; Vertical Edge

org $0DE687
db $F9
db $20 ; Horizontal Edge

pullpc

;-------------------------------------------------------------------------------------

pushpc

; Item select box:
; Corners
org $0DE3DC
db $FB
db $2C

; Vertical Edge
org $0DE3FC
db $FC
db $2C

; Vertical Edge
org $0DE419
db $F9
db $2C

; Top of the Y
org $0DE461
db $F0
db $2C

; Top of the Y
org $0DE461
db $F0
db $2C

; Bottom of the Y
org $0DE467
db $F1
db $2C

pullpc

;-------------------------------------------------------------------------------------

pushpc

; Bottle box:
; Corners
org $0DEF6A
db $FB
db $3C

; Vertical Edge
org $0DEF8A
db $FC
db $3C

; Horizontal Edge
org $0DEFA7
db $F9
db $3C


; Bottle menu:
; Left border when switching
org $0DE064
db $FC
db $3C

; Right border when switching
org $0DE076
db $FC
db $7C

; Bottom left corner when switching
org $0DE078
db $FB
db $BC

; Bottom right corner when switching
org $0DE08A
db $FB
db $FC

; Top left corner when switching
org $0DE050
db $FB
db $3C

; Top right corner when switching
org $0DE062
db $FB
db $7C

; Top border when switching
org $0DE052
db $F9
db $3C
db $F9
db $3C
db $F9
db $3C
db $F9
db $3C
db $F9
db $3C
db $F9
db $3C
db $F9
db $3C
db $F9
db $3C

; Bottom border when switching
org $0DE07A
db $F9
db $BC
db $F9
db $BC
db $F9
db $BC
db $F9
db $BC
db $F9
db $BC
db $F9
db $BC
db $F9
db $BC
db $F9
db $BC

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
        LDY.w #$0010
        LDA.w #$3CF5
    
    .drawBoxInterior
    
        STA $1584, X : STA $15C4, X
        STA $1604, X : STA $1644, X
        STA $1684, X : STA $16C4, X
        
        STA $1704, X : INX #2
        
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
        LDA $F959, X : STA $1588, Y
        LDA $F95B, X : STA $158A, Y
        LDA $F95D, X : STA $158C, Y
        LDA $F95F, X : STA $158E, Y
        LDA $F961, X : STA $1590, Y
        LDA $F963, X : STA $15C8, Y
        LDA $F965, X : STA $15CA, Y
        LDA $F967, X : STA $15CC, Y
        LDA $F969, X : STA $15CE, Y
        LDA $F96B, X : STA $15D0, Y
    
    .lacksAbility
    
        TXA : CLC : ADC.w #$0014 : TAX
        TYA : CLC : ADC.w #$000A : TAY
        
        DEC $06 : BNE .nextAbility
        
        TYA : CLC : ADC.w #$0058 : TAY
        
        DEC $04 : BNE .nextLine
        
        ; draw the 4 corners of the box containing the ability tiles
        LDA.w #$3CFB : AND $00 : STA $1542
        ORA.w #$8000 : STA $1742
        ORA.w #$4000 : STA $1766
        EOR.w #$8000 : STA $1566
        
        LDX.w #$0000
        LDY.w #$0006
    
    .drawVerticalEdges
    
        LDA.w #$3CFC : AND $00 : STA $1582, X
        ORA.w #$4000 : STA $15A6, X
        
        TXA : CLC : ADC.w #$0040 : TAX
        
        DEY : BPL .drawVerticalEdges
        
        LDX.w #$0000
        LDY.w #$0010
    
    .drawHorizontalEdges
    
        LDA.w #$3CF9 : AND $00 : STA $1544, X
        ORA.w #$8000 : STA $1744, X
        
        INX #2
        
        DEY : BPL .drawHorizontalEdges
        
        ; Draw 'A' button icon
        LDA.w #$BCF0 : STA $1584
        LDA.w #$3CF2 : STA $15C4
        LDA.w #$3C82 : STA $1546
        LDA.w #$3C83 : STA $1548
        
        SEP #$30
        
        RTS
    }

warnpc $0DE7B7

pullpc

;-------------------------------------------------------------------------------------

pushpc

; Cursor draw for the bottle menu.
org $0DE279
    LDA.w #$2861 : STA $12AA, Y
    ORA.w #$4000 : STA $12AC, Y
        
    LDA.w #$2870 : STA $12E8, Y
    ORA.w #$4000 : STA $12EE, Y
        
    LDA.w #$A870 : STA $1328, Y
    ORA.w #$4000 : STA $132E, Y
        
    LDA.w #$A861 : STA $136A, Y
    ORA.w #$4000 : STA $136C, Y
        
    LDA.w #$2860 : STA $12A8, Y
    ORA.w #$4000 : STA $12AE, Y
    ORA.w #$8000 : STA $136E, Y
    EOR.w #$4000 : STA $1368, Y

pullpc

;-------------------------------------------------------------------------------------

pushpc

; Cursor draw for the Y item cursor.
org $0DEB68
    LDA.w #$2861 : STA $FFC0, Y
    ORA.w #$4000 : STA $FFC2, Y
        
    LDA.w #$2870 : STA $FFFE, Y
    ORA.w #$4000 : STA $0004, Y
        
    LDA.w #$A870 : STA $003E, Y
    ORA.w #$4000 : STA $0044, Y
        
    LDA.w #$A861 : STA $0080, Y
    ORA.w #$4000 : STA $0082, Y
        
    LDA.w #$2860 : STA $FFBE, Y
    ORA.w #$4000 : STA $FFC4, Y
    ORA.w #$8000 : STA $0084, Y
    EOR.w #$4000 : STA $007E, Y

pullpc

;-------------------------------------------------------------------------------------