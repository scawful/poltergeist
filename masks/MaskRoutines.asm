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

; GameOver_DelayBeforeIris
org $09F347
  JSL ForceResetMask_GameOver

; Module17_SaveAndQuit
org $09F7B5
  JSL ForceResetMask_SaveAndQuit

org $02A560
  JSL ForceReset : NOP

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

ForceReset:
{

  LDA $7EF280 : BNE .openMap
  PLA : PLA : PLA ; Pop the RTL
  JML $02A571 ; check select button 

  .openMap
  LDA $02B2 : BEQ .still_link
  LDY.b #$04 : LDA.b #$23
  JSL   AddTransformationCloud
  %ResetToLinkGraphics()
.still_link
  STZ.w $0200
  LDA #$07
  RTL
}

ForceResetMask_GameOver:
{
  LDA $02B2 : BEQ .still_link
  %ResetToLinkGraphics()
.still_link
  LDA.b #$30
  STA.b $98
  RTL
}

ForceResetMask_SaveAndQuit:
{
  LDA $02B2 : BEQ .still_link
  %ResetToLinkGraphics()
.still_link
  LDA.b #$0F
  STA.b $95
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
  LDA.b #$2B : STA $BC 
  JSL UpdateTmntPalette
  RTL
.stalfos
  LDA.b #$2C : STA $BC 
  JSL UpdateStalfosPalette
  RTL
.fierce_deity
  LDA.b #$2D : STA $BC 
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
  JMP .skip
.has_mask_palette
  LDA $7EC4A0, X : STA $7EC6A0, X ; Don't overwrite global sprite palette
.skip
  INX #2 : CPX.b #$40 : BNE .loop

  SEP #$20

  ; tell NMI to upload new CGRAM data
  INC $15

  RTL
}
pushpc

; =============================================================================

; Turtle
org $0DF6C1
dw $20F5, $20F5, $20F5, $20F5 ; No bombos
dw $3C12, $3C13, $3c22, $3C23 ; Bombos

; Fierce Deity 
dw $20F5, $20F5, $20F5, $20F5 ; No ether
dw $2C10, $2C11, $2820, $2821 ; Ether

; Stalfos
.quake
dw $20F5, $20F5, $20F5, $20F5 ; No quake
dw $2C66, $2C67, $2C76, $2C77 ; Quake

; Alphabet manual writing function
'A' = $2550
'B' = $2551
'C' = $2552
'D' = $2553
'E' = $2554
'F' = $2555
'G' = $2556
'H' = $2557
'I' = $2558
'J' = $2559
'K' = $255A
'L' = $255B
'M' = $255C
'N' = $255D
'O' = $255E
'P' = $255F
'Q' = $2560
'R' = $2561
'S' = $2562
'T' = $2563
'U' = $2564
'V' = $2565
'W' = $2566
'X' = $2567
'Y' = $2568
'Z' = $2569
'.' = $256A
':' = $256B
'0' = $2570
'1' = $2571
'2' = $2572
'3' = $2573
'4' = $2574
'5' = $2575
'6' = $2576
'7' = $2577
'8' = $2578
'9' = $2579
'_' = $20F5

org $0DF2A9
dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5 ; 
;     T 
; dw $2563, $2564, $255C, $2551, $255E, $2562, $24F5, $24F5 ; bombos
dw "TURTLE__"

dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5 ; 
; dw $2554, $2563, $2557, $2554, $2561, $24F5, $24F5, $24F5 ; ether
dw "DEITY___"

dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5 ; 
; dw $2560, $2564, $2550, $255A, $2554, $24F5, $24F5, $24F5 ; quake
dw "STALFOS_"