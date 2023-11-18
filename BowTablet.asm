; ==============================================================================

pushpc

org $05F417
JSL EtherTabletBeforeCrumblingHook ; Disable that jump might use that for code later

org $05F43C
NOP #25
JSL EtherTabletDuringCrumblingHook

org $05F463
NOP #01
JSL EtherTabletAfterCrumblingHook

org $05F331
NOP #07 ; remove check if player is preocupied

org $05F3DD
NOP #04

org $05F40A
NOP #04

org $05F285
JSL EtherCheckBowInstead
db $90

org $0DD142
    dw -8, -16 : db $8C, $00, $00, $02
    dw  8, -16 : db $8C, $40, $00, $02
    dw -8,   0 : db $AC, $00, $00, $02
    dw  8,   0 : db $AC, $40, $00, $02
        
    dw -8, -13 : db $8A, $00, $00, $02
    dw  8, -13 : db $8A, $40, $00, $02
    dw -8,   0 : db $AC, $00, $00, $02
    dw  8,   0 : db $AC, $40, $00, $02
        
    dw -8,  -8 : db $8A, $00, $00, $02
    dw  8,  -8 : db $8A, $40, $00, $02
    dw -8,   0 : db $AC, $00, $00, $02
    dw  8,   0 : db $AC, $40, $00, $02
        
    dw -8,   0 : db $AA, $00, $00, $02
    dw  8,   0 : db $AA, $40, $00, $02
    dw -8,   0 : db $AA, $00, $00, $02
    dw  8,   0 : db $AA, $40, $00, $02
        
    dw -8,   0 : db $AA, $00, $00, $02
    dw  8,   0 : db $AA, $40, $00, $02
    dw -8,   0 : db $AA, $00, $00, $02
    dw  8,   0 : db $AA, $40, $00, $02

pullpc

; ==============================================================================

EtherTabletBeforeCrumblingHook:
{
    LDA #$01 : STA $02E4
    RTL
}

EtherTabletDuringCrumblingHook:
{
    LDA $0DF0, X : BNE .delay

    ;LDA #$04 : STA $7EF359
    PHX
    ;JSL $00D2C8 ; DecompSwordGfx              ; $52C8 IN ROM
    ;JSL $1BED03 ; Palette_Sword               ; $DED03 IN ROM

    ;LDA #$03 : STA $7EF359

    LDA #$05
    JSL $00D4ED ; GetAnimatedSpriteTile.variable

    PLX
    LDA.b #$15 : STA $5D
        
    LDA.b #$01 :  STA $02DA  : STA $037B
    
    INC $0D80, X
    LDA.b #$8E : STA $0E00, X
    LDA.b #$60 : STA $0DF0, X ; Delay before sword start to fall (must not be too high)
    
    RTL
    
    .delay

    CMP.b #$60 : BEQ .increment_animation_state
    CMP.b #$40 : BEQ .increment_animation_state
    CMP.b #$20 : BNE .do_not
    
    .increment_animation_state
    
    LDA #$35 : STA $012E ; Play Crumbing sound ***might need to change for better sound***
    INC $0DC0, X
    
    .do_not
    
    RTL
}

EtherTabletAfterCrumblingHook:
{
    LDA $0DF0, X : BNE .delay
    LDA $7EF340 : CMP #$01 : BCS .noDraw
    PHB : PHK : PLB
    INC $0DE0, X
    INC $0DE0, X ; Can remove that line to reduce the falling sword speed
    ;IF you removed the line above, scroll lower in SwordFallingDraw function another value need to be changed

    LDA $0DE0, X : CMP $20 : BCC +
        STZ $0E00, X
    +
    JSR SwordFallingDraw

    PLB
    

    LDA $0E00, X : BNE .delay
    LDA.b #$04 : STA $0DC0, X ; Restored Code

        STZ $5D
        STZ $02DA
        STZ $037B
        INC $0DA0, X
        LDY.b #$0B
        JSL $0799AD ; Give item sword4
        
    .delay
    +
    .noDraw
    RTL
}

SwordFallingDraw:
	JSL Sprite_PrepOamCoord
	;JSL Sprite_OAM_AllocateDeferToPlayer
    JSL $0DBA80 ;OAM_AllocateFromRegionA

    LDA #$00 : STA $06
    LDA $0DE0, X : STA $02 ; Y
    LDA $22 : SEC : SBC $E2 : CLC : ADC #$0A : STA $00 ; IF fall speed is reduced change the ADC #$0A to #$0B
    
    PHX
    LDX #$01 ;amount of tiles -1
    LDY.b #$00
    .nextTile

    PHX ; Save current Tile Index?
        
    TXA : CLC : ADC $06 ; Add Animation Index Offset

    PHA ; Keep the value with animation index offset?

    ASL A : TAX 

    REP #$20

    LDA $00 : STA ($90), Y
    AND.w #$0100 : STA $0E 
    INY
    LDA $02 : AND #$00FF : CLC : ADC .y_offsets, X : STA ($90), Y
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
    LDA .properties, X : STA ($90), Y

    PHY 
        
    TYA : LSR #2 : TAY
        
    LDA .sizes, X : ORA $0F : STA ($92), Y ; store size in oam buffer
        
    PLY : INY
        
    PLX : DEX : BPL .nextTile

    PLX

    RTS

;Generated Draw Code
.start_index
db $00
.nbr_of_tiles
db 1
.x_offsets
dw $8, $8
.y_offsets
dw -8, 0
.chr
db $24, $34
.properties
db $32, $32
.sizes
db $00, $00

EtherCheckBowInstead:
{
    LDA $7EF340 : CMP #$01
    RTL
}

; ==============================================================================