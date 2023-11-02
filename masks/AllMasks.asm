
org            $368000
incbin         masks/tmnt.bin

!TurtleId      = #$36

org            $378000
incbin         masks/stalfos.bin

!StalfosId     = #$37

org            $388000
incbin         masks/fierce_deity.bin

!FierceDeityId = #$38

pullpc
UpdateTmntPalette:
{
  REP #$30   ; change 16bit mode
  LDX #$001E

  .loop
  LDA.l .palette, X : STA $7EC6E0, X
  DEX : DEX : BPL .loop

  SEP #$30 ; go back to 8 bit mode
  INC $15  ; update the palette
  RTL      ; or RTS depending on where you need it
.palette
  dw $7BDE, $7FFF, $0866, $1571, $1A5C, $14A5, $025F, $01BF
  dw $0CEB, $0A4A, $1A59, $112E, $2108, $0170, $19B4, $12EF
}

UpdateStalfosPalette:
{
  REP #$30   ; change 16bit mode
  LDX #$001E

  .loop
  LDA.l .palette, X : STA $7EC6E0, X
  DEX : DEX : BPL .loop

  SEP #$30 ; go back to 8 bit mode
  INC $15  ; update the palette
  RTL      ; or RTS depending on where you need it
.palette
  dw #$7BDE, $7FFF, $237E, $11B7, $369E, $14A5, $01FF, $1078
  dw $65CA, $3266, $4F2C, $0A4A, $12EF, $14A9, $319B, $7ED1
}

UpdateFierceDeityLinkPalette:
{
  REP #$30   ; change 16bit mode
  LDX #$001E

  .loop
  LDA.l .palette, X : STA $7EC6E0, X
  DEX : DEX : BPL .loop

  SEP #$30 ; go back to 8 bit mode
  INC $15  ; update the palette
  RTL      ; or RTS depending on where you need it
.palette
  dw #$7BDE, #$7FFF, #$6318, #$3A14, #$4EDA, #$14A5, #$4629, #$1078
  dw #$3125, #$49A7, #$39CE, #$56ED, #$6350, #$1571, #$4A52, #$0F5F
}
pushpc
  
; =============================================================================
; Press R to transform 

; Turtle
org $07A569
LinkItem_Bombos:
{
  %CheckNewR_ButtonPress() : BEQ .return
  LDA $6C : BNE .return   ; in a doorway
  LDA $0FFC : BNE .return ; can't open menu

  %PlayerTransform()
  
  LDA $02B2 : CMP #$05 : BEQ .unequip ; is the hood already on?
  JSL UpdateTmntPalette
  LDA !TurtleId : STA $BC             ; change link's sprite 
  LDA #$05 : STA $02B2
  BRA .return
  .unequip
  %ResetToLinkGraphics()

.return
  CLC
  RTS
}

 ; Stalfos Mask
org $07A64B
LinkItem_Quake:
{
  %CheckNewR_ButtonPress() : BEQ .return
  LDA $6C : BNE .return   ; in a doorway
  LDA $0FFC : BNE .return ; can't open menu

  %PlayerTransform()
  
  LDA $02B2 : CMP #$06 : BEQ .unequip ; is the hood already on?
  JSL UpdateStalfosPalette
  LDA !StalfosId : STA $BC            ; change link's sprite 
  LDA #$06 : STA $02B2
  BRA .return
  .unequip 
  

.return
  CLC 
  RTS
}

; Fierce Deity
org $07A494
LinkItem_Ether:
{
  %CheckNewR_ButtonPress() : BEQ .return
  LDA $6C : BNE .return   ; in a doorway
  LDA $0FFC : BNE .return ; can't open menu

  %PlayerTransform()
  
  LDA $02B2 : CMP #$04 : BEQ .unequip ; is the hood already on?
  JSL UpdateFierceDeityLinkPalette
  LDA !FierceDeityId : STA $BC        ; change link's sprite 
  LDA #$04 : STA $02B2
  BRA .return
  
.unequip
  %ResetToLinkGraphics()

.return
  CLC
  RTS
}

warnpc $07A4F6
pullpc


