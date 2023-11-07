;==============================================================================
; Sprite Properties
;==============================================================================
!SPRID              = $1A; The sprite ID you are overwriting (HEX)
!NbrTiles           = 04 ; Number of tiles used in a frame
!Harmless           = 01  ; 00 = Sprite is Harmful,  01 = Sprite is Harmless
!HVelocity          = 00  ; Is your sprite going super fast? put 01 if it is
!Health             = 00  ; Number of Health the sprite have
!Damage             = 00  ; (08 is a whole heart), 04 is half heart
!DeathAnimation     = 00  ; 00 = normal death, 01 = no death animation
!ImperviousAll      = 00  ; 00 = Can be attack, 01 = attack will clink on it
!SmallShadow        = 00  ; 01 = small shadow, 00 = no shadow
!Shadow             = 00  ; 00 = don't draw shadow, 01 = draw a shadow 
!Palette            = 00  ; Unused in this template (can be 0 to 7)
!Hitbox             = 03  ; 00 to 31, can be viewed in sprite draw tool
!Persist            = 00  ; 01 = your sprite continue to live offscreen
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
!Boss               = 00  ; 00 = normal sprite, 01 = sprite is a boss
%Set_Sprite_Properties(Sprite_Sage_Prep, Sprite_Sage_Long);
;==================================================================================================
; Sprite Long Hook for that sprite
; --------------------------------------------------------------------------------------------------
; This code can be left unchanged
; handle the draw code and if the sprite is active and should move or not
;==================================================================================================
Sprite_Sage_Long:
PHB : PHK : PLB

JSR Sprite_Sage_Draw ; Call the draw code
JSL Sprite_CheckActive   ; Check if game is not paused
BCC .SpriteIsNotActive   ; Skip Main code is sprite is innactive

JSR Sprite_Sage_Main ; Call the main sprite code

.SpriteIsNotActive
PLB ; Get back the databank we stored previously
RTL ; Go back to original code

;==================================================================================================
; Sprite initialization
; --------------------------------------------------------------------------------------------------
; this code only get called once perfect to initialize sprites substate or timers
; this code as soon as the room transitions/ overworld transition occurs
;==================================================================================================
Sprite_Sage_Prep:
PHB : PHK : PLB
   
    ; Add more code here to initialize data

PLB
RTL

;==================================================================================================
; Sprite Main routines code
; --------------------------------------------------------------------------------------------------
; This is the main local code of your sprite
; This contains all the Subroutines of your sprites you can add more below
;==================================================================================================
Sprite_Sage_Main:
LDA.w SprAction, X; Load the SprAction
JSL UseImplicitRegIndexedLocalJumpTable; Goto the SprAction we are currently in
dw Action00
dw Action01
dw Action02
dw Sword


Action00:
JSL Sprite_PlayerCantPassThrough
LDA.w SprSubtype, X : CMP #$01 : BNE .sage
LDA.b #$02 : STA.w SprFrame, X
%GotoAction(3)
.sage
LDA.l $7EF281 : AND #$40 : BNE .alreadyimproved


; Message 121
; I can improve your sword
; by adding sword beams to it
; Do you want me to?
; >  Yes
;    Get the fuck out
%ShowSolicitedMessage($121) : BCC .no_message
%GotoAction(01)
.no_message
RTS

.alreadyimproved
; Message 48
; I already improved your
; sword blablabla...
%ShowSolicitedMessage($48)
RTS

Action01:
LDA.w $1CE8 : BNE .No
%PreventPlayerMovement()
%GotoAction(2)
LDA.b #$1A
JSL Sprite_SpawnDynamically
JSL Sprite_SetSpawnedCoords
LDA.b $22 : STA.w SprX, Y
LDA.b $20 : STA.w SprY, Y
LDA.b #$01 : STA.w SprSubtype, Y
LDA.b #$A0 : STA.w SprTimerA, Y
LDA.w SprX, X : STA.w SprMiscA, Y
LDA.w SprY, X : STA.w SprMiscB, Y
LDA.b #$C0 : STA.w SprTimerA, X
RTS
.No
%GotoAction(0)
RTS

Action02:
%PreventPlayerMovement()
LDA.b #$01 : STA.w SprFrame, X
LDA.w SprTimerA, X : BNE +
LDA.l $7EF281 : ORA #$40 : STA.l $7EF281
LDA.b #$00 : STA.w SprFrame, X
%GotoAction(00)
%AllowPlayerMovement()
+
RTS

Sword:


LDA.w SprMiscA, X : STA $04
LDA.w SprXH, X : STA $05
LDA.w SprMiscB, X : SEC : SBC #$1D : STA $06
LDA.w SprYH, X : STA $07
LDA #$05
JSL Sprite_ProjectSpeedTowardsEntityLong
LDA $00 : STA.w SprYSpeed, X
LDA $01 : STA.w SprXSpeed, X
JSL Sprite_MoveLong


LDA.w SprTimerA, X : BNE +
STZ $0DD0, X
+
RTS



;==================================================================================================
; Sprite Draw code
; --------------------------------------------------------------------------------------------------
; Draw the tiles on screen with the data provided by the sprite maker editor
;==================================================================================================
Sprite_Sage_Draw:
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
db $00, $04, $08
.nbr_of_tiles
db 3, 3, 0
.x_offsets
dw -8, -8, 8, 8
dw -8, 8, -8, 8
dw 0
.y_offsets
dw 0, -16, 0, -16
dw 0, 0, -16, -16
dw 0
.chr
db $62, $60, $62, $60
db $64, $64, $44, $44
db $6A
.properties
db $37, $37, $77, $77
db $37, $77, $37, $77
db $3B
.sizes
db $02, $02, $02, $02
db $02, $02, $02, $02
db $02
