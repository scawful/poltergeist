; ==============================================================================
; Changes the draw of the transport whirlpools to be big like the zora king's
; and changes the hitbox to match.
pushpc

org $06F129
    Sprite_CheckDamageToPlayerSameLayerLong:

org $1EFE78
    Sprite3_CheckIfActive:

; Change the hit box to be bigger.
org $0DB506
    db $00

; Replace the draw and use the warp code instead of the whirlpool code.
org $1EEEA5
{
    ; This is a dumb fix because I had to shift the draw over a bit to be centered.
    ; If we are more than 0x0180 away don't run this code at all to prevent random flickering.
    JSL Sprite_Get_Distance_From_Player

    REP #$20
    LDA $00 : STA $35 : CMP.w #$0180 : BCC .notTooFar
        SEP #$30
        RTS

    .notTooFar
    SEP #$30

    JSL BigWhirlpoolDrawLONG
    JSR Sprite3_CheckIfActive
     
    JSL Sprite_CheckDamageToPlayerSameLayerLong : BCC .didnt_touch
        ; \task Note sure if this name is right, or how this variable could
        ; be set...?
        LDA $0D90, X : BNE .temporarily_disabled
            LDA.b #$23 : STA $11
                
            STZ $B0

        .temporarily_disabled
    
        RTS
    
    .didnt_touch
    
    STZ $0D90, X
        
    RTS
}
warnpc $1EEEEE

pullpc

; ==============================================================================

BigWhirlpoolDrawLONG:
{
    PHB : PHK : PLB

    JSR BigWhirlpoolDraw

    PLB
    RTL
}

; ==============================================================================

BigWhirlpoolDraw:
{
    REP #$20
        
    LDA $0FD8 : SEC : SBC.w #$0008 : STA $0FD8
    LDA $0FDA : SEC : SBC.w #$0008 : STA $0FDA
        
    SEP #$30

    JSL Sprite_PrepOamCoord
    LDA.b #$10 : JSL OAM_AllocateFromRegionB

    JSR WhirlpoolAnimation

    LDY $0DA0, X ;Animation Frame
    LDA .start_index, Y : STA $06

    PHX
    LDX .nbr_of_tiles, Y ;amount of tiles -1
    LDY.b #$00

    .nextTile

        PHX ; Save current Tile Index?
            
        TXA : CLC : ADC $06 ; Add Animation Index Offset

        PHA ; Keep the value with animation index offset?

        ASL A : TAX 

        REP #$20

        LDA $00 : CLC : ADC .x_offsets, X : STA ($90), Y
        AND.w #$0100 : STA $0E 
        INY
        LDA $02 : CLC : ADC .y_offsets, X : STA ($90), Y
        CLC : ADC #$0010 : CMP.w #$0100
        SEP #$20

        BCC .on_screen_y
            LDA.b #$F0 : STA ($90), Y ;Put the sprite out of the way
            STA $0E

        .on_screen_y

        PLX ; Pullback Animation Index Offset (without the *2 not 16bit anymore)
        INY
        LDA .chr, X : STA ($90), Y
        INY
        LDA .properties, X : AND.b #$F1 : ORA.b #$04 : STA ($90), Y

        PHY 
            
        TYA : LSR #2 : TAY
            
        LDA .sizes, X : ORA $0F : STA ($92), Y ; store size in oam buffer
            
        PLY : INY 
    PLX : DEX : BPL .nextTile

    PLX

    RTS

    ;Generated Draw Code
    .start_index
    db $00, $04, $08, $0C
    
    .nbr_of_tiles
    db 3, 3, 3, 3

    .x_offsets
    dw -8, 8, -8, 8
    dw 8, -8, 8, -8
    dw 8, -8, 8, -8
    dw -8, 8, -8, 8

    .y_offsets
    dw -8, -8, 8, 8
    dw -8, -8, 8, 8
    dw 8, 8, -8, -8
    dw 8, 8, -8, -8

    .chr
    db $CC, $CE, $EC, $EE
    db $CC, $CE, $EC, $EE
    db $CC, $CE, $EC, $EE
    db $CC, $CE, $EC, $EE

    .properties
    db $31, $31, $31, $31
    db $71, $71, $71, $71
    db $F1, $F1, $F1, $F1
    db $B1, $B1, $B1, $B1

    .sizes
    db $02, $02, $02, $02
    db $02, $02, $02, $02
    db $02, $02, $02, $02
    db $02, $02, $02, $02
}

; ==============================================================================

WhirlpoolAnimation:
{
    LDA $0DF0, X : BNE .dontStep
        LDA.b #$08 : STA $0DF0, X

        LDA $0DC0, X : CMP.b #$04 : BCC .dontReset
            LDA.b #$00 : STA $0DC0, X

        .dontReset

        INC $0DC0, X

        STA $0DA0, X
        
    .dontStep

    RTS
}

; ==============================================================================

;store the distance from the player in $00
Sprite_Get_Distance_From_Player:
{
    REP #$20

    STZ $00

    LDA $0FDA : SEC : SBC $20 : CMP.w #$8000 : BCC .dontFlipY ;if delta Y is negative times by -1
        EOR.w #$FFFF : INC A ;times by -1

    .dontFlipY

    STA $00 ;delta Y

    LDA $0FD8 : SEC : SBC $22 : CMP.w #$8000 : BCC .dontFlipX ;if delta X is negative times by -1
        EOR.w #$FFFF : INC A ;times by -1

    .dontFlipX

    CLC : ADC $00 : STA $00 ;add delta Y to delta X

    SEP #$20

    RTL
}

; ==============================================================================