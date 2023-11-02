;==============================================================================
; Sprite Properties
;==============================================================================
!SPRID              = $cb; The sprite ID you are overwriting (HEX)
!NbrTiles           = 4 ; Number of tiles used in a frame
!Harmless           = 01  ; 00 = Sprite is Harmful,  01 = Sprite is Harmless
!HVelocity          = 00  ; Is your sprite going super fast? put 01 if it is
!Health             = 5  ; Number of Health the sprite have
!Damage             = 0  ; (08 is a whole heart), 04 is half heart
!DeathAnimation     = 00  ; 00 = normal death, 01 = no death animation
!ImperviousAll      = 01  ; 00 = Can be attack, 01 = attack will clink on it
!SmallShadow        = 00  ; 01 = small shadow, 00 = no shadow
!Shadow             = 00  ; 00 = don't draw shadow, 01 = draw a shadow 
!Palette            = 0  ; Unused in this template (can be 0 to 7)
!Hitbox             = 3  ; 00 to 31, can be viewed in sprite draw tool
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
!Boss               = 01  ; 00 = normal sprite, 01 = sprite is a boss
%Set_Sprite_Properties(Sprite_Facade_Prep, Sprite_Facade_Long);
;==================================================================================================
; Sprite Long Hook for that sprite
; --------------------------------------------------------------------------------------------------
; This code can be left unchanged
; handle the draw code and if the sprite is active and should move or not
;==================================================================================================
Sprite_Facade_Long:


PHB : PHK : PLB

JSR Sprite_Facade_Draw ; Call the draw code
JSL Sprite_CheckActive   ; Check if game is not paused
BCC .SpriteIsNotActive   ; Skip Main code is sprite is innactive

JSR Sprite_Facade_Main ; Call the main sprite code




.SpriteIsNotActive
PLB ; Get back the databank we stored previously
RTL ; Go back to original code


coordxtable:
db $40, $B0, $50, $A0, $60, $90, $70, $80, $80, $70, $90, $60, $A0, $50, $B0, $40
db $30, $C0, $30, $C0, $30, $C0, $30, $C0, $30, $C0, $30, $C0, $30, $C0

coordytable:
db $38, $B8, $38, $B8, $38, $B8, $38, $B8, $38, $B8, $38, $B8, $38, $B8, $38, $B8
db $48, $A8, $58, $98, $68, $88, $78, $78, $88, $68, $98, $58, $A8, $48
;==================================================================================================
; Sprite initialization
; --------------------------------------------------------------------------------------------------
; this code only get called once perfect to initialize sprites substate or timers
; this code as soon as the room transitions/ overworld transition occurs
;==================================================================================================
Sprite_Facade_Prep:
PHB : PHK : PLB
   
    ; Add more code here to initialize data
	LDA.w SprX, X : CLC : ADC #$08 : STA.w SprX, X
	LDA #$00 : STA.l $7EF3CC
	
	LDA.b #$CB
	
	JSL Sprite_SpawnDynamically
	LDA #$04 : STA.w SprSubtype, Y
	LDA #$60 : STA.w SprTimerA, Y
	JSL Sprite_SetSpawnedCoords
	
PLB
RTL

;==================================================================================================
; Sprite Main routines code
; --------------------------------------------------------------------------------------------------
; This is the main local code of your sprite
; This contains all the Subroutines of your sprites you can add more below
;==================================================================================================
Sprite_Facade_Main:
LDA.w SprAction, X; Load the SprAction
JSL UseImplicitRegIndexedLocalJumpTable; Goto the SprAction we are currently in
dw waitbeforespawn
dw spawning
dw messagedisplay
dw mainblinking
dw despawning
dw respawning
dw holespawning
dw holemain
dw holedespawn
dw Dying
dw Maiden
dw MaidenDisappear


waitbeforespawn:
LDA.w SprSubtype, X : CMP #$04 : BNE +
LDA #$30 : STA.w SprTimerA, X
; this is maiden
%GotoAction(10)
LDA #$11 : STA.w SprFrame, X
RTS
+

CMP #$02 : BNE +
; This is a hole
%GotoAction(6)
LDA #$08 : STA.w SprFrame, X
RTS
+

%SetTimerA(200)
%GotoAction(1)

RTS

spawning:
LDA.w SprTimerA, X : BNE +
%SetTimerA(08)
; if waiting timer is done start spawn
; reuse the timer to slow it down
LDA.w SprFrame, X
INC
STA.w SprFrame, X
CMP #$03 : BNE +
%SetTimerA(50)
%GotoAction(2)
+

RTS

messagedisplay:
; Hey, dummy! Need a hint?
; My weak point is...
; 
; Whoops! There i go, talking
; too much again...
LDA.w SprTimerA, X : BNE +
	%ShowUnconditionalMessage(288)
	%GotoAction(3)
	LDA #$30 : STA.w SprTimerA, X
	STA.w SprTimerD, X
+

RTS

mainblinking:
LDA.w SprTimerA, X : BNE +
%PlayAnimation(3, 7, 8)
LDA.w SprFrame, X : CMP #$07 : BNE +
LDA.b #$50 : STA.w SprTimerA, X
LDA.b #$03 : STA.w SprFrame, X

+

LDA.w SprMiscB, X : CMP #$1E : BNE .noholesyet

LDA.w SprTimerC, X : BNE +
LDA.b #$CB ; trinexx sprite
JSL Sprite_SpawnDynamically
LDA.b #$02 ; subtype02
STA.w SprSubtype, Y

.retryPosition
JSL GetRandomInt : AND #$7F
CLC : ADC #$40 : STA.w SprY, Y

JSL GetRandomInt : AND #$7F
CLC : ADC #$40 : STA.w SprX, Y

LDA.b $21 : STA.w SprYH, Y
LDA.b $23 : STA.w SprXH, Y

LDA.w SprY, Y : STA $00
LDA.w SprYH, Y : STA $01

LDA.w SprX, Y : STA $02
LDA.w SprXH, Y : STA $03

PHX
REP #$30

LDA $00 : AND.w #$01F8 : ASL #3 : STA $06
LDA $02 : AND.w #$01F8 : LSR #3 : ORA $06 : STA $06

LDX $06

LDA.l $7F2000, X : BEQ .continue
SEP #$30
PLX
BRA .retryPosition


.continue
SEP #$30
PLX

%SetTimerC(40)
+
.noholesyet
JSL $0683EA ; Sprite_SetupHitBoxLong

LDY.b #$0A ; check all ancilla to find bomb

--
LDA.w $0C4A, Y : CMP #$07 : BNE +
; Is it exploding?
LDA.w $0C5E, Y : CMP #$01 : BNE +

; set hitbox
LDA $0C04, Y : SEC : SBC.b #$08 : STA $00
LDA $0C18, Y : SBC.b #$00 : STA $08
        
LDA $0BFA, Y : SEC : SBC.b #$08 : PHP : SEC : SBC.w $029E, Y : STA $01
LDA $0C0E, Y : SBC.b #$00 : PLP : SBC.b #$00   : STA $09
        
LDA.b #$0F : STA $02
LDA.b #$0F : STA $03

JSL CheckIfHitBoxesOverlap : BCC .noCollision

BRA .damageSprite

+
DEY : BPL --
.noCollision


LDA.w SprMiscB, X : CMP #$1E : BEQ .spawnFailed
LDA.w SprTimerD, X : BNE .spawnFailed
LDA #$40 : STA.w SprTimerD, X

LDA.b #$94 : JSL Sprite_SpawnDynamically : BMI .spawnFailed

LDA.b #$01 : STA $0E90, Y

PHX : LDA.w SprMiscB, X : TAX



LDA.w coordxtable, X : STA.w SprX, Y

LDA.w coordytable, X : STA.w SprY, Y

PLX


LDA $21 : STA.w $0D20, Y
LDA $23 : STA.w $0D30, Y

LDA.b #$04 : STA.w $0E50, Y

LDA.b #$00 : STA.w $0BE0, Y
             STA.w $0E50, Y

LDA.b #$08 : STA.w $0CAA, Y
LDA.b #$04 : STA.w $0E40, Y
LDA.b #$01 : STA.w $0F50, Y
LDA.b #$04 : STA.w $0CD2, Y

INC.w SprMiscB, X

.spawnFailed

RTS


.damageSprite
LDA.b #$48 : STA.w SprTimerE, X
DEC.w SprHealth, X : BNE .notDead
	; dead
	LDA.b #$04 : STA.w $0DD0, X
	STZ.w $0D90, X
    ;LDA #$02 : STA.w SprFrame, X
    LDA.b #$E0 : STA.w SprTimerA, X
	LDA.b #$9F : STA.w SprDeath, X
	%GotoAction(9)
	RTS
.notDead
LDA.b #$68 : STA.w SprTimerA, X
%GotoAction(4)

RTS

despawning:

LDA.w SprTimerA, X : BNE +
%SetTimerA(08)
; if waiting timer is done start spawn
; reuse the timer to slow it down
LDA.w SprFrame, X
DEC
STA.w SprFrame, X
BNE +
%SetTimerA(50)
%GotoAction(5)
JSL GetRandomInt : AND #$7F
CLC : ADC #$40 : STA.w SprY, X


JSL GetRandomInt : AND #$7F
CLC : ADC #$40 : STA.w SprX, X


;0x48 min
;0x9E max

; that's a range of 0x56 pixels
+


RTS

respawning:
LDA.w SprTimerA, X : BNE +
%SetTimerA(08)



; if waiting timer is done start spawn
; reuse the timer to slow it down
LDA.w SprFrame, X
INC
STA.w SprFrame, X
CMP #$03 : BNE +
%SetTimerA(50)
%GotoAction(3)
+

RTS

holespawning:
LDA.w SprTimerA, X : BNE +
%SetTimerA(08)
; if waiting timer is done start spawn
; reuse the timer to slow it down
LDA.w SprFrame, X
INC
STA.w SprFrame, X
CMP #$0B : BNE +



LDA.w SprY, X : STA $00
LDA.w SprYH, X : STA $01

LDA.w SprX, X : STA $02
LDA.w SprXH, X : STA $03

PHX
REP #$30

LDA $00 : AND.w #$01F8 : ASL #3 : STA $06
LDA $02 : AND.w #$01F8 : LSR #3 : ORA $06 : STA $06

LDX $06
LDA #$2020
STA.l $7F2040, X
STA.l $7F2080, X

SEP #$30
PLX



%GotoAction(7)
%SetTimerA(140)
+

RTS

holemain:
; set hole collision here




LDA.w SprTimerA, X : BNE ++
; if link is falling hold on!
LDA.b $5D : CMP #$01 : BEQ +

%SetTimerA(08)
%GotoAction(8)

; set it back to normal collision here
+

JSL Sprite_CheckDamageToPlayer : BCC .collision

%SetTimerA(08)
%GotoAction(8)
.collision

++

RTS

holedespawn:
LDA.w SprTimerA, X : BNE +
%SetTimerA(08)
; if waiting timer is done start spawn
; reuse the timer to slow it down
LDA.w SprFrame, X
INC
STA.w SprFrame, X
CMP.b #$0F : BNE +
STZ.w $0DD0, X ; kill the sprite

+



LDA.w SprY, X : STA $00
LDA.w SprYH, X : STA $01

LDA.w SprX, X : STA $02
LDA.w SprXH, X : STA $03

PHX
REP #$30

LDA $00 : AND.w #$01F8 : ASL #3 : STA $06
LDA $02 : AND.w #$01F8 : LSR #3 : ORA $06 : STA $06

LDX $06
LDA #$0000
STA.l $7F2040, X
STA.l $7F2080, X

SEP #$30
PLX


RTS

Dying:


RTS

Maiden:
%PlayAnimation(17, 18, 50)

LDA.w SprTimerA, X : BNE +
%GotoAction(11)
%ShowUnconditionalMessage(291)
LDA #$30 : STA.w SprTimerA, X

+

RTS

MaidenDisappear:
%PlayAnimation(17, 20, 02)
LDA.w SprTimerA, X : BNE +
STZ.w $0DD0, X

+

RTS

;==================================================================================================
; Sprite Draw code
; --------------------------------------------------------------------------------------------------
; Draw the tiles on screen with the data provided by the sprite maker editor
;==================================================================================================
Sprite_Facade_Draw:
JSL Sprite_PrepOamCoord
LDA.w SprSubtype, X : CMP #$04 : BEQ .defer
LDA #$04
JSL OAM_AllocateFromRegionB
BRA .nodefer
.defer
JSL Sprite_OAM_AllocateDeferToPlayer
.nodefer
STX $09
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

PHX
LDX $09
LDA.w SprTimerE, X : BNE .damaged
PLX

.notdamaged
LDA .properties, X : STA ($90), Y
BRA .continuedraw

.damaged
PLX
LDA.b $1A : AND #$07 : ASL : STA.b $09
LDA .properties, X : AND #$F1 : ORA.b $09 : STA ($90), Y


.continuedraw
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
db $00, $04, $08, $0C, $10, $14, $18, $1C, $20, $21, $22, $23, $24, $25, $26, $27, $28, $2A, $2B, $2D
.nbr_of_tiles
db 3, 3, 3, 3, 3, 3, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0
.x_offsets
dw -16, 0, -16, 0
dw -16, 16, -8, 8
dw -16, 16, -8, 8
dw -16, 16, -8, 8
dw -8, 8, -16, 16
dw -8, 8, -16, 16
dw -8, 8, -16, 16
dw -16, 16, -8, 8
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0, 0
dw 0
dw 0, 0
dw 0
.y_offsets
dw 0, 0, 16, 16
dw -8, -8, 8, 8
dw -8, -8, 8, 8
dw -8, -8, 8, 8
dw 8, 8, -8, -8
dw 8, 8, -8, -8
dw 8, 8, -8, -8
dw -8, -8, 8, 8
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0, -10
dw 0
dw 0, -10
dw 0
.chr
db $0E, $0E, $0E, $0E
db $00, $00, $06, $08
db $02, $02, $06, $06
db $04, $04, $0A, $0C
db $0A, $0C, $02, $02
db $0A, $0C, $00, $00
db $0A, $0C, $02, $02
db $04, $04, $0A, $0C
db $20
db $22
db $24
db $26
db $24
db $22
db $20
db $0E
db $4A, $40
db $4E
db $4A, $40
db $4E
.properties
db $39, $39, $39, $39
db $39, $79, $39, $39
db $39, $79, $39, $79
db $39, $79, $39, $39
db $39, $39, $39, $79
db $39, $39, $39, $79
db $39, $39, $39, $79
db $39, $79, $39, $39
db $39
db $39
db $39
db $39
db $39
db $39
db $39
db $31
db $37, $37
db $37
db $77, $37
db $37
.sizes
db $02, $02, $02, $02
db $02, $02, $02, $02
db $02, $02, $02, $02
db $02, $02, $02, $02
db $02, $02, $02, $02
db $02, $02, $02, $02
db $02, $02, $02, $02
db $02, $02, $02, $02
db $02
db $02
db $02
db $02
db $02
db $02
db $02
db $02
db $02, $02
db $02
db $02, $02
db $02
