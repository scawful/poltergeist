; =============================================================================
;  Oracle of Secrets - Mask Library
; =============================================================================

!CurrentMask  = $02B2
!LinkGraphics = $BC

; =============================================================================
pushpc

org $09912C
  AddTransformationCloud:

org $07B073
  Link_CheckNewY_ButtonPress:

org $078028
  Player_DoSfx2:

macro PlayerTransform()
  LDY.b #$04 : LDA.b #$23
  JSL   AddTransformationCloud
  LDA.b #$14 : JSR Player_DoSfx2
endmacro

macro ResetToLinkGraphics()
  STZ   !CurrentMask
  JSL   Palette_ArmorAndGloves_New
  LDA.b #$10 : STA !LinkGraphics
endmacro

macro CheckNewR_ButtonPress()
  LDA.b $F6 : BIT.b #$10
endmacro

; =============================================================================
; Change Link's sprite by setting $BC to the bank containing a spritesheet.
; =============================================================================

org $008827
  JSL StartupMasks

; Link Sprite hook before game starts
org $008A01
  LDA $BC

; =============================================================================
; Change Link's palette based on $02B2 (mask value)
; =============================================================================

org $1BEDF9
  JSL Palette_ArmorAndGloves_New ; 4bytes
  RTL                        ; 1byte
  NOP #$01

org $1BEE1B
  JSL Palette_ArmorAndGloves_New_part_two
  RTL

org $02C769
Overworld_CgramAuxToMain:
{
  JSL Overworld_CgramAuxToMain_Override
  RTS
}

; =============================================================================
; EXPANDED SPACE
; =============================================================================

pullpc
StartupMasks:
{
  ; from vanilla:
  ; bring the screen into force blank after NMI
  LDA.b #$80 : STA $13

  ; set links sprite bank
  LDA #$10 : STA $BC

  RTL
}

; =============================================================================

Palette_ArmorAndGloves_New:
{
  LDA   $02B2 
  CMP.b #$01 : BEQ .tmnt
  CMP.b #$02 : BEQ .stalfos
  CMP.b #$03 : BEQ .fierce_deity
  JMP   .original_sprite

.tmnt
  LDA.b #$35 : STA $BC 
  JSL UpdateTmntPalette
  RTL
.stalfos
  LDA.b #$36 : STA $BC 
  JSL UpdateStalfosPalette
  RTL
.fierce_deity
  LDA.b #$37 : STA $BC 
  JSL UpdateFierceDeityLinkPalette
  RTL

.original_sprite
 ; Load Original Sprite Location
  LDA.b #$10 : STA $BC

.original_palette
  REP #$21
  LDA $7EF35B ; Link's armor value
  JSL $1BEDFF ; Read Original Palette Code
  RTL
.part_two
  SEP #$30
    REP   #$30
    LDA.w #$0000  ; Ignore glove color modifier $7EF354
    JSL   $1BEE21 ; Read Original Palette Code
  RTL

  PHX : PHY : PHA
  ; Load armor palette
  PHB : PHK : PLB

  REP #$20

  ; Check what Link's armor value is.
  LDA $7EF35B : AND.w #$00FF : TAX

  LDA $1BEC06, X : AND.w #$00FF : ASL A : ADC.w #$F000 : STA $00
  REP #$10

  LDA.w #$01E2 ; Target SP-7 (sprite palette 6)
  LDX.w #$000E ; Palette has 15 colors

  TXY : TAX

  LDA.b $BC : AND #$00FF : STA $02

.loop

  LDA [$00] : STA $7EC300, X : STA $7EC500, X

  INC $00 : INC $00

  INX #2

  DEY : BPL .loop

  SEP #$30

  PLB
  INC $15
  PLA : PLY : PLX
  RTL
}

; =============================================================================
; Overworld Palette Persist
; =============================================================================

Overworld_CgramAuxToMain_Override:
{
  ; Copies the auxiliary CGRAM buffer to the main one
  ; Causes NMI to reupload the palette.

  REP #$20

  LDX.b #$00

.loop

  LDA $7EC300, X : STA $7EC500, X
  LDA $7EC340, X : STA $7EC540, X
  LDA $7EC380, X : STA $7EC580, X
  LDA $7EC3C0, X : STA $7EC5C0, X
  LDA $7EC400, X : STA $7EC600, X
  LDA $7EC440, X : STA $7EC640, X
  LDA $7EC480, X : STA $7EC680, X
  LDA $02B2 : BNE .has_mask_palette
  LDA $7EC4C0, X : STA $7EC6C0, X
.has_mask_palette

  INX #2 : CPX.b #$40 : BNE .loop

  SEP #$20

  ; tell NMI to upload new CGRAM data
  INC $15

  RTL
}
pushpc

; =============================================================================