;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
;%       poltargaist set                                    % 
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
ISUU = $01
NATA = $02
SARA = $03
FOOK = $04
KNIF = $05
MADO = $06
GAKU = $07
BEDD = $08
TABL = $09
GOST = $0A

POSTNO:
		db	TABL,FOOK,SARA,KNIF,KNIF,SARA,FOOK,FOOK,SARA,KNIF
		db	ISUU,ISUU,ISUU,BEDD,ISUU
		db	GAKU,GAKU,NATA,NATA
;
;		db	GAKU,MADO,BEDD,ISUU,NATA,SARA,FOOK,KNIF,TABL
POSTXL:
		db	$28,$32,$32,$32,$41,$49,$53,$41,$49,$53
		db	$18,$48,$48,$98,$C8
		db	$9C,$40,$D0,$20

;		db	0A0H,$30,0E0H,090H,0B0H,$D0,0F0H,010H,$30
POSTXH:
		db	#$01,#$01,#$01,#$01,#$01,#$01,#$01,#$01,#$01,#$01
		db	#$01,#$01,#$01,$00,$00
		db	$00,#$01,$00,#$01

;		db	$00,#$01,$00,$00,$00,$00,$00,#$01,#$01
POSTYL:
		db	$50,$4E,$56,$60,$51,$51,$51,$60,$60,$60
		db	$56,$38,$74,$28,$30
		db	$E8,$E8,$EC,$EC

;		db	090H,$30,$30,$20,$40,$60,080H,0A0H,0C0H
POSTYH:
		db	#$01,#$01,#$01,#$01,#$01,#$01,#$01,#$01,#$01,#$01
		db	#$01,#$01,#$01,#$01,#$01
		db	$00,$00,$00,$00

;		db	#$01,#$01,#$01,#$01,#$01,#$01,#$01,#$01,#$01
POSTMD:
		db	$00,#$06,$00,#$06,$00,$00,$00,#$04,$00,#$04
		db	$00,$00,$00,$00,$00
		db	$00,$00,$00,$00
;-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
PORTSET:
		LDA	#$01
		STA	$0FB4
;
		LDX 	#POSTXL-POSTNO-1
;;		LDX 	#$00
PRS010:
		LDA	#$00
		STA	$7FF94A,X
		STA	$7FF90E,X
;
		LDA	POSTMD,X : STA	$7FF9FE,X
		LDA	POSTNO,X : STA	$7FF800,X
		LDA	POSTXL,X : STA	$7FF83C,X
		LDA	POSTXH,X : CLC : ADC	$0FB0 : STA	$7FF878,X
		LDA	POSTYL,X : STA	$7FF81E,X
		LDA	POSTYH,X : CLC : ADC	$0FB1 : STA	$7FF85A,X
		DEX : BPL	PRS010
		RTS

		DEY
		DEY
;
		LDX	#$00
		LDA	#NATA : STA	$7FF800,X
		LDA	($00),Y
		ASL	A
		ASL	A
		ASL	A
		ASL	A
		STA	$7FF81E,X
		LDA	$0FB1
		ADC	#$00
		STA	$7FF85A,X
		INY
		LDA	($00),Y
		ASL	A
		ASL	A
		ASL	A
		ASL	A
		STA	$7FF83C,X
		LDA	$0FB0
		ADC	#$00
		STA	$7FF878,X
		RTS

;===============================================
; Portset Sprite Properties
;===============================================

!SPRID              = $00 ; The sprite ID you are overwriting (HEX)
!NbrTiles           = 00  ; Number of tiles used in a frame
!Harmless           = 00  ; 00 = Sprite is Harmful,  01 = Sprite is Harmless
!HVelocity          = 00  ; Is your sprite going super fast? put 01 if it is
!Health             = 00  ; Number of Health the sprite have
!Damage             = 00  ; (08 is a whole heart), 04 is half heart
!DeathAnimation     = 00  ; 00 = normal death, 01 = no death animation
!ImperviousAll      = 00  ; 00 = Can be attack, 01 = attack will clink on it
!SmallShadow        = 00  ; 01 = small shadow, 00 = no shadow
!Shadow             = 00  ; 00 = don't draw shadow, 01 = draw a shadow 
!Palette            = 00  ; Unused in this Portset (can be 0 to 7)
!Hitbox             = 00  ; 00 to 31, can be viewed in sprite draw tool
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

%Set_Sprite_Properties(Sprite_Portset_Prep, Sprite_Portset_Long)

;===============================================

Sprite_Portset_Long:
{
  PHB : PHK : PLB

  ; JSR Sprite_Portset_Draw 
  JSL Sprite_CheckActive   ; Check if game is not paused
  BCC .SpriteIsNotActive   ; Skip Main code is sprite is innactive

  JSR Sprite_Portset_Main ; Call the main sprite code

.SpriteIsNotActive
  
  PLB ; Get back the databank we stored previously
  RTL ; Go back to original code
}

;===============================================

Sprite_Portset_Prep:
{  
  PHB : PHK : PLB
    
  ; Set initial sprite properties

  PLB
  RTL
}

;===============================================

Sprite_Portset_Main:
{
  LDA.w SprAction, X ; Load the current action of the sprite
  JSL UseImplicitRegIndexedLocalJumpTable

  dw Sprite_Portset_Action_00 ; Action 00

  Sprite_Portset_Action_00:
  {

    RTS
  }
}

;===============================================