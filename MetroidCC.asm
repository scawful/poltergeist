;==============================================================================
; Metroid Boss
; By Zarby89
;==============================================================================

pushpc
org $028A3C
    JSL RoomGfxLoad

org $0791B9
    Player_HaltDashAttackLong:

pullpc

RoomGfxLoad:
{
    LDA $A0 : CMP #$B6 : BEQ +
        JSL $00DEFF ; normal code
    +

    RTL
}

;==============================================================================
; Sprite Properties
;==============================================================================
!SPRID              = $CC ; The sprite ID you are overwriting (HEX)
!NbrTiles           = 16  ; Number of tiles used in a frame
!Harmless           = 00  ; 00 = Sprite is Harmful,  01 = Sprite is Harmless
!HVelocity          = 00  ; Is your sprite going super fast? put 01 if it is
!Health             = 99  ; Number of Health the sprite have
!Damage             = 00  ; (08 is a whole heart), 04 is half heart
!DeathAnimation     = 00  ; 00 = normal death, 01 = no death animation
!ImperviousAll      = 00  ; 00 = Can be attack, 01 = attack will clink on it
!SmallShadow        = 00  ; 01 = small shadow, 00 = no shadow
!Shadow             = 00  ; 00 = don't draw shadow, 01 = draw a shadow 
!Palette            = 00  ; Unused in this template (can be 0 to 7)
!Hitbox             = 13  ; 00 to 31, can be viewed in sprite draw tool
!Persist            = 01  ; 01 = your sprite continue to live offscreen
!Statis             = 00  ; 00 = is sprite is alive?, (kill all enemies room)
!CollisionLayer     = 00  ; 01 = will check both layer for collision
!CanFall            = 00  ; 01 sprite can fall in hole, 01 = can't fall
!DeflectArrow       = 00  ; 01 = deflect arrows
!WaterSprite        = 00  ; 01 = can only walk shallow water
!Blockable          = 00  ; 01 = can be blocked by link's shield?
!Prize              = 00  ; 00-15 = the prize pack the sprite will drop from
!Sound              = 00  ; 01 = Play different sound when taking damage
!Interaction        = 00  ; ?? No documentation
!Statue             = 00  ; 01 = Sprite is statue
!DeflectProjectiles = 00  ; 01 = Sprite will deflect ALL projectiles
!ImperviousArrow    = 00  ; 01 = Impervious to arrows
!ImpervSwordHammer  = 00  ; 01 = Impervious to sword and hammer attacks
!Boss               = 01  ; 00 = normal sprite, 01 = sprite is a boss
%Set_Sprite_Properties(Sprite_Metroid_Prep, Sprite_Metroid_Long);
;==================================================================================================
; Sprite Long Hook for that sprite
; --------------------------------------------------------------------------------------------------
; This code can be left unchanged
; handle the draw code and if the sprite is active and should move or not
;==================================================================================================
Sprite_Metroid_Long:
{
    PHB : PHK : PLB

    JSR Sprite_Metroid_Draw ; Call the draw code
    JSL Sprite_CheckActive   ; Check if game is not paused
    BCC .SpriteIsNotActive   ; Skip Main code is sprite is innactive
        JSR Sprite_Metroid_Main ; Call the main sprite code

    .SpriteIsNotActive

    PLB ; Get back the databank we stored previously
    RTL ; Go back to original code
}

;==================================================================================================
; Sprite initialization
; --------------------------------------------------------------------------------------------------
; this code only get called once perfect to initialize sprites substate or timers
; this code as soon as the room transitions/ overworld transition occurs
;==================================================================================================
Sprite_Metroid_Prep:
{
    PHB : PHK : PLB
    STZ.w SprMiscB, X
    PHX : PHP
    REP #$20 ; P is still on stack, so we don't even need to fix this

    LDX #$20

    --
        LDA MetroidPalette, X : STA $7EC600, X
    DEX : DEX : BNE --

    LDX #$80 : STX $2100
    STX $2115
    LDA #$5400 : STA $2116 ; $A000 in vram
    LDA #$1801 : STA $4300
    LDA.w #MetroidBitmap : STA $4302
    LDX.b #MetroidBitmap>>16 : STX $4304
    LDA #$0800 : STA $4305 ; 3 sheets of $800 each
    LDX #$01 : STX $420B

    LDX #$0F : STX $2100

    REP #$30

    ;LDX #$0800
    ;--
        ;LDA.l MetroidBitmap, X : STA.l $7F0800, X
    ;DEX : DEX : BNE --

    PLP : PLX

    LDA.w Flying : STA.w SprHeight, X

    LDA #$58 : STA.w SprHealth, X
    INC $15 ;Refresh Palettes

    PLB
    RTL
}

MetroidPalette:
    dw #$7FFF, #$1246, #$53B8, #$0B10, #$14A5, #$001A, #$000E, #$0004
    dw #$49BA, #$18A8, #$10EB, #$2A12, #$3AD8, #$4B9E, #$7BFE, #$0000

FrozenPalette:
    dw #$7FFF, #$6ACA, #$77D5, #$7BAA, #$41C0, #$45E0, #$3980, #$20E5
    dw #$6E87, #$3525, #$45E0, #$6E87, #$7371, #$77D5, #$7FFF, #$0000

MetroidBitmap:
    incbin Metroid3.bin

;==================================================================================================
; Sprite Main routines code
; --------------------------------------------------------------------------------------------------
; This is the main local code of your sprite
; This contains all the Subroutines of your sprites you can add more below
;==================================================================================================
Sprite_Metroid_Main:
{
    LDA.w SprAction, X; Load the SprAction
    JSL UseImplicitRegIndexedLocalJumpTable; Goto the SprAction we are currently in

    dw Following        ; 0x00
    dw Descent          ; 0x01
    dw DrainHP          ; 0x02
    dw Ascent           ; 0x03
    dw AscentStun       ; 0x04
    dw Frozen           ; 0x05
    dw Roaming          ; 0x06
    dw MoveTowardFast   ; 0x07
    dw WaitBeforeCharge ; 0x08
    dw AscentKeepSpeed  ; 0x09
}

;==================================================================================================

Following: ; 0x00
{
    %PlayAnimation(0, 3, 16)

    LDA.w SprTimerA, X : BNE .timer
        LDA #$04 : STA.w SprTimerA, X
        LDA.w SprMiscA, X : TAY

        INC : STA.w SprMiscA, X : CMP #$12 : BNE +
            STZ.w SprMiscA, X
        +

        LDA.w Flying, Y : STA.w SprHeight, X


        REP #$20
        LDA $0FD8 ; Sprite X
        CLC : SBC $22 ; - Player X

        BPL +
            EOR #$FFFF
        +

        STA $00 ; Distance X (ABS)

        LDA $0FDA ; Sprite Y
        CLC : SBC $20 ; - Player Y

        BPL +
            EOR #$FFFF
        +

        ; Add it back to X Distance
        CLC : ADC $00 : STA $02 ; distance total X, Y (ABS)

        CMP #$0018 : BCS .toofar
            SEP #$20
            %GotoAction(1)

        .toofar

        SEP #$20

        JSL GetRandomInt : CMP #$08 : BCS +
            ;CMP #$1F : BCC .rand
            LDA #$40 : STA.w SprTimerC, X
            %GotoAction(8)
        +

    .timer

    ;BRA +
        ;.rand
        ;JSL GetRandomInt : STA.w SprMiscC, X
        ;JSL GetRandomInt : STA.w SprMiscD, X
        ;JSL GetRandomInt : AND #$3F : CLC : ADC #$20 : STA.w SprTimerC, X

        ;%GotoAction(6)
    ;+

    REP #$20
    LDA $22 : STA $04
    LDA $20 : SEC : SBC #$0008 : STA $06
    SEP #$20

    LDA.w SprTimerD, X : BNE +
        LDA #$10 : STA.w SprTimerD, X
        LDA #$10
        JSL Sprite_ProjectSpeedTowardsEntityLong
        LDA $00 : STA SprYSpeed, X
        LDA $01 : STA SprXSpeed, X
    +

    JSL Sprite_MoveLong

    LDA.w SprTimerC, X : BNE .paletteTimer
        LDA #$10 : STA.w SprTimerC, X
            LDA.w SprMiscB, X : INC : CMP #$06 : BNE +
            LDA.b #$00
        +

        STA.w SprMiscB, X
        ASL : ASL : ASL
        CLC : ADC #$06
        TAY
        PHX
        REP #$20
        LDX #$06

        --
            LDA.w MetroidSwapPalette, Y : STA $7EC60A, X
            DEY : DEY
            DEX : DEX : BNE --
        INC $15 ;Refresh Palettes
        
        
        SEP #$20
        PLX

    .paletteTimer

    JSR CheckDamage

    RTS
}

;==================================================================================================

Flying:
    db $20, $21, $22, $23, $24, $24, $24, $23
    db $22, $21, $20, $1F, $1E, $1D, $1D, $1D
    db $1E, $1F

MetroidSwapPalette:
    dw #$0014, #$000A, #$0004, #$3114
    dw #$001A, #$000E, #$0004, #$49BA
    dw #$183E, #$1014, #$080A, #$5A5E
    dw #$28DE, #$20B8, #$18AE, #$72FE
    dw #$183E, #$1014, #$080A, #$5A5E
    dw #$001A, #$000E, #$0004, #$49BA

;==================================================================================================

CheckDamage:
{
    LDA.w $0CE2, X : CMP #$04 : BNE +
        LDA #$90 : STA.w SprTimerE, X

        %GotoAction(5)
        PHX
        REP #$20 ; P is still on stack, so we don't even need to fix this

        LDX #$20

        --
            LDA FrozenPalette, X : STA $7EC600, X
        DEX : DEX : BNE --

        INC $15 ;Refresh Palettes
        SEP #$20
        PLX
    +

    STZ.w $0CE2, X ; kill the damage of the icerod
    ; freeze it !

    ; spawn a small magic

    .nodamage

    RTS
}

;==================================================================================================

Descent: ; 0x01
{
    %PlayAnimation(0, 3, 16)

    REP #$20
    LDA $0FD8 ; Sprite X
    CLC : SBC $22 ; - Player X

    BPL +
        EOR #$FFFF
    +

    STA $00 ; Distance X (ABS)

    LDA $0FDA ; Sprite Y
    CLC : SBC $20 ; - Player Y

    BPL +
        EOR #$FFFF
    +

    ; Add it back to X Distance
    CLC : ADC $00 : STA $02 ; distance total X, Y (ABS)

    CMP #$0018 : BCC .notfarenough
        SEP #$20
        %GotoAction(3) ; was too far go to ascent then

    .notfarenough

    SEP #$20
    LDA.w SprHeight, X : DEC : STA.w SprHeight, X : CMP #$04 : BCS +
        STZ.w SprMiscE, X
        %GotoAction(2)
    +

    REP #$20
    LDA $22 : STA $04
    LDA $20 : SEC : SBC #$0008 : STA $06
    SEP #$20
    LDA #$08
    JSL Sprite_ProjectSpeedTowardsEntityLong
    LDA $00 : STA SprYSpeed, X
    LDA $01 : STA SprXSpeed, X
    JSL Sprite_MoveLong

    SEP #$20

    LDA.w SprTimerC, X : BNE .paletteTimer
        LDA #$10 : STA.w SprTimerC, X
            LDA.w SprMiscB, X : INC : CMP #$06 : BNE +
            LDA.b #$00
        +

        STA.w SprMiscB, X
        ASL : ASL : ASL
        CLC : ADC #$06
        TAY
        PHX
        REP #$20
        LDX #$06

        --
            LDA.w MetroidSwapPalette, Y : STA $7EC60A, X
            DEY : DEY
         DEX : DEX : BNE --

        INC $15 ;Refresh Palettes
             
        SEP #$20
        PLX

    .paletteTimer

    JSR CheckDamage

    RTS
}

;==================================================================================================

DrainHP: ; 0x02
{
    %PlayAnimation(0, 3, 6)
    ; slow link down and make it mash dpad to break free
    ; slowly drain hp too
    LDA #$04 : STA.b $57

    ; Stop them from dashing
    JSL Player_HaltDashAttackLong

    LDA.b $F0 : AND.b #$0F : CMP.w SprMiscD, X : BEQ +
        INC.w SprMiscE, X
    +

    STA.w SprMiscD, X ; store last input

    LDA SprMiscE, X : CMP #$20 : BCC + ; wiggled the dpad enough?
        LDA #$40 : STA.w SprTimerA, X
        %GotoAction(04)

        ; Spawn a small magic
        LDA.b #$DF : JSL Sprite_SpawnDynamically : BMI .nospawn
            JSL Sprite_SetSpawnedCoords

        .nospawn
    +

    LDA.w SprTimerD, X : BNE +
        ; subtract link hp
        LDA #$01 : STA.w $0373
        LDA #$16 : STA.w SprTimerD, X
    +

    LDA #$00 : STA $08

    REP #$20
    LDA $0FD8 ; Sprite X
    CLC : SBC $22 ; - Player X

    BPL +
        EOR #$FFFF
    +

    STA $00 ; Distance X (ABS)

    LDA $0FDA ; Sprite Y
    CLC : SBC $20 ; - Player Y

    BPL +
        EOR #$FFFF
    +

    ; Add it back to X Distance
    CLC : ADC $00 : STA $02 ; distance total X, Y (ABS)

    CMP #$0008 : BCS .toofar
        ; wat?

    .toofar

    REP #$20
    LDA $22 : STA $04
    LDA $20 : SEC : SBC #$0008 : STA $06
    SEP #$20
    LDA #$0B
    JSL Sprite_ProjectSpeedTowardsEntityLong
    LDA $00 : STA SprYSpeed, X
    LDA $01 : STA SprXSpeed, X
    JSL Sprite_MoveLong

    LDA.w SprTimerC, X : BNE .paletteTimer
        LDA #$03 : STA.w SprTimerC, X

        LDA.w SprMiscB, X : INC : CMP #$06 : BNE +
            LDA.b #$00
        +

        STA.w SprMiscB, X
        ASL : ASL : ASL
        CLC : ADC #$06
        TAY
        PHX
        REP #$20
        LDX #$06

        --
            LDA.w MetroidSwapPalette, Y : STA $7EC60A, X
            DEY : DEY
        DEX : DEX : BNE --

        INC $15 ;Refresh Palettes
        
        SEP #$20
        PLX

    .paletteTimer

    RTS
}

;==================================================================================================

Ascent: ; 0x03
{
    %PlayAnimation(0, 3, 16)

    REP #$20
    LDA $0FD8 ; Sprite X
    CLC : SBC $22 ; - Player X

    BPL +
        EOR #$FFFF
    +

    STA $00 ; Distance X (ABS)

    LDA $0FDA ; Sprite Y
    CLC : SBC $20 ; - Player Y

    BPL +
        EOR #$FFFF
    +

    ; Add it back to X Distance
    CLC : ADC $00 : STA $02 ; distance total X, Y (ABS)

    CMP #$0008 : BCS .toofar
        SEP #$20
        %GotoAction(1)

    .toofar

    SEP #$20

    LDA.w SprHeight, X : INC : STA.w SprHeight, X : CMP #$20 : BCC +
        STZ.w SprMiscA, X
        %GotoAction(0)
    +

    LDA.w SprTimerC, X : BNE .paletteTimer
        LDA #$10 : STA.w SprTimerC, X

        LDA.w SprMiscB, X : INC : CMP #$06 : BNE +
            LDA.b #$00
        +
        
        STA.w SprMiscB, X
        ASL : ASL : ASL
        CLC : ADC #$06
        TAY
        PHX
        REP #$20
        LDX #$06

        --
            LDA.w MetroidSwapPalette, Y : STA $7EC60A, X
            DEY : DEY
        DEX : DEX : BNE --

        INC $15 ;Refresh Palettes
        
        SEP #$20
        PLX

    .paletteTimer

    JSR CheckDamage
    RTS
}

;==================================================================================================

AscentStun: ; 0x04
{
    LDA.w SprHeight, X : INC : STA.w SprHeight, X : CMP #$20 : BCC +
        LDA #$20 : STA.w SprHeight, X
        STZ.w SprMiscA, X
        
        LDA.w SprTimerA, X : BNE +
            %GotoAction(0)
        +

    JSR CheckDamage
    RTS
}

;==================================================================================================

Frozen: ; 0x05
{
    JSL Sprite_CheckDamageFromPlayer : BCC .nodamage
        ; the fighter sword doesn't do any damage so reduce manually i guess...
        LDA.w SprTimerB, X : BNE .nodamage
            DEC.w SprHealth, X
            LDA #$10 : STA.w SprTimerB, X

    .nodamage

    LDA.w SprTimerB, X : BEQ .nopalettecycle
        PHX
        AND #$01 : BEQ +
            REP #$20 ; P is still on stack, so we don't even need to fix this

            LDX #$20

            --
                LDA FrozenPalette, X : STA $7EC600, X
            DEX : DEX : BNE --

            INC $15 ;Refresh Palettes
            SEP #$20
            BRA .pullx
        +

        REP #$20 ; P is still on stack, so we don't even need to fix this

        LDX #$20

        --
            LDA MetroidPalette, X : STA $7EC600, X
        DEX : DEX : BNE --

        INC $15 ;Refresh Palettes
        SEP #$20

        .pullx

        PLX
        SEP #$20

    .nopalettecycle

    LDA.w SprHealth, X : CMP #$20 : BCS .alive
        LDA.b #$04 : STA.w $0DD0, X
        STZ.w $0D90, X
        
        LDA.b #$E0 : STA.w SprTimerA, X
        LDA.b #$9F : STA.w SprDeath, X
        
    .alive
        
    JSL Sprite_MoveZ
    DEC $0F80, X : DEC $0F80, X

    LDA $0F70, X : CMP #$04 : BCS .inAir
        LDA.b #$04 : STA $0F70, X
        STZ $0F80, X

    .inAir

    LDA.w SprTimerE, X : CMP #$2F : BCS .noshake
        AND #$01 : TAY
        STZ.w SprYSpeed, X
        LDA .shake_x_speeds, Y : STA.w SprXSpeed, X
        JSL Sprite_MoveLong

    .noshake

    LDA.w SprTimerE, X : BNE +
        PHX
        REP #$20 ; P is still on stack, so we don't even need to fix this

        LDX #$20

        --
            LDA MetroidPalette, X : STA $7EC600, X
        DEX : DEX : BNE --

        INC $15 ;Refresh Palettes
        SEP #$20
        PLX
        LDA #$10 : STA.w SprTimerA, X
        %GotoAction(4)
    +

    RTS

    .shake_x_speeds
    db 16, -16
}

;==================================================================================================

Roaming: ; 0x06
{
    %PlayAnimation(0, 3, 16)

    LDA.w SprTimerA, X : BNE .timer
        LDA #$04 : STA.w SprTimerA, X
        LDA.w SprMiscA, X : TAY

        INC : STA.w SprMiscA, X : CMP #$12 : BNE +
            STZ.w SprMiscA, X
        +

    LDA.w Flying, Y : STA.w SprHeight, X

    REP #$20
    LDA $22 : STA $04
    LDA $20 : SEC : SBC #$0008 : STA $06
    SEP #$20

    LDA.w SprMiscC, X : STA $04
    LDA.w SprMiscD, X : STA $05

    LDA.w SprTimerD, X : BNE +
        LDA #$10 : STA.w SprTimerD, X
        LDA #$16
        JSL Sprite_ProjectSpeedTowardsEntityLong

        LDA $00 : STA SprYSpeed, X
        LDA $01 : STA SprXSpeed, X
    +

    .timer

    JSL Sprite_MoveLong

    JSL GetRandomInt : CMP #$7F : BCC +
        %GotoAction(0)
    +

    LDA.w SprTimerC, X : BNE +
        %GotoAction(0)
    +

    REP #$20
    LDA $0FD8 ; Sprite X
    CLC : SBC $22 ; - Player X

    BPL +
        EOR #$FFFF
    +

    STA $00 ; Distance X (ABS)

    LDA $0FDA ; Sprite Y
    CLC : SBC $20 ; - Player Y

    BPL +
        EOR #$FFFF
    +

    ; Add it back to X Distance
    CLC : ADC $00 : STA $02 ; distance total X, Y (ABS)

    CMP #$009F : BCC .toofar
        SEP #$20
        %GotoAction(0)

    .toofar

    SEP #$20

    JSR CheckDamage
    RTS
}

;==================================================================================================

MoveTowardFast: ; 0x07
{
    %PlayAnimation(0, 3, 16)

    LDA.w SprTimerA, X : BNE .timer
        LDA #$04 : STA.w SprTimerA, X
        LDA.w SprMiscA, X : TAY

        INC : STA.w SprMiscA, X : CMP #$12 : BNE +
            STZ.w SprMiscA, X
        +

        ;LDA.w Flying, Y : STA.w SprHeight, X

        REP #$20
        LDA $0FD8 ; Sprite X
        CLC : SBC $22 ; - Player X

        BPL +
            EOR #$FFFF
        +

        STA $00 ; Distance X (ABS)

        LDA $0FDA ; Sprite Y
        CLC : SBC $20 ; - Player Y

        BPL +
            EOR #$FFFF
        +

        ; Add it back to X Distance
        CLC : ADC $00 : STA $02 ; distance total X, Y (ABS)

        CMP #$0018 : BCS .toofar
            SEP #$20
            %GotoAction(1)

        .toofar

        SEP #$20

        + ; TODO: Remove this? it seems to be a left over extra.

    .timer

    LDA.w SprTimerD, X : BNE +
        %GotoAction(3)
    +

    LDA.w SprHeight, X : DEC : STA.w SprHeight, X : CMP #$06 : BCS +
        %GotoAction(9)
    +

    JSL Sprite_MoveLong

    LDA.w SprX, X : CMP #$08 : BCS .xIsHighEnough
        LDA #$08 : STA.w SprX, X
        BRA .xIsLowEnough

        ; TODO: This code is never hit.
        CMP #$F8 : BCC .xIsLowEnough
            LDA #$F8 : STA.w SprX, X

        .xIsLowEnough
    .xIsHighEnough


    LDA.w SprY, X : CMP #$08 : BCS .yIsHighEnough
        LDA #$08 : STA.w SprY, X
        BRA .yIsLowEnough

        ; TODO: This code is never hit.
        CMP #$F0 : BCC .xIsLowEnough
            LDA #$F0 : STA.w SprY, X

        .yIsLowEnough
    .yIsHighEnough


    LDA.w SprTimerC, X : BNE .paletteTimer
        LDA #$10 : STA.w SprTimerC, X

        LDA.w SprMiscB, X : INC : CMP #$06 : BNE +
            LDA.b #$00
        +

        STA.w SprMiscB, X
        ASL : ASL : ASL
        CLC : ADC #$06
        TAY
        PHX
        REP #$20
        LDX #$06

        --
            LDA.w MetroidSwapPalette, Y : STA $7EC60A, X
            DEY : DEY
        DEX : DEX : BNE --

        INC $15 ;Refresh Palettes
        
        SEP #$20
        PLX

    .paletteTimer

    JSR CheckDamage

    RTS
}

;==================================================================================================

WaitBeforeCharge: ; 0x08
{
    LDA.w SprTimerC, X : CMP #$20 : BCS +
        REP #$20
        LDA $22 : STA $04
        LDA $20 : SEC : SBC #$0008 : STA $06
        SEP #$20

        LDA #$12
        JSL Sprite_ProjectSpeedTowardsEntityLong
        LDA $00 : EOR #$FF : STA SprYSpeed, X
        LDA $01 : EOR #$FF : STA SprXSpeed, X

        JSL Sprite_MoveLong
        %PlayAnimation(0, 3, 2)
    +

    LDA.w SprTimerC, X : BNE +
        %GotoAction(7)

        LDA #$30 : STA.w SprTimerD, X
        REP #$20
        LDA $22 : STA $04
        LDA $20 : SEC : SBC #$0008 : STA $06
        SEP #$20

        LDA #$34
        JSL Sprite_ProjectSpeedTowardsEntityLong
        LDA $00 : STA SprYSpeed, X
        LDA $01 : STA SprXSpeed, X
    +

    JSR CheckDamage

    RTS
}

;==================================================================================================

AscentKeepSpeed: ; 0x09
{
    %PlayAnimation(0, 3, 16)

    REP #$20
    LDA $0FD8 ; Sprite X
    CLC : SBC $22 ; - Player X

    BPL +
        EOR #$FFFF
    +

    STA $00 ; Distance X (ABS)

    LDA $0FDA ; Sprite Y
    CLC : SBC $20 ; - Player Y

    BPL +
        EOR #$FFFF
    +

    ; Add it back to X Distance
    CLC : ADC $00 : STA $02 ; distance total X, Y (ABS)

    CMP #$0008 : BCS .toofar
        SEP #$20
        %GotoAction(1)

    .toofar

    SEP #$20

    LDA.w SprHeight, X : INC : STA.w SprHeight, X : CMP #$20 : BCC +
        STZ.w SprMiscA, X
        %GotoAction(0)

    +

    LDA.w SprTimerC, X : BNE .paletteTimer
        LDA #$10 : STA.w SprTimerC, X
            LDA.w SprMiscB, X : INC : CMP #$06 : BNE +
            LDA.b #$00
        +

        STA.w SprMiscB, X
        ASL : ASL : ASL
        CLC : ADC #$06
        TAY
        PHX
        REP #$20
        LDX #$06

        --
            LDA.w MetroidSwapPalette, Y : STA $7EC60A, X
            DEY : DEY
            DEX : DEX : BNE --
        INC $15 ;Refresh Palettes
        
        SEP #$20
        PLX

    .paletteTimer

    JSL Sprite_MoveLong

    LDA.w SprX, X : CMP #$08 : BCS .xIsHighEnough
        LDA #$08 : STA.w SprX, X
        BRA .xIsLowEnough
        
        ; TODO: This code is never hit.
        CMP #$F8 : BCC .xIsLowEnough
            LDA #$F8 : STA.w SprX, X

        .xIsLowEnough
    .xIsHighEnough

    LDA.w SprY, X : CMP #$08 : BCS .yIsHighEnough
        LDA #$08 : STA.w SprY, X
        BRA .yIsLowEnough

        ; TODO: This code is never hit.
        CMP #$F0 : BCC .xIsLowEnough
            LDA #$F0 : STA.w SprY, X

        .yIsLowEnough
    .yIsHighEnough

    JSR CheckDamage

    RTS
}

;==================================================================================================
; Sprite Draw code
; --------------------------------------------------------------------------------------------------
; Draw the tiles on screen with the data provided by the sprite maker editor
;==================================================================================================

Sprite_Metroid_Draw:
{
    JSL Sprite_PrepOamCoord
    LDA.b #$40
    JSL OAM_AllocateFromRegionA

    LDA $0DC0, X : CLC : ADC $0D90, X : TAY ; Animation Frame
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

    JSL Sprite_PrepOamCoord
    LDA.b #$08
    JSL OAM_AllocateFromRegionB
    JSL $1DD1A8

    RTS
}

;==================================================================================================
; Sprite Draw Generated Data
; --------------------------------------------------------------------------------------------------
; This is where the generated Data for the sprite go
;==================================================================================================
    .start_index
    db $00, $10, $20, $30

    .nbr_of_tiles
    db 15, 15, 15, 15

    .x_offsets
    dw -24, -8, 8, 24, -24, -8, 8, 24, -24, -8, 8, 24, -24, -8, 8, 24
    dw -24, -8, 8, 24, -24, -8, 8, 24, -24, -8, 8, 24, -24, -8, 8, 24
    dw -24, -8, 8, 24, -24, -8, 8, 24, -24, -8, 8, 24, -24, -8, 8, 24
    dw -24, -8, 8, 24, -24, -8, 8, 24, -24, -8, 8, 24, -24, -8, 8, 24

    .y_offsets
    dw -16, -16, -16, -16, 0, 0, 0, 0, 15, 15, 15, 15, 31, 31, 31, 31
    dw -16, -16, -16, -16, 0, 0, 0, 0, 15, 15, 15, 15, 31, 31, 31, 31
    dw -16, -16, -16, -16, 0, 0, 0, 0, 15, 15, 15, 15, 31, 31, 31, 31
    dw -16, -16, -16, -16, 0, 0, 0, 0, 15, 15, 15, 15, 31, 31, 31, 31

    .chr
    db $40, $42, $42, $40, $60, $62, $62, $60, $44, $46, $46, $44, $64, $66, $66, $64
    db $40, $42, $42, $40, $60, $62, $62, $60, $44, $46, $46, $44, $48, $4A, $4A, $48
    db $40, $42, $42, $40, $60, $62, $62, $60, $44, $46, $46, $44, $68, $6A, $6A, $68
    db $40, $42, $42, $40, $60, $62, $62, $60, $44, $46, $46, $44, $48, $4A, $4A, $48

    .properties
    db $31, $31, $71, $71, $31, $31, $71, $71, $31, $31, $71, $71, $31, $31, $71, $71
    db $31, $31, $71, $71, $31, $31, $71, $71, $31, $31, $71, $71, $31, $31, $71, $71
    db $31, $31, $71, $71, $31, $31, $71, $71, $31, $31, $71, $71, $31, $31, $71, $71
    db $31, $31, $71, $71, $31, $31, $71, $71, $31, $31, $71, $71, $31, $31, $71, $71

    .sizes
    db $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02
    db $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02
    db $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02
    db $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02

;==================================================================================================