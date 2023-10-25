;===============================================
; Poltergeist Sprite Properties
;===============================================

!SPRID              = $6B ; Overwriting Cannon Soldier
!NbrTiles           = 04  ; Number of tiles used in a frame
!Harmless           = 00  ; 00 = Sprite is Harmful,  01 = Sprite is Harmless
!HVelocity          = 00  ; Is your sprite going super fast? put 01 if it is
!Health             = 00  ; Number of Health the sprite have
!Damage             = 04  ; (08 is a whole heart), 04 is half heart
!DeathAnimation     = 00  ; 00 = normal death, 01 = no death animation
!ImperviousAll      = 00  ; 00 = Can be attack, 01 = attack will clink on it
!SmallShadow        = 00  ; 01 = small shadow, 00 = no shadow
!Shadow             = 01  ; 00 = don't draw shadow, 01 = draw a shadow 
!Palette            = 00  ; Unused in this Poltergeist (can be 0 to 7)
!Hitbox             = 00  ; 00 to 31, can be viewed in sprite draw tool
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
!Boss               = 00  ; 00 = normal sprite, 01 = sprite is a boss

;%Set_Sprite_Properties(Sprite_Poltergeist_Prep, Sprite_Poltergeist_Long)

;===============================================

Sprite_Poltergeist_Long:
{
  PHB : PHK : PLB

  JSR Sprite_Poltergeist_Draw ; Call the draw code
  JSL Sprite_DrawShadow
  JSL Sprite_CheckActive   ; Check if game is not paused
  BCC .SpriteIsNotActive   ; Skip Main code is sprite is innactive

  JSR Sprite_Poltergeist_Main ; Call the main sprite code

.SpriteIsNotActive
  
  PLB ; Get back the databank we stored previously
  RTL ; Go back to original code
}

;===============================================

Sprite_Poltergeist_Prep:
{  
  PHB : PHK : PLB
    
  ; Set initial sprite properties
  LDA #$00 : STA $0CAA, X

  PLB
  RTL
}

;===============================================

Sprite_Poltergeist_Main:
{
  LDA.w SprAction, X ; Load the current action of the sprite
  JSL UseImplicitRegIndexedLocalJumpTable

  dw Poltergeist_Dictate
  dw Poltergeist_Chair
  dw Poltergeist_Axe
  dw Poltergeist_Dish
  dw Poltergeist_Fork
  dw Poltergeist_Knife
  dw Poltergeist_Window
  dw Poltergeist_Frame
  dw Poltergeist_Bed
  dw Poltergeist_Table
  dw Poltergeist_Ghost

  ; 0x00
  Poltergeist_Dictate:
  {
    ; Set the sprite subtype to the current action
    LDA.w SprSubtype,X
    STA.w SprAction
    RTS
  }

  ; 0x01
  Poltergeist_Chair:
  {
    JSR ISUUMV
    RTS
  }

  ; 0x02
  Poltergeist_Axe:
  {
    JSR NATAMV
    RTS
  }

  ; 0x03
  Poltergeist_Dish:
  {
    JSR SARAMV
    RTS
  }

  ; 0x04
  Poltergeist_Fork:
  {
    JSR FOOKMV
    RTS
  }

  ; 0x05
  Poltergeist_Knife:
  {
    JSR KNIFMV
    RTS
  }

  ; 0x06
  Poltergeist_Window:
  {
    
    RTS
  }

  ; 0x07
  Poltergeist_Frame:
  {

    RTS
  }

  ; 0x08
  Poltergeist_Bed:
  {

    RTS
  }

  ; 0x09
  Poltergeist_Table:
  {

    RTS
  }

  ; 0x0A
  Poltergeist_Ghost:
  {

    RTS
  }
}

;===============================================

Sprite_Poltergeist_Draw:
{
  LDA.w SprAction, X ; Load the current action of the sprite
  JSL UseImplicitRegIndexedLocalJumpTable

  dw Poltergeist_EmptyDraw
  dw Poltergeist_ChairDraw
  dw Poltergeist_AxeDraw
  dw Poltergeist_DishDraw
  dw Poltergeist_ForkDraw
  dw Poltergeist_KnifeDraw
  dw Poltergeist_WindowDraw
  dw Poltergeist_FrameDraw
  dw Poltergeist_BedDraw
  dw Poltergeist_TableDraw
  dw Poltergeist_GhostDraw

  ; 0x00
  Poltergeist_EmptyDraw:
  {
    ; Nothing draws 
    RTS
  }

  ; 0x01
  Poltergeist_ChairDraw:
  {
    JSR ISUUCS
    RTS
  }

  ; 0x02
  Poltergeist_AxeDraw:
  {
    JSR E21CST
    RTS
  }

  ; 0x03
  Poltergeist_DishDraw:
  { 
    JSR SARACS
    RTS
  }

  ; 0x04
  Poltergeist_ForkDraw:
  {
    JSR FOOKMV
    RTS
  }

  ; 0x05
  Poltergeist_KnifeDraw:
  {
    JSR KNIFMV
    RTS
  }

  ; 0x06
  Poltergeist_WindowDraw:
  {
    
    RTS
  }

  ; 0x07
  Poltergeist_FrameDraw:
  {

    RTS
  }

  ; 0x08
  Poltergeist_BedDraw:
  {

    RTS
  }

  ; 0x09
  Poltergeist_TableDraw:
  {

    RTS
  }

  ; 0x0A
  Poltergeist_GhostDraw:
  {

    RTS
  }
}

;===============================================


;ISUU        EQU    $01 - chair
;NATA        EQU    $02 - axe
;SARA        EQU    $03 - dish
;FOOK        EQU    $04 - fork
;KNIF        EQU    $05 - knife

;MADO        EQU    $06 - window
;GAKU        EQU    $07 - frame
;BADD        EQU    $08 - bed
;TABL        EQU    $09 - table
;GOST        EQU    $0A - ghost

; XAD = X address
; YAD = Y address
; CDT = character (?) data
; ADT = address data
; SBD = subroutine data
; CS = character set

; Animation Frames
; 00-01,08 Chair Spinning 
; 02-04,08 Chair Breaking
; 05-12,02 Axe_Spinning 
; 13-16,08 Dish_Spinning

; TODO: Figure out what special animation means in this context.
; E2CHPT - Enemy2 Character Pointer (Likely)
; $7FF9FE[0x1E] - (Garnish)
;     special animation unknown B

; E2MODE
; $7FF800[0x1E] - (Garnish)
; 0x00 - Garnish is considered inactive if it has this value.

; Garnish move relative to the background using scroll registers $E2 and $E8.

; =========================================================

ISUUMV:
{
;       	LDA	KEYA2 : AND	#00001100B : BEQ	WQWQA
;		LDA	$1A : AND	#$03 : BNE	WQWQA
;;
		LDA	$7FF9FE,X : INC	A : CMP	#$0A : BNE	WEWEA
		LDA	#$00
WEWEA:
		STA	$7FF9FE,X
WQWQA:
		JMP ISUUCS
}
;
ISCXAD:
		db $00,$00,$00,$00,$00,$00
		db $00,$00,$04,$04,$04,$04
		db $00,$00,$00,$00,$00,$00
		db $00,$00,$04,$04,$04,$04
;
		db $00,$00,$00,$00,$00,$00
		db $00,$00,$FD,$09,$09,$09
		db $00,$00,$FB,$FB,$0A,$0D
		db $00,$00,$FA,$F9,$0E,$0F
		db $00,$00,$F5,$13,$12,$12
		db $00,$00,$00,$00,$00,$00
ISCYAD:
		db $01,$00,$00,$00,$00,$00
		db $04,$FC,$0C,$0C,$0C,$0C
		db $01,$00,$00,$00,$00,$00
		db $04,$FC,$0C,$0C,$0C,$0C
;
		db $01,$FD,$FD,$FD,$FD,$FD
		db $01,$FD,$07,$FC,$FC,$FC
		db $01,$FD,$FA,$08,$FA,$0A
		db $FE,$FE,$FA,$0A,$FA,$0C
		db $FF,$FF,$FA,$FB,$0F,$0F
		db $00,$00,$00,$00,$00,$00
ISCCDT:
		db $24,$08,$08,$08,$08,$08
		db $26,$84,$2F,$2F,$2F,$2F
		db $24,$82,$82,$82,$82,$82
		db $26,$84,$2F,$2F,$2F,$2F
;
		db $24,$08,$08,$08,$08,$08
		db $24,$00,$98,$88,$88,$88
		db $24,$00,$88,$89,$89,$98
		db $00,$00,$89,$99,$99,$89
		db $00,$00,$99,$3F,$99,$99
		db $00,$00,$00,$00,$00,$00
ISCADT:
		db $00,$00,$00,$00,$00,$00
		db $00,$00,$00,$00,$00,$00
		db $00,$00,$00,$00,$00,$00
		db $04,$04,$04,$04,$04,$04
;
		db $00,$00,$00,$00,$00,$00
		db $00,$00,$00,$00,$00,$00
		db $00,$00,$00,$00,$04,$00
		db $00,$00,$04,$00,$04,$04
		db $00,$00,$00,$00,$04,$04
		db $00,$00,$00,$00,$00,$00
ISCSBD:
		db 2,2,2,2,2,2
		db 2,2,0,0,0,0
		db 2,2,2,2,2,2
		db 2,2,0,0,0,0
;
		db 2,2,0,0,0,0
		db 2,2,0,0,0,0
		db 2,2,0,0,0,0
		db 2,2,0,0,0,0
		db 2,2,0,0,0,0
		db 2,2,2,2,2,2
;
ISUUCS:
{
		JSR OAMCHK
    ;
		LDA $7FF9FE, X : STA	$00
		ASL A
		ASL A
		ADC $00 : ADC	$00 : STA	$02
    ;
		LDA $7FF83C, X : SEC : SBC	$E2 : STA $00
		LDA $7FF81E, X : SEC : SBC	$E8 : STA $01
    ;
		PHX
		LDX #$05
.loop
		TXA

		PHA
		CLC : ADC	$02
		TAX
		LDA	$00 : CLC : ADC	ISCXAD,X :       STA ($90),Y
		LDA	$01 : CLC : ADC	ISCYAD,X : INY : STA ($90),Y

		LDA	ISCCDT,X : INY : STA	($90),Y
		LDA	ISCADT,X : ORA	#$33 : INY : STA	($90),Y

		PHY : TYA
		LSR A
		LSR A
		TAY : LDA	ISCSBD,X : STA ($92),Y
		PLY : INY 
    PLX : DEX : BPL	.loop
    ;
		PLX
		LDY #$FF : LDA	#$05
		JSR E2ALCK
		RTS
}

;====================================

NATAMV:
;;    LDA	KEYA2 : AND	#00001100B : BEQ	WEWE2
;		LDA	$1A : AND	#$03 : BNE	WEWE2
;;
;		LDA	$7FF9FE,X : INC	A : CMP	#$08 : BNE	WEWE1
;		LDA	#$00
;WEWE1:
;		STA	$7FF9FE,X
WEWE2:
		JSR E21CST
;;;;;;;;		JSR	E2SWST
		RTS

SARAMV:
		JSR SARACS
;
;;		LDA	KEYA2 : AND	#00001100B ; BEQ	WQWQ
;		LDA	$1A : AND	#$03 : BNE	WQWQ
;;
;		LDA	$7FF9FE,X : INC	A : CMP	#$06 : BNE	WEWE
;		LDA	#$00
WEWE:
;		STA	$7FF9FE,X
WQWQ:
;----------------------------------
SARACS:
		LDA $7FF9FE, X : BEQ	SRC0F0
;
		JSR SARAC0
		RTS
SRC0F0:
		JSR E21CST
;;;		JSR	E2SWST
		RTS
;- - - - - - - - - - - - - - -
SRCXAD:
		db $00,$FE,$FC,$08,$07,$05
		db $FE,$FF,$FA,$0A,$08,$03
		db $FD,$FA,$F8,$0D,$09,$07
		db $FD,$FB,$F6,$0F,$08,$08
		db $F6,$F6,$F6,$0F,$0F,$0F
SRCYAD:
		db $00,$FB,$06,$FC,$06,$09
		db $FF,$F8,$06,$FD,$08,$0C
		db $FC,$FB,$03,$FA,$06,$0D
		db $00,$F9,$08,$FB,$0A,$0A
		db $0C,$0C,$0C,$FC,$FC,$FC
SRCCDT:
		db $D5,$C2,$D2,$C3,$D3,$D5
		db $D5,$D4,$D2,$C3,$D4,$D5
		db $3F,$D5,$D4,$D4,$D5,$3F
		db $3F,$3F,$D5,$D5,$3F,$3F
		db $3F,$3F,$3F,$3F,$3F,$3F
SRCADT:
		db $00,$00,$00,$00,$00,$00
		db $00,$00,$00,$00,$0C,$00
		db $00,$00,$00,$04,$0C,$00
		db $08,$00,$08,$04,$00,$00
		db $00,$00,$00,$04,$04,$04
SARAC0:
{
		JSR OAMCHK
;
		LDA $7FF9FE, X
		DEC A
		STA $00
		ASL A
		ASL A
		ADC $00 : ADC	$00 : STA	$02
;
		LDA $7FF83C, X : SEC : SBC	$E2 : STA $00
		LDA $7FF81E, X : SEC : SBC	$E8 : STA	$01
;
		PHX
		LDX #$05
.loop
		TXA
		PHA : CLC : ADC	$02
		TAX
		LDA	$00 : CLC : ADC	SRCXAD,X :       STA	($90),Y
		LDA	$01 : CLC : ADC	SRCYAD,X : INY : STA	($90),Y
		LDA	SRCCDT, X : INY :            STA	($90),Y
		LDA	SRCADT, X : ORA	#$33 : INY : STA	($90),Y
		INY
		PLX
		DEX : BPL	.loop
		PLX
		LDY #$00 : LDA #$05
		JSR E2ALCK
		RTS
}
;===================================

FOOKMV:
KNIFMV:
{
;		LDA	>E2CONT,X
;		INC	A
;		STA	>E2CONT,X
;;;;		LSR	A
;		LSR	A
;		LSR	A
;		AND	#$07
;		STA	$7FF9FE,X
;		AND	#$01
		LDA $7FF9FE, X : AND.b	#$01 : BNE	KF0090
		JSR KNIFCS
		RTS

KF0090:
		JSR E21CST
		RTS
}
;- - - - - - - - - - - -
KFCXAD:
{
		db $04,$04
		db $00,$08
		db $04,$04
		db $00,$08
}

KFCYAD:
{
		db $00,$08
		db $04,$04
		db $00,$08
		db $04,$04
}

KFCCDT:
{
		db $C7,$D7
		db $D8,$D9
		db $D7,$C7
		db $D9,$D8
;
		db $C6,$D6
		db $C8,$C9
		db $D6,$C6
		db $C9,$C8
}
KFCADT:
{
		db %00110001,%00110001
		db %00110001,%00110001
		db %10110001,%10110001
		db %01110001,%01110001
}
;
KNIFCS:
{
		JSR OAMCHK
;
		LDA $7FF800, X : STA	$03
;
		LDA $7FF9FE, X : AND	#$FE : STA $02
		LDA $7FF83C, X : SEC : SBC	$E2 : STA $00
		LDA $7FF81E, X : SEC : SBC	$E8 : STA	$01
;		
		PHX
		LDX #$01
;;;		LDY	#$00
KFC010:
		PHX
		TXA
		CLC : ADC	$02
		TAX
		LDA	$00 : CLC : ADC	KFCXAD,X :       STA	($90),Y
		LDA	$01 : CLC : ADC	KFCYAD,X : INY : STA	($90),Y
		PHX

		LDA $03 : CMP	#FOOK : BEQ	KFC008
		TXA : CLC : ADC	#$08 : TAX
KFC008:
		LDA	KFCCDT,X : INY : STA	($90),Y
		PLX
		LDA	KFCADT,X : INY : STA	($90),Y
		INY
		PLX
		DEX : BPL	KFC010
		PLX
;
		LDY #$00 : LDA #$01
		JSR E2ALCK
		RTS
}
;====================================

MADOMV:
{
;;LDA	KEYA2
;;AND	#00001100B
;;BEQ	WQWQA1
		LDA $1A : AND	#$07 : BNE	WQWQA1
;
		LDA $7FF9FE, X : INC	A : CMP	#$06 : BNE	WEWEA1
		LDA #$00
WEWEA1:
		STA $7FF9FE, X
WQWQA1:
		JSR MADOCS
		RTS
}

;------------------------------------------
MDCCD0:
MDCCD1:
{
		db $8A,$8C,$8E,$8A,$8C,$8E
}

MDCAD0:
{
		db $B5,$B5,$B5,$F5,$F5,$F5
}

MDCAD1:
{
		db $35,$35,$35,$75,$75,$75
}

;- - - - - - - - - - - - - - -

MADOCS:
{
		JSR OAMCHK

		LDA	$7FF83C,X : SEC : SBC	$E2 : STA	($90),Y
		LDY #$04 : STA ($90), Y

		LDA $7FF81E,          X : SEC : SBC	$E8
		LDY #$01 : STA ($90), Y : CLC : ADC #$10
		LDY #$05 : STA ($90), Y
		LDA $7FF9FE,          X
		PHX
		TAX
		LDA	MDCCD0, X : LDY	#$02 : STA	($90),Y
;;;;;;		LDA	MDCCD1,X
		LDY #$06 : STA	($90), Y
		LDA	MDCAD0, X : LDY	#$03 : STA	($90), Y
		LDA	MDCAD1, X : LDY	#$07 : STA	($90), Y
		PLX

		LDY #$02
		LDA #$01
		JSR E2ALCK
		RTS
}

;====================================

GAKUMV:
{
;;              LDA	KEYA2
;;             AND	#00001100B
;;              BEQ	WQWQAA
;		LDA	$1A
;		AND	#$03
;		BNE	WQWQAA
;
;		LDA	$7FF9FE,X
;		INC	A
;		CMP	#0EH
;		BNE	WEWEAA
;		LDA	#$00
;WEWEAA:
;		STA	$7FF9FE,X
WQWQAA:
		JSR GAKUCS
		RTS
}

;-------- ----------- ------------- ------------- 
GAKXAD:
		db $00,$10,$10,$10,$10,$10
		db $04,$0C,$00,$10,$10,$10
		db $05,$0C,$14,$00,$10,$10
		db $05,$0C,$14,$00,$10,$10
		db $04,$0C,$00,$10,$10,$10
		db $04,$0C,$00,$10,$10,$10
;
		db $04,$0C,$00,$10,$10,$10
		db $04,$0C,$00,$10,$10,$10
		db $04,$0C,$00,$10,$10,$10
		db $04,$0C,$04,$14,$07,$0F
		db $04,$0C,$FC,$0C,$04,$12
		db $04,$0C,$04,$14,$02,$16
		db $04,$0C,$04,$14,$00,$00
		db $04,$0C,$04,$0C,$0C,$0C
GAKYAD:
		db $00,$00,$00,$00,$00,0
		db $0C,$0C,$00,$00,$00,0
		db $0E,$0E,$0E,$00,$00,0
		db $0E,$0E,$0E,$00,$00,0
		db $0C,$0C,$00,$00,$00,0
		db $08,$08,$00,$00,$00,0
;
		db $08,$08,$02,$02,$02,2
		db $08,$08,$05,$05,$05,5
		db $08,$08,$07,$07,$07,7
		db $08,$08,$04,$04,$FE,$10
		db $08,$08,$03,$03,$FC,$14
		db $08,$08,$05,$05,$FA,$14
		db $08,$08,$06,$06,$F7,$F7
		db $08,$08,$07,$07,$07,$07
GAKCDT:
		db $AC,$AC,$AC,$AC,$AC,$AC
		db $24,$24,$AC,$AC,$AC,$AC
		db $34,$34,$35,$AE,$AE,$AE
		db $34,$34,$35,$AE,$AE,$AE
		db $24,$24,$0C,$0C,$0C,$0C
		db $24,$24,$AA,$AA,$AA,$AA
;
		db $24,$24,$AA,$AA,$AA,$AA
		db $24,$24,$AA,$AA,$AA,$AA
		db $24,$24,$AA,$AA,$AA,$AA
		db $24,$24,$28,$2A,$89,$99
		db $24,$24,$2A,$28,$89,$99
		db $24,$24,$28,$2A,$99,$3F
		db $24,$24,$28,$2A,$3F,$3F
		db $24,$24,$28,$28,$28,$28
GAKADT:
		db $00,$04,$04,$04,$04,$04
		db $00,$04,$00,$04,$04,$04
		db $00,$00,$00,$00,$04,$04
		db $00,$00,$00,$08,$0C,$0C
		db $00,$04,$00,$04,$04,$04
		db $00,$04,$00,$04,$04,$04
;
		db $00,$04,$00,$04,$04,$04
		db $00,$04,$00,$04,$04,$04
		db $00,$04,$00,$04,$04,$04
		db $00,$04,$00,$00,$00,$00
		db $00,$04,$04,$04,$04,$00
		db $00,$04,$00,$00,$00,$00
		db $00,$04,$00,$00,$00,$00
		db $00,$04,$04,$04,$04,$04
GAKSBD:
		db 2,2,2,2,2,2
		db 2,2,2,2,2,2
		db 0,0,0,2,2,2
		db 0,0,0,2,2,2
		db 2,2,2,2,2,2
		db 2,2,2,2,2,2
;
		db 2,2,2,2,2,2
		db 2,2,2,2,2,2
		db 2,2,2,2,2,2
		db 2,2,2,2,0,0
		db 2,2,2,2,0,0
		db 2,2,2,2,0,0
		db 2,2,2,2,0,0
		db 2,2,2,2,2,2

GAKUCS:
{
		JSR OAMCHK
;
		LDA $7FF9FE, X
		ASL A
		ASL A
		ADC	$7FF9FE,X : ADC	$7FF9FE,X : STA	$02
;
		LDA $7FF83C, X : SEC : SBC	$E2 : STA	$00
		LDA $7FF81E, X : SEC	: SBC	$E8	: STA	$01
		PHX
		LDX #$06-1
GKC010:
		PHX
		TXA
    CLC : ADC	$02
		TAX
		LDA	$00 : CLC : ADC	GAKXAD,X :       STA	($90), Y
		LDA	$01 : CLC : ADC	GAKYAD,X : INY : STA	($90), Y

		LDA	GAKCDT, X : INY : STA ($90), Y
		LDA	GAKADT, X : INY : ORA #$33 : STA	($90), Y

		PHY
		TYA
		LSR A
		LSR A
		TAY
		LDA	GAKSBD, X : STA	($92),Y
		PLY
		INY
		PLX
		DEX : BPL	GKC010
;
		PLX
		LDY #$FF
		LDA #06-1
		JSR E2ALCK
		RTS
}
;====================================
BEDDMV:
;		LDA	$1A
;		AND	#$03
;		BNE	BDM010
;
;		LDA	<KEYA2
;		AND	#00001000B
;		BEQ	BDM010
;
;		LDA	$7FF9FE,X
;		INC	A
;		STA	$7FF9FE,X
;
;		LDA	$7FF9FE,X
;		CMP	#$07
;		BNE	BDM010
;
;		LDA	#$00
;		STA	$7FF9FE,X
BDM010:
		JSR BEDDCS
		RTS
;---------------------------------
BDCXAD:
		db $00,$10,$00,$10,$00,$10
		db $00,$00,$00,$00
;
		db $00,$10,$00,$10,$00,$10
		db $F9,$08,$08,$1D
;
		db $00,$10,$00,$10,$00,$10
		db $F6,$05,$05,$21
;
		db $00,$10,$00,$10,$00,$10
		db $F4,$03,$05,$23
;
		db $00,$10,$00,$10,$00,$10
		db $F1,$00,$01,$25
;
		db $00,$10,$00,$10,$00,$10
		db $ED,$FD,$00,$28
;
		db $00,$10,$00,$10,$00,$10
		db $00,$00,$00,$00
BDCYAD:
		db $00,$00,$10,$10,$20,$20
		db $00,$00,$00,$00
		db $00,$00,$10,$10,$20,$20
		db $17,$FF,$1B,$11
		db $02,$02,$10,$10,$1E,$1E
		db $17,$FF,$1B,$11
		db $00,$00,$10,$10,$20,$20
		db $0F,$F8,$13,$0D
		db $00,$00,$10,$10,$20,$20
		db $10,$F7,$12,$0C
		db $00,$00,$10,$10,$20,$20
		db $11,$F5,$10,$0C
		db $00,$00,$10,$10,$20,$20
		db $00,$00,$00,$00,$00,$00
BDCCDT:
		db $A0,$A0,$A2,$A2,$A4,$A4
		db $A0,$A0,$A0,$A0
		db $02,$02,$04,$04,$06,$06
		db $98,$88,$88,$98
		db $02,$02,$04,$04,$06,$06
		db $98,$88,$88,$98
		db $02,$02,$04,$04,$06,$06
		db $89,$89,$89,$89
		db $02,$02,$04,$04,$06,$06
		db $99,$99,$99,$99
		db $02,$02,$04,$04,$06,$06
		db $3F,$3F,$3F,$3F
		db $02,$02,$04,$04,$06,$06
		db $02,$02,$02,$02
BDCADT:									
		db $00,$04,$00,$04,$00,$04
		db $00,$00,$00,$00
		db $00,$04,$00,$04,$00,$04
		db $00,$00,$08,$04
		db $00,$04,$00,$04,$00,$04
		db $08,$08,$00,$00
		db $00,$04,$00,$04,$00,$04
		db $08,$00,$08,$00
		db $00,$04,$00,$04,$00,$04
		db $04,$00,$08,$00
		db $00,$04,$00,$04,$00,$04
		db $04,$00,$04,$00
		db $00,$04,$00,$04,$00,$04
		db $00,$00,$00,$00
BDCSBD:
		db 2,2,2,2,2,2
		db 2,2,2,2
		db 2,2,2,2,2,2
		db 0,0,0,0
		db 2,2,2,2,2,2
		db 0,0,0,0
		db 2,2,2,2,2,2
		db 0,0,0,0
		db 2,2,2,2,2,2
		db 0,0,0,0
		db 2,2,2,2,2,2
		db 0,0,0,0
		db 2,2,2,2,2,2
		db 2,2,2,2
;====================================
BEDDCS:
		JSR OAMCHK
;
		LDA $7FF9FE, X
		ASL A
		ASL A
		ASL A
		ADC $7FF9FE, X
		ADC $7FF9FE, X
		STA $02
;
		LDA $7FF83C, X : SEC : SBC	$E2 : STA	$00
		LDA $7FF81E, X : SEC : SBC	$E8 : STA	$01
		PHX
		LDX #$09

BDC010:
		PHX
		TXA
		CLC : ADC	$02
		TAX
		
    LDA $00
		CLC : ADC	BDCXAD, X : STA	($90),Y
		LDA	$01 : CLC : ADC	BDCYAD,X : INY  : STA	($90),Y

		LDA	BDCCDT, X : INY : STA ($90),Y
		LDA	BDCADT, X : INY : ORA #$33 : STA	($90),Y
		PHY
		TYA
		LSR A
		LSR A
		TAY
		LDA	BDCSBD, X : STA	($92), Y
		PLY
		INY
		PLX
		DEX
		BPL BDC010
;
		PLX
		LDY #$FF
		LDA #010-1
		JSR E2ALCK
		RTS
;====================================
TABLMV:
;;		LDA	$1A
;;		AND	#$03
;;		BNE	TBM010
;;;
;;		LDA	$7FF9FE,X
;;		INC	A
;;		STA	$7FF9FE,X
;;;
;;		LDA	$7FF9FE,X
;;		CMP	#$07
;;		BNE	TBM010
;;		LDA	#$00
;;		STA	$7FF9FE,X
TBM010:
		JSR TABLCS
		RTS
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
;%						     %
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
TABCXD:
		db $00,$10,$20,$30
		db $00,$10,$20,$30
		db $00,$00
;
		db $06,$1A,$28,$31
		db $08,$18,$28
		db $08,$18,$28
;
		db $02,$19,$2F,$34
		db $08,$18,$28
		db $08,$18,$28
;
		db $00,$17,$31,$35
		db $08,$18,$28
		db $08,$18,$28
;
		db $FE,$15,$36,$37
		db $08,$18,$28
		db $08,$18,$28
;
		db $FC,$12,$3C,$3A
		db $08,$18,$28
		db $08,$18,$28
;
		db $08,$18,$28
		db $08,$18,$28
		db $08,$08,$08,$08
;
TABCYD:
		db $00,$00,$00,$00
		db $10,$10,$10,$10
		db $00,$00
;
		db $19,$FB,$01,$0E
		db $00,$00,$00
		db $10,$10,$10
;
		db $1B,$F7,$0B,$FE
		db $00,$00,$00
		db $10,$10,$10
;
		db $1C,$F5,$08,$FD
		db $00,$00,$00
		db $10,$10,$10
;
		db $1F,$F1,$06,$FB
		db $00,$00,$00
		db $10,$10,$10
;
		db $21,$F0,$07,$FB
		db $00,$00,$00
		db $10,$10,$10
;
		db $00,$00,$00
		db $10,$10,$10
		db $00,$00,$00,$00
TABCCD:
		db $2D,$A8,$A8,$2D
		db $2B,$A6,$A6,$2B
		db $2D,$2D
;
		db $98,$88,$88,$98
		db $08,$0A,$0C
		db $0E,$20,$22
;
		db $98,$89,$89,$98
		db $08,$0A,$0C
		db $0E,$20,$22
;
		db $99,$89,$89,$99
		db $08,$0A,$0C
		db $0E,$20,$22
;
		db $99,$99,$99,$99
		db $08,$0A,$0C
		db $0E,$20,$22
;
		db $3F,$3F,$3F,$3F
		db $08,$0A,$0C
		db $0E,$20,$22
;
		db $08,$0A,$0C
		db $0E,$20,$22
		db $08,$08,$08,$08
;
TABCAD:
		db $04,$00,$00,$00
		db $00,$00,$00,$04
		db $04,$04
;
		db $00,$04,$00,$0C
		db $00,$00,$00
		db $00,$00,$00
;
		db $08,$00,$08,$04
		db $00,$00,$00
		db $00,$00,$00
;
		db $00,$08,$00,$00
		db $00,$00,$00
		db $00,$00,$00
;
		db $04,$08,$04,$08
		db $00,$00,$00
		db $00,$00,$00
;
		db $00,$04,$00,$04
		db $00,$00,$00
		db $00,$00,$00
;
		db $00,$00,$00
		db $00,$00,$00
		db $00,$00,$00,$00
;
TABCSD:
		db 2,2,2,2
		db 2,2,2,2
		db 2,2
;
		db 0,0,0,0
		db 2,2,2
		db 2,2,2
;
		db 0,0,0,0
		db 2,2,2
		db 2,2,2
;
		db 0,0,0,0
		db 2,2,2
		db 2,2,2
;
		db 0,0,0,0
		db 2,2,2
		db 2,2,2
;
		db 0,0,0,0
		db 2,2,2
		db 2,2,2
;
		db 2,2,2
		db 2,2,2
		db 2,2,2,2
TABLCS:
		JSR OAMCHK
;
		LDA $7FF9FE, X
		ASL A
		ASL A
		ASL A
		ADC	$7FF9FE,X : ADC	$7FF9FE,X : STA	$02
;
		LDA $7FF83C, X : SEC : SBC	$E2 : STA	$00
		LDA $7FF81E, X : SEC : SBC	$E8 : STA	$01
		PHX
		LDX #$09
TBC010:
		PHX
		TXA
		CLC
		ADC $02
		TAX
		LDA	$00 : CLC : ADC	TABCXD,X :       STA	($90),Y
		LDA	$01 : CLC : ADC	TABCYD,X : INY : STA	($90),Y
		LDA	TABCCD,X : INY : STA	($90),Y
		LDA	TABCAD,X : INY : ORA	#$33 : STA	($90),Y
		PHY
		TYA
		LSR A
		LSR A
		TAY
		LDA	TABCSD,X : STA	($92),Y
		PLY
		INY
		PLX
		DEX : BPL	TBC010
		PLX
		LDY #$FF
		LDA #010-1
		JSR E2ALCK
		RTS
;====================================
GOSTMV:
		RTS

;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
;%							     %
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

; E2DSPL EQU	E2CHPT+E2NO

; Poltergeist Garnish Character Data
E2CD00:
{
.ISUUCD
		db $80,$82,$84,$82,$86
.NATACD
		db $E4,$EA,$E6,$E8,$E4,$EA,$E6,$E8
		db $E0,$E0,$E2,$E2
.SARACD
		db $C2
.FOOKCD
		db $00,$EE,$00,$EE,$00,$EE,$00,$EE
.KNIFCD
		db $00,$CE,$00,$CE,$00,$CE,$00,$CE
}
;- - - - - - - - - - - - - - - - - - 
; Character Offset Data
E2AD00:
{
		db $00,$00,$00,$40,$00
;
		db $00,$00,$00,$C0,$C0,$C0,$C0,$00
		db $00,$40,$00,$80
;
		db $00
;
		db 0,$00,$00,$80,0,$C0,0,$40
;
		db 0,$00,$00,$80,0,$C0,0,$40
}
;- - - - - - - - - - - - - - - - - - - - - - - - -
E2CDAD:
{
		db E2CD00_ISUUCD
		db E2CD00_NATACD
		db E2CD00_SARACD
		db E2CD00_FOOKCD
		db E2CD00_KNIFCD
}
;- - - - - - - - - - - - - - - - - - - - - -
E21CST:
{
		JSR OAMCHK

    ;;; LDY	#$00
    ; Garnish X-Coord and Y-Coord Low to OAM
		LDA	$7FF83C, X : SEC : SBC	$E2 :       STA	($90),Y
		LDA	$7FF81E, X : SEC : SBC	$E8 : INY : STA	($90),Y

    ; Load the current garnish mode
		LDA $7FF800, X : TAY

    ; Decide which poltergeist garnish graphics to use based on the mode.
		LDA	E2CDAD-1, Y : CLC : ADC	$7FF9FE, X : TAY

		PHY
		LDA	E2CD00,Y : LDY	#$02 : STA	($90),Y
		PLY
		
    LDA	E2AD00,Y : LDY #$03 : ORA #$31 : STA	($90),Y
    
    ; E2DSPL		EQU	E2CHPT+E2NO
		LDA #$02 : ORA $0F00, X : STA	($92)

    RTS	
}
;==============================================
E2SWST:
{
		JSR OAMCHK

		LDY #$04
    
    ; Garnish X-Coord Low
		LDA	$7FF83C,X : SEC : SBC	$E2 : STA	($90),Y

    ; Garnish Y-Coord Low
		LDA $7FF81E, X : SEC : SBC	$E8
		                CLC : ADC	#$0A
		                INY : STA	($90), Y

    ; #0CAH not sure if this was a byte probably though
		LDA #$CA : INY : STA	($90), Y
		LDA #$33 : INY : STA	($90), Y
;
		; LDY	#$01 : LDA #$02 : ORA >E2DSPL,X : STA	($92),Y
    RTS	
}

;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

E2XCLC:
		TXA : CLC : ADC	#$1E ; size of garnish table 
		TAX
		JSR E2YCLC
		LDX $0FA0
    RTS
;============================================
E2YCLC:
		LDA $7FF896, X
		ASL A
		ASL A
		ASL A
		ASL A
		CLC
		ADC $7FF8D2, X
		STA $7FF8D2, X
;
		LDA $7FF896, X
		PHP
		LSR A
		LSR A
		LSR A
		LSR A
		LDY #$00
		PLP
		BPL E2CY60
;
		ORA #%11110000
		DEY
E2CY60:
		ADC $7FF81E, X
		STA $7FF81E, X
;
		TYA
		ADC $7FF85A, X
		STA $7FF85A, X
		RTS
;============================================
E2ZCLC:
		LDA $7FF9A4, X
		ASL A
		ASL A
		ASL A
		ASL A
		CLC : ADC $7FF9C2, X : STA $7FF9C2, X
;
		LDA $7FF9A4, X
		PHP
		LSR A
		LSR A
		LSR A
		LSR A
		PLP
		BPL E2CZ60
;
		ORA #%11110000
E2CZ60:
		ADC $7FF9E0, X
		STA $7FF9E0, X
;
		RTS

E2ALCK:
		JSR	ALCKSB
		LDY	#$00
GSCL00:
		PHY
		TYA
		LSR	A
		LSR	A
		TAY		
		LDA	$0B
		BPL	GSCL08
		LDA	($92),Y
		AND	#%00000010
GSCL08:
		STA	($92),Y
		PLY
GSCL09:
;-- X Check ---
		LDX	#$00
		LDA	($90),Y
		SEC
		SBC	$07
		BPL	GSCL10
		DEX
GSCL10:
		CLC
		ADC	$02
		STA	$04
		TXA
		ADC	$03
		STA	$05
		JSR	ONOMCK
		BCC	GSCL11
		PHY
		TYA
		LSR	A
		LSR	A
		TAY
		LDA	($92),Y
		ORA	#%00000001
		STA	($92),Y
		PLY
GSCL11:
;-- Y check --
		LDX	#$00
		INY
		LDA	($90),Y
		SEC
		SBC	$06
		BPL	GSCL12
		DEX
GSCL12:
		CLC
		ADC	$00
		STA	$09
		TXA
		ADC	$01
		STA	$0A
		JSR	ONOMCV
		BCC	GSCL20
GSCL18:
		LDA	#$F0
		STA	($90),Y
GSCL20:
;;;		INY
		INY
		INY
		INY
		DEC	$08
		BPL	GSCL00
		LDX	$0FA0
		RTS

OAMCHK:
		LDA	#$00
		STA	$0F00,X ; >E2DSPL
;
		LDA	$7FF81E,X
		SEC
		SBC	$7FF9E0,X
		SEC
		SBC	$E8
		LDA	$7FF81E,X
		CLC
		ADC	#$10
		PHP
		SEC
		SBC	$E8
		LDA	$7FF85A,X
		SBC	$E9
		PLP
		ADC	#$00
		BEQ 	OMCK10
OMCK0F:
		PLA
		PLA
		BRA	OMCK18
OMCK10:
		LDA	$7FF878,X
		XBA
		LDA	$7FF83C,X
		
		REP	#%00100000
		SEC
		SBC	$E2
		CLC
		ADC	#$0040
		CMP	#$0180
		
		SEP	#%00100000
		BCS	OMCK0F
;
		LDA	$7FF83C,X
		SEC
		SBC	$E2
		LDA	$7FF878,X
		SBC	$E3
		BEQ	OMCK20
OMCK18:
		; LDA	#$01
		; STA	>E2DSPL,X
OMCK20:
		LDY	#$00
		RTS

; =============================================

ALCKSB:
		STY	$0B
		STA	$08
		LDA	$7FF81E,X
		STA	$00
		SEC
		SBC	$E8
		STA	$06
		LDA	$7FF85A,X
		STA	$01
		LDA	$7FF83C,X
		STA	$02
		SEC
		SBC	$E2
		STA	$07
		LDA	$7FF878,X
		STA	$03
		RTS

ONOMCK:

		REP	#%00100000
		LDA	$04
		SEC
		SBC	$E2
		CMP	#$0100

		SEP	#%00100000
		RTS

ONOMCV:

		REP	#%00100000
		LDA	$09
		PHA
		CLC
		ADC	#$10
		STA	$09
		SEC
		SBC	$E8
		CMP	#$0100
		PLA
		STA	$09

		SEP	#%00100000
		RTS