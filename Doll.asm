;==============================================================================
; Sprite Properties
;==============================================================================

!SPRID              = $34; The sprite ID you are overwriting (HEX)
!NbrTiles           = 2 ; Number of tiles used in a frame
!Harmless           = 01  ; 00 = Sprite is Harmful,  01 = Sprite is Harmless
!HVelocity          = 00  ; Is your sprite going super fast? put 01 if it is
!Health             = 0  ; Number of Health the sprite have
!Damage             = 0  ; (08 is a whole heart), 04 is half heart
!DeathAnimation     = 00  ; 00 = normal death, 01 = no death animation
!ImperviousAll      = 01  ; 00 = Can be attack, 01 = attack will clink on it
!SmallShadow        = 00  ; 01 = small shadow, 00 = no shadow
!Shadow             = 00  ; 00 = don't draw shadow, 01 = draw a shadow 
!Palette            = 0  ; Unused in this template (can be 0 to 7)
!Hitbox             = 3  ; 00 to 31, can be viewed in sprite draw tool
!Persist            = 00  ; 01 = your sprite continue to live offscreen
!Statis             = 01  ; 00 = is sprite is alive?, (kill all enemies room)
!CollisionLayer     = 01  ; 01 = will check both layer for collision
!CanFall            = 00  ; 01 sprite can fall in hole, 01 = can't fall
!DeflectArrow       = 00  ; 01 = deflect arrows
!WaterSprite        = 00  ; 01 = can only walk shallow water
!Blockable          = 00  ; 01 = can be blocked by link's shield?
!Prize              = 0  ; 00-15 = the prize pack the sprite will drop from
!Sound              = 00  ; 01 = Play different sound when taking damage
!Interaction        = 00  ; ?? No documentation
!Statue             = 00  ; 01 = Sprite is statue
!DeflectProjectiles = 00  ; 01 = Sprite will deflect ALL projectiles
!ImperviousArrow    = 00  ; 01 = Impervious to arrows
!ImpervSwordHammer  = 00  ; 01 = Impervious to sword and hammer attacks
!Boss               = 00  ; 00 = normal sprite, 01 = sprite is a boss
%Set_Sprite_Properties(Sprite_Doll_Prep, Sprite_Doll_Long)

; ==============================================================================
; Sprite Long Hook for that sprite
; ==============================================================================
; This code can be left unchanged
; handle the draw code and if the sprite is active and should move or not
; ==============================================================================

Sprite_Doll_Long:
{
    PHB : PHK : PLB

    JSR Sprite_Doll_Draw ; Call the draw code
    JSL Sprite_CheckActive   ; Check if game is not paused

    BCC .SpriteIsNotActive   ; Skip Main code is sprite is innactive
        JSR Sprite_Doll_Main ; Call the main sprite code

    .SpriteIsNotActive

    PLB ; Get back the databank we stored previously
    RTL ; Go back to original code
}

; ==============================================================================
; Sprite initialization
; ==============================================================================
; this code only get called once perfect to initialize sprites substate or timers
; this code as soon as the room transitions/ overworld transition occurs
; ==============================================================================
Sprite_Doll_Prep:
{
    PHB : PHK : PLB
   
    ; Add more code here to initialize data

    PLB
    RTL
}

; ==============================================================================
; Sprite Main routines code
; ==============================================================================
; This is the main local code of your sprite
; This contains all the Subroutines of your sprites you can add more below
; ==============================================================================
Sprite_Doll_Main:
{
    LDA.w SprAction, X; Load the SprAction
    JSL UseImplicitRegIndexedLocalJumpTable; Goto the SprAction we are currently in

    dw Action00_Doll
}

Action00_Doll:
{
    %ShowSolicitedMessage(52)
    JSL Sprite_PlayerCantPassThrough
    JSL Sprite_DirectionToFacePlayer

    LDA .animation, Y
    STA SprFrame, X ; Store Accumulator in SprFrame indexed with X = (sprite slot)

    RTS
}

.animation
db $02, $00, $01, $03 ; Change the order until it works :D

; ==============================================================================
; Sprite Draw code
; ==============================================================================
; Draw the tiles on screen with the data provided by the sprite maker editor
; ==============================================================================
Sprite_Doll_Draw:
{
    JSL Sprite_PrepOamCoord
    JSL Sprite_OAM_AllocateDeferToPlayer

    LDA $0DC0, X : CLC : ADC $0D90, X : TAY;Animation Frame
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
        LDA .properties, X : STA ($90), Y

        PHY 
            
        TYA : LSR #2 : TAY
            
        LDA .sizes, X : ORA $0F : STA ($92), Y ; store size in oam buffer
            
        PLY : INY
    PLX : DEX : BPL .nextTile

    PLX

    RTS
}

; ==============================================================================
; Sprite Draw Generated Data
; ==============================================================================
; This is where the generated Data for the sprite go
; ==============================================================================
    .start_index
    db $00, $03, $06, $09

    .nbr_of_tiles
    db 2, 2, 2, 2

    .x_offsets
    dw 0, 0, 0
    dw 0, 0, 0
    dw 0, 0, 0
    dw 0, 0, 0

    .y_offsets
    dw 10, 0, -8
    dw 10, 0, -8
    dw 10, 0, -8
    dw 10, 0, -8

    .chr
    db $6C, $C2, $28
    db $6C, $C2, $24
    db $6C, $C2, $28
    db $6C, $C2, $26

    .properties
    db $38, $39, $39
    db $38, $39, $39
    db $38, $39, $79
    db $38, $39, $39
    
    .sizes
    db $02, $02, $02
    db $02, $02, $02
    db $02, $02, $02
    db $02, $02, $02
