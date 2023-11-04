;==============================================================================
; Sprite Properties
;==============================================================================
!SPRID              = $04; The sprite ID you are overwriting (HEX)
!NbrTiles           = 0 ; Number of tiles used in a frame
!Harmless           = 00  ; 00 = Sprite is Harmful,  01 = Sprite is Harmless
!HVelocity          = 00  ; Is your sprite going super fast? put 01 if it is
!Health             = 0  ; Number of Health the sprite have
!Damage             = 0  ; (08 is a whole heart), 04 is half heart
!DeathAnimation     = 00  ; 00 = normal death, 01 = no death animation
!ImperviousAll      = 00  ; 00 = Can be attack, 01 = attack will clink on it
!SmallShadow        = 00  ; 01 = small shadow, 00 = no shadow
!Shadow             = 00  ; 00 = don't draw shadow, 01 = draw a shadow 
!Palette            = 0  ; Unused in this LongSwitch (can be 0 to 7)
!Hitbox             = 0  ; 00 to 31, can be viewed in sprite draw tool
!Persist            = 00  ; 01 = your sprite continue to live offscreen
!Statis             = 00  ; 00 = is sprite is alive?, (kill all enemies room)
!CollisionLayer     = 00  ; 01 = will check both layer for collision
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


pushpc

org $06C003 ; pull switch JSL
    JSL NewPullSwitchCheck

; Are there only three rooms where these switches work? 0_o.
org $068859 ; pull switch prep
    JSL NewPrepSwitch
    RTS

pullpc


NewPullSwitchCheck:
{
    LDA.b $1B : BNE +
        LDA.w $0E20, X : CMP #$04 : BNE .badswitch
            JSL Sprite_LongSwitch_Long
            RTL
            
        .badswitch
        JSL Sprite_BadSwitch_Long
        RTL

    +

    JSL $05D6BC
    RTL
}

NewPrepSwitch:
{
    LDA.b $1B : BNE +
        JSL Sprite_LongSwitch_Prep
        RTL
    +

    LDA $048E

    CMP.b #$CE : BEQ .alpha
    CMP.b #$04 : BEQ .alpha
    CMP.b #$3F : BNE .beta
        .alpha

        LDA.b #$0D : STA $0F50, X

    .beta

    RTL
}

;%Set_Sprite_Properties(Sprite_LongSwitch_Prep, Sprite_LongSwitch_Long);
;==================================================================================================
; Sprite Long Hook for that sprite
; --------------------------------------------------------------------------------------------------
; This code can be left unchanged
; handle the draw code and if the sprite is active and should move or not
;==================================================================================================
Sprite_LongSwitch_Long:
{
    PHB : PHK : PLB
    JSR Sprite_LongSwitch_Draw ; Call the draw code
    JSL Sprite_CheckActive   ; Check if game is not paused
    BCC .SpriteIsNotActive   ; Skip Main code is sprite is innactive
        JSR Sprite_LongSwitch_Main ; Call the main sprite code

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
Sprite_LongSwitch_Prep:
{
    PHB : PHK : PLB
   
    ; Add more code here to initialize data
    LDA $0FDA : STA $0D00, X : CLC : ADC #$08 : STA $0D00, X : STA.w $0FDA
    ;LDA $0FDB : STA $0D20, X : SBC.b #$00 : STA $0D20, X : STA.w $0FDB
    LDA.w $0F60, X : ORA #$20 : STA.w $0F60, X


    REP #$20

    LDA.w $0FDA : STA $02B2
    SEP #$20
    STZ.w SprMiscA, X
    STZ.w SprMiscC, X
    PLB
    RTL
}

;==================================================================================================
; Sprite Main routines code
; --------------------------------------------------------------------------------------------------
; This is the main local code of your sprite
; This contains all the Subroutines of your sprites you can add more below
;==================================================================================================
Sprite_LongSwitch_Main:
LDA.w SprAction, X; Load the SprAction
JSL UseImplicitRegIndexedLocalJumpTable; Goto the SprAction we are currently in
dw Action00


Action00:

LDA.w SprMiscC, X : CMP #$30 : BCC .removecollision
JSR SetCollision
BRA .coll
.removecollision

REP #$20
LDA #$00DA
STA.l $7E2416
STA.l $7E2516
LDA #$00E1
STA.l $7E2496
SEP #$20
.coll
LDA.w SprMiscA, X : BEQ +

LDA.w SprTimerE, X : BNE .timer
LDA #$0F : STA.w SprTimerE, X

LDA.b $F0 : AND.b #$04 : BNE .downpressed
LDA #$01 : STA.w SprMiscB, X
.downpressed

LDA.b $F0 : AND.b #$04 : BEQ .DownNotPressed
INC.w SprMiscB, X
LDA.w SprMiscB, X : CMP #$05 : BNE .noresetanim
LDA #$02 : STA.w SprMiscB, X

.noresetanim
.DownNotPressed
.timer


LDA.b $F0 : AND.b #$04 : BEQ .DownNotPressed2
LDA.w SprTimerD, X : BNE .pulltimer
LDA #$04 : STA.w SprTimerD, X
INC.w SprMiscC, X

LDA.w SprMiscC, X : CMP #$30 : BCC .notend

; we reached the end
STZ.w SprMiscA, X ; remove grab animation
STZ.b $48
STZ.w $0377
STZ.w $0379
JSR CheckAnimation
JSR SetCollision
.notend


REP #$20
INC.w $0FDA
SEP #$20

LDA $0D10, X : SEC : SBC #$04 : STA $22
LDA $0D30, X : SBC #$00 : STA $23
LDA $0FDA : STA $0D00, X : STA $20
LDA $0FDB : STA $0D20, X : STA $21
.pulltimer

.DownNotPressed2
+


LDA.w SprMiscA, X : BEQ + ; if we are NOT pulling ignore this code

LDA.w SprMiscB, X ; update pulling animation frames
STA.w $0377 ; update pulling animation frames

LDA $F2 : BMI .APressed ; a was pressed so do not reset 

STZ.w SprMiscA, X
STZ.b $48
STZ.w $0377
STZ.w $0379
STZ.w SprMiscB, X
LDA.w SprMiscC, X : CMP #$30 : BCS + ; is it pulled more than 0x50 pixels already?

LDA #$01 : STA.w SprMiscD, X
; if we released here and miscc was not higher than 40
+

.APressed

LDA.w SprMiscD, X : BEQ +
LDA.w SprMiscC, X : BEQ .noswitchreturn
DEC.w SprMiscC, X : BNE .notreachedstart

STZ.w SprMiscE, X
STZ.w SprMiscC, X
STZ.w SprMiscD, X
STZ.w SprMiscB, X
STZ.w SprMiscA, X
STZ.b $48
STZ.w $0377
STZ.w $0379


.notreachedstart
REP #$20
DEC.w $0FDA
SEP #$20

LDA $0FDA : STA $0D00, X
LDA $0FDB : STA $0D20, X
+
;DEC.w SprMiscC, X : BNE .noswitchreturn ; if not decrease it back

;REP #$20
;DEC.w $0FDA
;SEP #$20

;LDA $0FDA : STA $0D00, X
;LDA $0FDB : STA $0D20, X

.noswitchreturn
+
.APressed2


STZ.w $0379


LDA.b #$08 : STA $02
             STA $03

LDA $22 : STA $00
LDA $23 : STA $08

LDA $20 : ADC.b #$08 : STA $01
LDA $21 : ADC.b #$00 : STA $09
        
JSL $0683EA ; setup sprite collision


LDA.w SprMiscC, X : CMP #$30 : BCS .done
JSL CheckIfHitBoxesOverlap : BCC .nocollision


STZ $27 ; prevent recoiling
STZ $28 ; prevent recoiling
        
JSL $079291 ; Sprite_RepelDashAttackLong
        
STZ $48 ; prevent pulling animation if we are not pushing A

INC $0379 ; disable A button press if we collide that sprite

LDA $F2 : BPL .ANotPressed
    LDA.w SprMiscA, X : BNE +
    INC.w SprMiscB, X

+

INC.w SprMiscA, X

LDA $0D10, X : STA $22
LDA $0D30, X : STA $23

LDA $0D00, X : STA $20
LDA $0D20, X : STA $21
LDA #$01 : STA $48 ; set link in pulling state

.done
.ANotPressed
.nocollision

RTS

SetCollision:
{
    REP #$20
    LDA #$0334
    STA.l $7E2416
    STA.l $7E2496
    STA.l $7E2516
    ;LDA #$0D23
    ;STA.l $7E2596
    SEP #$20

    RTS
}

CheckAnimation:
{
    LDA $7EF298 : AND #$20 : BNE .noanimation
        LDA #$04 : STA.w $04C6

    .noanimation

    RTS
}

;==================================================================================================
; Sprite Draw code
; --------------------------------------------------------------------------------------------------
; Draw the tiles on screen with the data provided by the sprite maker editor
;==================================================================================================
Sprite_LongSwitch_Draw:
JSL Sprite_PrepOamCoord
LDA #$18
JSL OAM_AllocateFromRegionB
;JSL Sprite_OAM_AllocateDeferToPlayer
LDY #$00 ;Animation Frame
LDA .start_index, Y : STA $06
LDA.w SprMiscC, X : STA $08
STZ $09


PHX
LDA.w SprMiscC, X : CMP #$08 : BCS +
LDX #$00 : BRA ++
+
SEC : SBC #$08 : LSR : LSR : LSR : LSR : INC : TAX
CMP #$05 : BNE ++
DEX
++
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


;JSL Sprite_PrepOamCoord
LDA #$04
JSL OAM_AllocateFromRegionF
LDY #$01
LDA .start_index, Y : STA $06


PHX
LDY.b #$00
.nextTile2

PHX ; Save current Tile Index?
    
TXA : CLC : ADC $06 ; Add Animation Index Offset

PHA ; Keep the value with animation index offset?

ASL A : TAX 

REP #$20

LDA $00 : CLC : ADC .x_offsets, X : STA ($90), Y
AND.w #$0100 : STA $0E 
INY
LDA.b $02
CLC : ADC .y_offsets, X
SEC : SBC $08

STA ($90), Y
CLC : ADC #$0010 : CMP.w #$0100
SEP #$20
BCC .on_screen_y2

LDA.b #$F0 : STA ($90), Y ;Put the sprite out of the way

STA $0E
.on_screen_y2

PLX ; Pullback Animation Index Offset (without the *2 not 16bit anymore)
INY
LDA .chr, X : STA ($90), Y
INY
LDA .properties, X : STA ($90), Y

PHY 
    
TYA : LSR #2 : TAY
    
LDA .sizes, X : ORA $0F : STA ($92), Y ; store size in oam buffer
    
PLY : INY
    
PLX : DEX : BPL .nextTile2

PLX

RTS


;==================================================================================================
; Sprite Draw Generated Data
; --------------------------------------------------------------------------------------------------
; This is where the generated Data for the sprite go
;==================================================================================================
.start_index
db $00
.nbr_of_tiles
db 4
.x_offsets
dw 0, 0, 0, 0
.y_offsets
dw 0, 0, 0, 0
.chr
db $0A, $26, $26, $26, $26
db $08, $08
.properties
db $3B, $3B, $3B, $3B, $3B
db $3B, $3B
.sizes
db $02, $02, $02, $02, $02
db $02, $02


;==================================================================================================
; Sprite Long Hook for that sprite
; --------------------------------------------------------------------------------------------------
; This code can be left unchanged
; handle the draw code and if the sprite is active and should move or not
;==================================================================================================
Sprite_BadSwitch_Long:
PHB : PHK : PLB

JSR Sprite_BadSwitch_Draw ; Call the draw code
JSL Sprite_CheckActive   ; Check if game is not paused
BCC .SpriteIsNotActive   ; Skip Main code is sprite is innactive

JSR Sprite_BadSwitch_Main ; Call the main sprite code

.SpriteIsNotActive
PLB ; Get back the databank we stored previously
RTL ; Go back to original code


;==================================================================================================
; Sprite Main routines code
; --------------------------------------------------------------------------------------------------
; This is the main local code of your sprite
; This contains all the Subroutines of your sprites you can add more below
;==================================================================================================
Sprite_BadSwitch_Main:
LDA.w SprAction, X; Load the SprAction
JSL UseImplicitRegIndexedLocalJumpTable; Goto the SprAction we are currently in
dw Action000


Action000:
JSL $06AA0C ; lift

JSL Sprite_MoveXyz

RTS


;==================================================================================================
; Sprite Draw code
; --------------------------------------------------------------------------------------------------
; Draw the tiles on screen with the data provided by the sprite maker editor
;==================================================================================================
Sprite_BadSwitch_Draw:
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


;==================================================================================================
; Sprite Draw Generated Data
; --------------------------------------------------------------------------------------------------
; This is where the generated Data for the sprite go
;==================================================================================================
.start_index
db $00
.nbr_of_tiles
db 0
.x_offsets
dw 0
.y_offsets
dw 0
.chr
db $0A
.properties
db $3B
.sizes
db $02