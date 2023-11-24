;==============================================================================
; Sprite Properties
;==============================================================================

!SPRID              = $D6 ; The sprite ID you are overwriting (HEX)
!NbrTiles           = 4 ; Number of tiles used in a frame
!Harmless           = 01  ; 00 = Sprite is Harmful,  01 = Sprite is Harmless
!HVelocity          = 00  ; Is your sprite going super fast? put 01 if it is
!Health             = 0  ; Number of Health the sprite have
!Damage             = 0  ; (08 is a whole heart), 04 is half heart
!DeathAnimation     = 00  ; 00 = normal death, 01 = no death animation
!ImperviousAll      = 01  ; 00 = Can be attack, 01 = attack will clink on it
!SmallShadow        = 00  ; 01 = small shadow, 00 = no shadow
!Shadow             = 00  ; 00 = don't draw shadow, 01 = draw a shadow 
!Palette            = 0  ; Unused in this template (can be 0 to 7)
!Hitbox             = 11  ; 00 to 31, can be viewed in sprite draw tool
!Persist            = 00  ; 01 = your sprite continue to live offscreen
!Statis             = 00  ; 00 = is sprite is alive?, (kill all enemies room)
!CollisionLayer     = 00  ; 01 = will check both layer for collision
!CanFall            = 00  ; 01 sprite can fall in hole, 01 = can't fall
!DeflectArrow       = 01  ; 01 = deflect arrows
!WaterSprite        = 00  ; 01 = can only walk shallow water
!Blockable          = 00  ; 01 = can be blocked by link's shield?
!Prize              = 0  ; 00-15 = the prize pack the sprite will drop from
!Sound              = 00  ; 01 = Play different sound when taking damage
!Interaction        = 00  ; ?? No documentation
!Statue             = 00  ; 01 = Sprite is statue
!DeflectProjectiles = 01  ; 01 = Sprite will deflect ALL projectiles
!ImperviousArrow    = 01  ; 01 = Impervious to arrows
!ImpervSwordHammer  = 01  ; 01 = Impervious to sword and hammer attacks
!Boss               = 00  ; 00 = normal sprite, 01 = sprite is a boss
%Set_Sprite_Properties(Sprite_Snorlax_Prep, Sprite_Snorlax_Long)

;==================================================================================================
; Sprite Long Hook for that sprite
; --------------------------------------------------------------------------------------------------
; This code can be left unchanged
; handle the draw code and if the sprite is active and should move or not
;==================================================================================================
Sprite_Snorlax_Long:
{
	PHB : PHK : PLB

	JSR Sprite_Snorlax_Draw ; Call the draw code
	JSL Sprite_CheckActive   ; Check if game is not paused

	BCC .SpriteIsNotActive   ; Skip Main code is sprite is innactive
		JSR Sprite_Snorlax_Main ; Call the main sprite code

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

Sprite_Snorlax_Prep:
{
	PHB : PHK : PLB
	
	; Add more code here to initialize data
		
	PHX ; keep sprite in dex
	LDX $8A ; load map index
	LDA.l $7EF280, X : AND #$40 : BEQ .NotGone
		PLX
		STZ.w $0DD0, X

		BRA .return
	
	.NotGone

	PLX

	.return

	PLB
	RTL
}

;==================================================================================================
; Sprite Main routines code
; --------------------------------------------------------------------------------------------------
; This is the main local code of your sprite
; This contains all the Subroutines of your sprites you can add more below
;==================================================================================================

Sprite_Snorlax_Main:
{
	LDA.w SprAction, X; Load the SprAction
	JSL UseImplicitRegIndexedLocalJumpTable; Goto the SprAction we are currently in

	dw StandingWaiting
	dw BookRead
	dw PhasingOut
}

StandingWaiting:
{
	LDA.w $0F60,X
	PHA

	LDA #$07 : STA.w $0F60,X

	JSL Sprite_CheckDamageToPlayerSameLayer : BCC .no_collision
		JSR Sprite_HaltAllMovement

	.no_collision

	PLA
	STA.w $0F60,X

	%ShowSolicitedMessage($42)

	; Check if player have book equipped
	LDA.w $0303 : CMP #$0C : BNE .nobookequipped
		; Check if player is close enough

		REP #$20
		JSR GetLinkDistance16bit : CMP #$0030 : BCS .toofar
			SEP #$20
			LDA.b $F0 : AND.b #$40 : BEQ .YNotPressed
				LDA #$09 : STA.w $012E ; clear the buzz souund of the book multiple times
				%GotoAction(1)

			.YNotPressed
		.toofar

		SEP #$20

	.nobookequipped

	RTS
}

Sprite_HaltAllMovement:
{
	PHX

	JSL Sprite_NullifyHookshotDrag

	STZ.b $5E

	JSL Player_HaltDashAttack

	PLX

	RTS
}

BookRead:
{
	LDA #$33 : STA.w $012E ; play minor puzzle sound ( optional )
	PHX ; keep sprite in dex
	LDX $8A ; load map index
	LDA #$40 : STA.l $7EF280, X
	PLX

	%GotoAction(2)
	%SetTimerA(60) ; amount of frames flashing

	RTS
}

PhasingOut:
{
	LDA.w SprTimerA, X : BNE .stillalive
		STZ $0DD0, X ; kill the sprite

	.stillalive

	AND #$01 : STA.w SprMiscA, X

	RTS
}

;==================================================================================================
; Sprite Draw code
; --------------------------------------------------------------------------------------------------
; Draw the tiles on screen with the data provided by the sprite maker editor
;==================================================================================================

Sprite_Snorlax_Draw:
{
	LDA SprMiscA, X : BEQ .draw
		RTS

	.draw

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

;==================================================================================================
; Sprite Draw Generated Data
; --------------------------------------------------------------------------------------------------
; This is where the generated Data for the sprite go
;==================================================================================================
	
	.start_index
	db $00

	.nbr_of_tiles
	db 3

	.x_offsets
	dw -8, 8, -8, 8

	.y_offsets
	dw 8, 8, -8, -8

	.chr
	db $E6, $E6, $E4, $E4

	.properties
	db $39, $79, $39, $79
	
	.sizes
	db $02, $02, $02, $02
