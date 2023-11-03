
org            $2B8000
incbin         tmnt.bin

!TurtleId      = #$2B

org            $2C8000
incbin         stalfos.bin

!StalfosId     = #$2C

org            $2D8000
incbin         fierce_deity.bin

!FierceDeityId = #$2D

pullpc
print "AllMasks ", pc 
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

NewBookCode:
{
  JSL $07983A ; Reset swim state
  LDA $46 : BNE .cantuseit
  LDA #$02 : STA $5D ; state recoil
  LDA #$01 : STA $4D ; state recoil 2

  ; Length of the jump
  LDA #$20 

  STA $46 

  ; Height of the jump
  LDA #$24 

  ; Set vertical resistance 
  STA $29
  STA $02C7
  ; Set Links direction to right(?)
  LDA #$08 : STA $0340 : STA $67

  ; Reset Link movement offsets 
  STZ $31
  STZ $30

  LDA $F4 : AND #$08 : BEQ .noUp
      LDA #-8 ; Change that -8 if you want higher speed moving up
      STA $27 ; Vertical recoil
  .noUp
  LDA $F4 : AND #$04 : BEQ .noDown
      LDA #8  ; Change that -8 if you want higher speed moving down
      STA $27
  .noDown
  LDA $F4 : AND #$02 : BEQ .noLeft
      LDA #-8 ; Change that -8 if you want higher speed moving left
      STA $28 ; Horizontal recoil
  .noLeft
  LDA $F4 : AND #$01 : BEQ .noRight
      LDA #8  ; Change that 8 if you want higher speed moving right
      STA $28
  .noRight
  .cantuseit
  RTL
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
  
  LDA $02B2 : CMP #$01 : BEQ .unequip ; is the hood already on?
  JSL UpdateTmntPalette
  LDA !TurtleId : STA $BC             ; change link's sprite 
  LDA #$01 : STA $02B2
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
  
  LDA $02B2 : CMP #$02 : BEQ .unequip ; is the hood already on?
  JSL UpdateStalfosPalette
  LDA !StalfosId : STA $BC            ; change link's sprite 
  LDA #$02 : STA $02B2
  BRA .return
  .unequip 
  %ResetToLinkGraphics()

.return

  LDA $02B2 : CMP #$02 : BNE .done
  BIT $3A : BVS .done ;if Y or B are already pressed
  LDA $6C : BNE .done ; if we are standing in a dooray or not

  ; Link_CheckNewY_ButtonPress
  JSR $B073 : BCC .done ; Check if we just pressed Y Button  
  JSL NewBookCode
.done

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
  
  LDA $02B2 : CMP #$03 : BEQ .unequip ; is the hood already on?
  JSL UpdateFierceDeityLinkPalette
  LDA !FierceDeityId : STA $BC        ; change link's sprite 
  LDA #$03 : STA $02B2
  BRA .return
  
.unequip
  %ResetToLinkGraphics()

.return
  CLC
  RTS
}

warnpc $07A4F6
pullpc


