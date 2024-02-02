; ==============================================================================
pushpc

; The positions of the death counters. 
org $0EBC51 ; $073C51
    dw $0290, $0298, $02A0, $02A8, $02B0, $0310, $FFFF, $FFFF, $FFFF, $FFFF, $FFFF, $FFFF, $FFFF, $FFFF

; Changes which save values (dungeon IDs) corrispond to which death counter.
org $0EBE08 ; $073E08
    dw $0004, $0006, $0014, $000C, $0008, $001E, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000 

; Skip end cutscene.
org $0E9889
    LDA #$20 : STA $11
    RTS

; Change the final death count to save under Hyrule Castle 2 instead so that 
; it shows the count correctly at the end of the credits and start the count
; at 0 instead of what was in ganon's tower.
org $0EBC9E ; $073C9E
    LDA $7EF403 : STA $7EF3EF : LDA.w #$0000
    NOP : NOP

; ==============================================================================

org $0EB038 ; $073038 - 073C51
    incbin SpookyCredits.bin
warnpc $0EBC51

; ==============================================================================

; The correct GFX set and palette for the credits background will be loaded.
org $0286C0
Credits_LoadCoolBackground:
{
    ; Not sure...
    LDA.b #$21 : STA $0AA1 ; #$21

    ; Loads the proper tile set for the scrolling view of Hyrule.
    LDA.b #$24 : STA $0AA2 ; #$3B

    ; Sprite GFX index. used later in loading the "THE END" text.
    LDA.b #$2D : STA $0AA3 ; #$2D

    ; Using the parameters above, loads all the necessary tile sets
    JSL ApplyCastleGFX_LONG

    ; Put us at the pyrmaid of power
    LDX.b #$40 : STX $8A ; #$5B

    ; sets an index for setting $0AB8
    LDA.b #$13 : STA $00 ; #$13

    LDA $00FD1C, X

    JSL Overworld_LoadPalettes ; $0755A8 IN ROM; Loads several palettes based on the X = 0x5B above.

    ; reload the BG auxiliary 2 palette with a different value
    LDA.b #$03 : STA $0AB5

    JSL CreditsPalette

    JSR Overworld_CgramAuxToMain

    JSR $AF1E ; Overworld_ReloadSubscreenOverlay ; $012F1E IN ROM

    STZ $E6
    STZ $E7
    STZ $E0
    STZ $E1

    DEC $11

    RTL
}

pullpc

CreditsPalette:
{
    JSL $1BEF0C ; Palette_OverworldBgAux2 ; $0DEF0C IN ROM

    REP #$20 ; A = 16, XY = 8

    LDA.w #$0842 : STA.l $7EC3C2
    LDA.w #$1CA4 : STA.l $7EC3C4
    LDA.w #$3128 : STA.l $7EC3C6
    LDA.w #$398A : STA.l $7EC3C8
    LDA.w #$1CC5 : STA.l $7EC3CA
    LDA.w #$2107 : STA.l $7EC3CC
    LDA.w #$20E7 : STA.l $7EC3CE

    SEP #$30

    RTL
}

pushpc

; Stop the bg from scrolling separatly.
org $0EBD8B
Credits_FadeColorAndBeginAnimating:
{
    ; Gradually neutralize color add/sub.
    JSR $BD66 ; Credits_FadeOutFixedCol ; $073D66 IN ROM
        
    LDA.b #$01 : STA.w $0710
        
    SEP #$30
        
    ; Presumably something to do with the 3D triforce.
    JSL $0CCBA2 ; Credits_AnimateTheTriangles ; $064BA2 IN ROM
        
    REP #$30
        
    LDA.b $1A : AND.w #$0003 : BNE .return
        ; Advance the scenery background to the right 1 pixel.
        INC.b $E2
        
        LDA.b $E2 : CMP.w #$0C00 : BNE .noTilemapAdjust
            ; Adjust the tilemap size and locations of BG1 and BG2... not entirely clear yet as to why.
            LDY.w #$1300 : STY.w $2107
        
        .noTilemapAdjust

        ; Removed a bunch of stuff here that cuased the different rows of the BG to
        ; scroll at different speeds.
        STA.w $0606 : STA.w $0604 : STA.w $0600 : STA.w $0602
        
        LDA.b $EA : CMP.w #$0CD8 : BNE .notDoneWithSubmodule
            LDA.w #$0080 : STA.b $C8
            
            INC.b $11
            
            BRA .return
        
        .notDoneWithSubmodule
    
        ; Scroll the credit list up one pixel.
        CLC : ADC.w #$0001 : STA.b $EA
        
        TAY : AND.w #$0007 : BNE .return
            TYA : LSR #3 : STA.b $CA
            
            JSR $BE24 ; Credits_AddNextAttribution ; $073E24 IN ROM

        BRA .return
    
    ; $073DEB LONG BRANCH LOCATION
    org $0EBDEB
    .return
    
    REP #$20
        
    LDA.b $E2 : STA.w $011E
    LDA.b $E8 : STA.w $0122
        
    LDA.b $E0 : STA.w $0120
    LDA.b $E6 : STA.w $0124
        
    SEP #$30
        
    RTS
}

; ==============================================================================

; Shift he bg down a different amount than vanilla.
org $0EBD04
    dw $FFC0 ;$FFB8

; ==============================================================================

pullpc