;==============================================================================
; Sprite Properties
;==============================================================================
!SPRID              = $CD; The sprite ID you are overwriting (HEX)
!NbrTiles           = 4 ; Number of tiles used in a frame
!Harmless           = 00  ; 00 = Sprite is Harmful,  01 = Sprite is Harmless
!HVelocity          = 00  ; Is your sprite going super fast? put 01 if it is
!Health             = 25  ; Number of Health the sprite have
!Damage             = 04  ; (08 is a whole heart), 04 is half heart
!DeathAnimation     = 00  ; 00 = normal death, 01 = no death animation
!ImperviousAll      = 00  ; 00 = Can be attack, 01 = attack will clink on it
!SmallShadow        = 00  ; 01 = small shadow, 00 = no shadow
!Shadow             = 00  ; 00 = don't draw shadow, 01 = draw a shadow 
!Palette            = 0  ; Unused in this template (can be 0 to 7)
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
!Boss               = 01  ; 00 = normal sprite, 01 = sprite is a boss
%Set_Sprite_Properties(Sprite_PumpkinHead_Prep, Sprite_PumpkinHead_Long);
;==================================================================================================
; Sprite Long Hook for that sprite
; --------------------------------------------------------------------------------------------------
; This code can be left unchanged
; handle the draw code and if the sprite is active and should move or not
;==================================================================================================
Sprite_PumpkinHead_Long:
PHB : PHK : PLB

JSR Sprite_PumpkinHead_Draw ; Call the draw code
JSL Sprite_CheckActive   ; Check if game is not paused
BCC .SpriteIsNotActive   ; Skip Main code is sprite is innactive
	JSR Sprite_PumpkinHead_Main ; Call the main sprite code

.SpriteIsNotActive
PLB ; Get back the databank we stored previously
RTL ; Go back to original code

;==================================================================================================
; Sprite initialization
; --------------------------------------------------------------------------------------------------
; this code only get called once perfect to initialize sprites substate or timers
; this code as soon as the room transitions/ overworld transition occurs
;==================================================================================================
Sprite_PumpkinHead_Prep:
PHB : PHK : PLB

    ; Add more code here to initialize data
    LDA.b #$6F : STA.w SprHeight, X
    LDA.b #$00 : STA.w SprFrame, X
    LDA.b #$01 : STA.w SprMiscF, X
    LDA.b #$35 : STA.w SprHealth, X
	LDA.b !Damage : STA $0CD2, X
    STX.w $0FC0 ; keep spirit id
    
    ; Spawn the head
    LDA #$CD
    JSL Sprite_SpawnDynamically
    JSL Sprite_SetSpawnedCoords
    LDA.b #$01 : STA.w SprSubtype, Y
    LDA.b #$7F : STA.w SprHeight, Y
    LDA.b #$01 : STA.w SprAction, Y 
    LDA.b #$04 : STA.w SprFrame, Y
    LDA.b #$01 : STA.w SprMiscF, Y
	LDA.b !Damage : STA $0CD2, Y
    STA.w SprMiscG, Y ; on body
    
    ; Spawn the body
    LDA #$CD
    JSL Sprite_SpawnDynamically
    JSL Sprite_SetSpawnedCoords
    LDA.b #$02 : STA.w SprSubtype, Y
    LDA.b #$5F : STA.w SprHeight, Y
    LDA.b #$02 : STA.w SprAction, Y 
    LDA.b #$06 : STA.w SprFrame, Y : STA.w SprMiscC, Y
    LDA.b #$08 : STA.w SprXSpeed, Y
    LDA.b #$40 : STA.w SprTimerA, Y  : STA.w SprTimerB, Y
    LDA.b #$03 : STA.w SprMiscG, Y ; Body Health
    LDA.b #$01 : STA.w SprMiscF, Y ; Visibility (invisible if zero)
	LDA.b !Damage : STA $0CD2, Y

PLB
RTL

;==================================================================================================
; Sprite Main routines code
; --------------------------------------------------------------------------------------------------
; This is the main local code of your sprite
; This contains all the Subroutines of your sprites you can add more below
;==================================================================================================
Sprite_PumpkinHead_Main:
LDA.w SprAction, X; Load the SprAction
CMP #$80 : BNE +
	RTS

+

JSL UseImplicitRegIndexedLocalJumpTable; Goto the SprAction we are currently in
	dw Spiritx
	dw Head
	dw Body
	dw DyingPumpkin


Spiritx:
; SUBTYPE 00 spirit

; respawn the body!
JSL Sprite_MoveZ
DEC $0F80, X : DEC $0F80, X
        
LDA.w SprMiscG, X : BNE .alive
    LDA.b #$80 : STA.w SprTimerD, X ; set timer so when it become alive it run away
    ; timer handled from the head for multiple reasons
        
    LDA $0F70, X : CMP #$10 : BCS .inAir
	    ;LDA $0F70, X : BPL .inair
	        
	    ;STZ $0F70, X
	        
	    LDA.b #$10 : STA $0F70, X
	        
	    STZ $0F80, X
	        
	    STZ.w SprMiscF, X
        
    .inAir
    	
    RTS
    
.alive

%PlayAnimation(0, 1, 8)

STZ $0F70, X ; set height to 0
STZ $0F80, X

LDA #$00 : STA.w SprMiscC, X
LDA.w SprTimerD, X : BEQ .runaway
	LDA.b #$0D : JSL Sprite_ApplySpeedTowardsPlayer ; run away
	LDA.w SprXSpeed, X : EOR #$FF : STA.w SprXSpeed, X
	LDA.w SprYSpeed, X : EOR #$FF : STA.w SprYSpeed, X
	
.runaway

LDA $0E70, X : BNE .hit_tile
     JSL Sprite_Move
    
.hit_tile

JSL Sprite_CheckTileCollision

LDA.w SprMiscG, X : BEQ .notalive
	LDA.w SprTimerD, X : CMP #$46 : BCS .notalive ; do not damage first few frames
		LDA #$01 : STA.w SprMiscC, X
		JSL Sprite_CheckDamageToPlayer
	
.notalive

JSL Sprite_CheckDamageFromPlayer : BCC .nodamage
	LDA #$10 : STA.w SprTimerC, X
	LDA.w SprHealth, X : CMP.b #$20 : BCS .nodamage
		; dead
		LDA.b #$04 : STA.w $0DD0, X
		STZ.w $0D90, X
		
	    ;LDA #$02 : STA.w SprFrame, X
	    LDA.b #$E0 : STA.w SprTimerA, X
		LDA.b #$9F : STA.w SprDeath, X
		
		LDY #$10
		--
			CPY $0FC0 : BEQ .next ; was this sprite
				LDA #$00 : STA.w $0DD0, Y
			
			.next
		DEY : BPL --
		LDA #$03 : STA.w SprAction, X ; send it to empty routine to die
		
		RTS

.nodamage

LDA.w SprTimerC, X : STA.w $0F50, X : BNE .paletteCycling
	STZ.w $0F50, X
		
.paletteCycling

RTS


Head:
; SUBTYPE01
PHX
LDX.w $0FC0

LDA.w SprMiscG, X : BNE .continue
	JMP .ignorespirit
	
.continue

;04 = X
;05 = HighX
;06 = Y
;07 = HighY
;A = Speed

;Return $00 - Y Velocity
;Return $01 - X Velocity

LDA.w SprTimerD, X : BNE .notgoingback
	LDA.w $0FD8 : STA.b $04
	LDA.w $0FD9 : STA.b $05
	LDA.w $0FDA : STA.b $06
	LDA.w $0FDB : STA.b $07
	LDA.b #$10
	JSL Sprite_ProjectSpeedTowardsEntityLong
	LDA.b $01 : STA.w SprXSpeed, X
	LDA.b $00 : STA.w SprYSpeed, X
	
	LDA $0FD8 ; Sprite X
	CLC : SBC.w SprX, X
	BPL +
		EOR #$FF
		
	+
	
	STA $00 ; Distance X (ABS)
	
	LDA $0FDA ; Sprite Y
	CLC : SBC.w SprY, X ; - Player Y
	BPL +
		EOR #$FF
		
	+
	
	; Add it back to X Distance
	CLC : ADC $00 ; distance total X, Y (ABS)
	
	CMP #$10 : BCS .notcloseenough
		LDA #$80 : STA.w SprTimerD, X
		STZ.w SprXSpeed, X
		STZ.w SprYSpeed, X
		STZ.w SprMiscG, X
		STZ.w SprMiscF, X
		
		PLX
		LDA.w SprMiscC, X : BEQ +
			LDA #$01 : STA.w SprMiscD, X ; make it poof back
			LDA #$36 : STA.w $0F80, X
			LDA #$25 : STA.w SprTimerE, X
		+
		
		DEX
		LDA.w $0FD8 : STA.w SprX, X
		LDA.w $0FDA : STA.w SprY, X
		INX
		
		BRA +
	
	.notcloseenough
.notgoingback

.ignorespirit

LDA.w SprMiscG, X
PLX
CMP #$00 : BNE .cantlift
	JSL $06AA0C ; lift
	
.cantlift

LDA.w $0DD0, X : CMP.b #$0A : BNE + ; only ran once it seems
	; sprite has been lifted so spirit is exiting
	PHX
	LDX.w $0FC0
	
	LDA.w $0FD8 ; cached X 16bit pos
	STA.w SprX, X
	LDA.w $0FDA ; cached Y 16bit pos
	STA.w SprY, X
	LDA #$80 : STA.w SprTimerD, X
	LDA #$01 : STA.w SprMiscF, X ; make spirit visible
	STA.w SprMiscG, X ; make the spirit alive
	PLX
+

PHX
LDX.w $0FC0
LDA.w SprTimerD, X : CMP #$10 : BCS .canlift
	PLX
	LDA #$01 : STA.w SprMiscC, X
	BRA .skipPLX

.canlift

PLX

.skipPLX

JSL Sprite_CheckTileCollision : BEQ .nocollision
	STZ.w SprXSpeed, X
	STZ.w SprYSpeed, X
	
.nocollision

JSL Sprite_MoveXyz

DEC $0F80, X : DEC $0F80, X
LDA.w SprMiscG, X : BNE .OnBody
        	LDA $0F70, X : BPL .inair
		        STZ $0F70, X
		        
		        STZ $0F80, X
	        
	        	BRA .inair
        
.OnBody
        
LDA #$FF : STA.w SprTimerE, X
        
LDA $0F70, X : CMP #$10 : BCS .inair
	LDA.b #$10 : STA $0F70, X
	        
	STZ $0F80, X

.inair
    
LDA.w SprMiscD, X : BEQ .nopoof
	LDA.w SprMiscG, X : BNE .nopoof
		LDA.w SprTimerE, X : BNE .nopoof
		    	STZ.w SprMiscD, X
		    	LDA #$FF : STA.w SprTimerE, X
		    	
		       JSL $05AB9C ; Sprite_SpawnPoofGarnish
		       LDA #$01 : STA.w SprMiscG, X
		       DEX
		       STA.w SprMiscF, X
			LDA #$03 : STA SprMiscG, X
			INX
    
.nopoof

LDA.w SprYSpeed, X : BEQ .nochangeY
    	BMI .increaseY
	    	DEC.w SprYSpeed, X : DEC.w SprYSpeed, X
	    	
	    	BRA .nochangeY
	    	
    	.increaseY
    	INC.w SprYSpeed, X : INC.w SprYSpeed, X
    	
.nochangeY
    
LDA.w SprXSpeed, X : BEQ .nochangeX
    	BMI .increaseX
    		DEC.w SprXSpeed, X : DEC.w SprXSpeed, X
    		BRA .nochangeX
    		
    	.increaseX
    	
    	INC.w SprXSpeed, X : INC.w SprXSpeed, X
    	
.nochangeX

RTS

Body:
; SUBTYPE02

LDA.w SprMiscG, X : BNE .continue
	RTS ; otherwise just ignroe that code entirely
	
.continue

LDA.w SprMiscE, X : BEQ .normal
	JSR SetSubspritesPositions
	LDA.b #$10 : STA.b $09
	LDA.b #$40 : STA.b $08
	JSL Sprite_Bouncetowardplayer
	LDA.w $0F70, X : CMP #$08 : BCS .inairbounce
		STZ.w $0F70, X
		STZ.w SprMiscE, X
	
	.inairbounce
	
	;LDA.w $0F70, X : CLC : ADC #$10
	;INX
	;STA.w $0F70, X
	;DEX
	
	LDA.w $0F80, X
	INX
	STA.w $0F80, X
	DEX
	
	BRA .inair
	
.normal

JSL Sprite_MoveZ

DEC $0F80, X : DEC $0F80, X
    
LDA $0F70, X : BPL .inair
	LDA #$01 : STA.w SprMiscA, X
	    
	STZ $0F70, X
	
	STZ $0F80, X
        
.inair
LDA.w SprMiscE, X : BNE .spritehaslanded
	LDA.w SprMiscA, X : BEQ .spritehaslanded
	    	LDA.w SprTimerA, X : BNE .noDirectionChange
			JSL GetRandomInt : AND #$03 : STA.w SprMiscB, X ; can decide to jump too TODO
		    
		    	TAY
		    
		    	JSL GetRandomInt : AND #$07 : STA.w SprMiscE, X
		    	LDA.w directionXSpeed, Y : STA.w SprXSpeed, X
		    	LDA.w directionYSpeed, Y : STA.w SprYSpeed, X
		    	LDA.w directionStartFrame, Y : STA.w SprMiscC, X : STA.w SprFrame, X
		    
		    	JSL GetRandomInt : AND #$3F : STA $00
		    	LDA #$20 : CLC : ADC $00 : STA.w SprTimerA, X
		    
	   	.noDirectionChange
	    
	   	JSL Sprite_CheckTileCollision : BEQ .nocollision
		    	LDA.w SprXSpeed, X : EOR #$FF : STA.w SprXSpeed, X
		    	LDA.w SprYSpeed, X : EOR #$FF : STA.w SprYSpeed, X
	    
	    	.nocollision
	    
	    	JSL Sprite_Move
	    
	    	LDA.w SprTimerB, X : BNE +
		    	LDA #$20 : STA.w SprTimerB, X
		    	LDA.w SprMiscC, X : CMP.w SprFrame, X : BNE .notsameframe
		    		INC
		    	
		    	.notsameframe
		    	
		    	STA.w SprFrame, X
	    	+
    
    		JSR SetSubspritesPositions

.spritehaslanded
    
LDA.w SprTimerC, X : BNE .paletteCycling
STZ.w $0F50, X
	
JSL Sprite_CheckDamageFromPlayer : BCC .noDamage
	LDA #$16 : STA.w SprTimerC, X
	LDA #$50 : STA.w SprHealth, X ; always set the health back to 50
	DEC.w SprMiscG, X : BNE .havehitremain
		; faire disparaitre le corp et faire tomber la tête
		JSL $05AB9C ; Sprite_SpawnPoofGarnish
		STZ.w SprMiscF, X
		INX 
		LDA #$05 : STA.w SprTimerE, X 
		STZ.w SprMiscG, X
		STZ.w SprXSpeed, X
		STZ.w SprYSpeed, X
		STZ.w SprMiscD, X ; prevent body from poofing back
		LDA.b #$10 : STA $0F80, X
		DEX
		
	.havehitremain
.noDamage
	
LDA.w SprMiscG, X : BEQ .continue2
	JSL Sprite_CheckDamageToPlayer
		
.continue2

RTS

.paletteCycling
LDA $1A : AND #$0F : STA.w $0F50, X
RTS


directionXSpeed:
db 0, 0, -8, 8
directionYSpeed:
db 8, -8, 0, 0
directionStartFrame:
db 6, 8, 10, 12

directionHeadFrame:
db 4, 5, 2, 3


SetSubspritesPositions:
; Store X
    
PHX
LDY.w SprMiscB, X
	
INX ; Head
LDA.w $0FD8 ; cached X 16bit pos
STA.w SprX, X
LDA.w $0FDA ; cached Y 16bit pos
STA.w SprY, X
LDA.w directionHeadFrame, Y : STA.w SprFrame, X
PLX
	
RTS

DyingPumpkin:

RTS

;==================================================================================================
; Sprite Draw code
; --------------------------------------------------------------------------------------------------
; Draw the tiles on screen with the data provided by the sprite maker editor
;==================================================================================================
Sprite_PumpkinHead_Draw:
LDA.w SprMiscF, X : BNE .draw
	RTS
	
.draw

JSL Sprite_PrepOamCoord

LDA #$04
JSL OAM_AllocateFromRegionA

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
	LDA .properties, X : ORA $05 : STA ($90), Y
	
	PHY 
	    
	TYA : LSR #2 : TAY
	    
	LDA .sizes, X : ORA $0F : STA ($92), Y ; store size in oam buffer
	    
	PLY : INY
    
PLX : DEX : BPL .nextTile

PLX

LDA.w SprSubtype, X : CMP #$02 : BNE .drawshadow
	JSL Sprite_DrawShadow
.drawshadow

RTS


;==================================================================================================
; Sprite Draw Generated Data
; --------------------------------------------------------------------------------------------------
; This is where the generated Data for the sprite go
;==================================================================================================
.start_index
db $00, $01, $02, $05, $08, $0B, $0E, $10, $12, $14, $16, $18, $1A, $1C
.nbr_of_tiles
db 0, 0, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1
.x_offsets
dw 0
dw 0
dw -8, 8, 4
dw 8, -7, 4
dw -8, 8, 3
dw -8, 8, 3
dw -8, 8
dw 8, -8
dw -8, 8
dw 8, -8
dw -8, 8
dw -8, 8
dw 8, -8
dw 8, -8
.y_offsets
dw 0
dw 0
dw 0, 0, -5
dw 0, 0, -5
dw 0, 0, -5
dw 0, 0, -5
dw 0, 0
dw 0, 0
dw 0, 0
dw 0, 0
dw 0, 0
dw 0, 0
dw 0, 0
dw 0, 0
.chr
db $08
db $0A
db $04, $06, $0F
db $04, $06, $0F
db $00, $00, $0F
db $02, $02, $0F
db $20, $22
db $20, $22
db $2C, $2E
db $2C, $2E
db $24, $26
db $28, $2A
db $24, $26
db $28, $2A
.properties
db $33
db $33
db $33, $33, $33
db $73, $73, $33
db $33, $73, $33
db $33, $73, $33
db $39, $39
db $79, $79
db $39, $39
db $79, $79
db $39, $39
db $39, $39
db $79, $79
db $79, $79
.sizes
db $02
db $02
db $02, $02, $00
db $02, $02, $00
db $02, $02, $00
db $02, $02, $00
db $02, $02
db $02, $02
db $02, $02
db $02, $02
db $02, $02
db $02, $02
db $02, $02
db $02, $02
