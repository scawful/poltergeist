; Goldstar ASM disassembly/restoration
; Originally from the all in patch by Conn
; Restored by scawful with help from Zarby

; 22C700

; 22D2B4
Routine_22D2B4:
{
  LDA $7EF342
  CMP #$02
  BEQ + ; $22D2BD
  RTL
+
  REP #$30
  LDA #$2556
  STA $16D8
  LDA #$255E
  STA $16DA
  LDA #$255B
  STA $16DC
  LDA #$2553
  STA $16DE
  LDA #$2562
  STA $16E0
  LDA #$2563
  STA $16E2
  LDA #$2550
  STA $16E4
  LDA #$2561
  STA $16E6
  SEP #$30
  RTL
}

; 22D100
; db $FF $FF $FF $FF $FF $FF $FF $F8
; db $FC $E3 $FB $C4 $F7 $CB $EF $97
; db $B6 $FF $DD $E3 $FF $C5 $F7 $9A
; db $BF $C8 $7B $C5 $ED $B7 $FF $DF
; db $EF $DF $F7 $CF $FB $E7 $FD $F3
; db $FE $F9 $FD $FF $FE $FF $FF $FF
; db $FF $AF $FF $D7 $FF $EB $FF $F5
; db $FF $AB $FF $57 $FF $AF $FF $FF

; 22D170 doesnt seem to execute 
  ; REP #$30
  ; LDA $EA
  ; AND #$00FF
  ; CMP #$0018
  ; BNE $22D181
  ; SEP #$30
  ; LDA #$02
  ; RTL

; 22D181 Also doest seem to execute 
  ; LDA #$7B80
  ; STA $2116
  ; LDA #$D100
  ; STA $4302
  ; LDA #$1801
  ; STA $4300
  ; SEP #$30
  ; LDA $4212
  ; AND #$80
  ; BEQ $22D195
  ; LDA #$80
  ; STA $2115
  ; LDA #$22
  ; STA $4304
  ; LDA #$20
  ; STA $4305
  ; LDA #$01
  ; STA $420B
  ; REP #$30
  ; LDA #$7B90
  ; STA $2116
  ; LDA #$1801
  ; STA $4300
  ; LDA #$D120
  ; STA $4302
  ; SEP #$30
  ; LDA #$80
  ; STA $2115
  ; LDA #$22
  ; STA $4304
  ; LDA #$20
  ; STA $4305
  ; LDA #$01
  ; STA $420B
  ; LDA #$02
  ; RTL

; 22D2A0 doesnt execute 
; menu related
  ; LDA #$22
  ; STA $0116
  ; LDA $0202
  ; CMP #$0B
  ; BNE $22D2AF
  ; JMP $D8B0
  ; CMP #$03
  ; BEQ $22D2B4
  ; RTL
  
; 22D2B4
  ; LDA $7EF342
  ; CMP #$02
  ; BEQ $22D2BD
  ; RTL
; 22D2BD
  ; REP #$30
  ; LDA #$2556
  ; STA $16D8
  ; LDA #$255E
  ; STA $16DA
  ; LDA #$255B
  ; STA $16DC
  ; LDA #$2553
  ; STA $16DE
  ; LDA #$2562
  ; STA $16E0
  ; LDA #$2563
  ; STA $16E2
  ; LDA #$2550
  ; STA $16E4
  ; LDA #$2561
  ; STA $16E6
  ; SEP #$30
  ; RTL

; 22D310 
  ; STA $7EC7BA
  ; LDA $0202
  ; AND #$00FF
  ; CMP #$000B
  ; BNE $22D322
  ; JMP $DED0
  ; CMP #$0004
  ; BNE $22D32A
  ; JMP $D390
  ; CMP #$0002
  ; BEQ $22D335
  ; CMP #$0003
  ; BEQ $22D35F
  ; RTL

; 22D35F HUD RELATED NOT NECESSARY
  ; LDA $7EF342
  ; AND #$00FF
  ; CMP #$0002
  ; BEQ $22D36C
  ; RTL
; 22D36C
  ; LDA #$20F5
  ; STA $7EC778
  ; LDA #$2971
  ; STA $7EC77A
  ; LDA #$2D72
  ; STA $7EC7B8
  ; LDA #$2973
  ; STA $7EC7BA
  ; RTL

pushpc

org $348000
TransferGFXinRAM:
{
  PHX ; keep X
  PHP ; keep processor byte
  REP #$20 ; 16bit is a bit faster

  LDX #$80
  --
  LDA.l morningstargfx, X : STA.l $7EA180, X
  DEX : DEX
  BPL --

  PLP
  PLX
  RTL
}
; TransferGFXinRAM:
; {
;   PHX ; keep X
;   PHP ; keep processor byte
;   REP #$20 ; 16bit is a bit faster

;   LDX #$80
;   --
;   LDA.l morningstargfx, X : STA.l $7E9A00, X
;   DEX : DEX
;   BPL --

;   LDX #$80
;   --
;   LDA.l morningstargfx, X : STA.l $7E99C0, X
;   DEX : DEX
;   BPL --

;   PLP
;   PLX
;   RTL
; }
morningstargfx:
  incbin morningstar.bin

org $0085C4
dw $0040

pullpc

; 22D470
  LDA $7EF342
  CMP #$02
  BNE + ; $A2D47C
  LDA #$03
  BRA $A2D47E
+
  JSL $06ED25
  RTL


; 22D4A0
; Hooked into LinkItem_Hookshot @ _07AB5A
CheckForBallChain:
{
  LDA #$13 : STA $5D ; Using hookshot state
  ; LDA $7EF342 : CMP #$02 ; Check ball chain srm
  JMP LinkItem_BallChain_GfxTransfer ; $D520 
  

  RTL
}

pushpc

org $08BF2D
  JSL BallChain_DrawOrReturn
warnpc $08BF31

pullpc

; 22D4C0
; Hooked into AncillaDraw_Hookshot @ _08BF2D
BallChain_DrawOrReturn:
{
  ; LDA $7EF342 : CMP #$02 : BEQ $22D4CD
  LDA $02B2 : CMP #$01 : BEQ + 
  LDA #$00
  STA ($92),Y
  RTL
+ ; $22D4CD
  LDA #$02
  STA ($92),Y
  RTL
}

pushpc

org $08BF0C
  JML BallChain_ExtraCollisionLogic

pullpc

;; 22D4E0
; Hooked into Hookshot_ExtraCollisionLogic @ 08BF0C 
BallChain_ExtraCollisionLogic:
{
    TAX
    ; LDA $7EF342 : CMP #$02 : BNE $22D4F2
    LDA $02B2 : CMP #$01 : BNE + ; Check if turtle
    TXA
    CMP #$0A : BNE ++ ; $22D4F3
    LDA #$FF : BRA ++ ; $22D4F3
  +  ; $22D4F2
    TXA
  ++ ; $22D4F3
    CMP #$FF
    BEQ +++ ; $22D4FB
    JML $08BF10 ; AncillaDraw_Hookshot - JSR Ancilla_SetOAM_XY, skips hookshot char
  ;22D4FB
  +++
    JML $08BF32 ; AncillaDraw_Hookshot_skip
}


;; 22D520
LinkItem_BallChain_GfxTransfer:
{
    LDA #$FF : STA $7A ; Ball Chain Timer
    PHB
    ; Check link direction
    LDA $2F : CMP #$04 : BEQ .transfer_gfx_sideways
              CMP #$06 : BEQ .transfer_gfx_sideways
    REP #$30
    LDA #$0040 
    LDX #GFX_D600 ; $D600
    LDY #$9AC0
    MVN $39, $7E
    LDA #$0040
    LDX #GFX_D640 ; $D640
    LDY #$9B40
    MVN $39, $7E
    PLB

    LDA #GFX_D6A0 : STA $4302
    JMP .transfer_handle_and_links ; D574

  ; 22D553
  .transfer_gfx_sideways
    REP #$30
    LDA #$0040 
    LDX #GFX_D600 ; $D600
    LDY #$9B00
    MVN $39, $7E
    LDA #$0040 
    LDX #GFX_D640 ; $D640 
    LDY #$9B80
    MVN $39, $7E
    PLB
    LDA #GFX_D6C0 ; #$D6C0 
    STA $4302
    
  ; 22D574
  .transfer_handle_and_links
    LDA #$41E0 : STA $2116
    LDA #$1801 : STA $4300
    SEP #$30
    LDA #$80 : STA $2115
    .transfer_loop
      LDA $4212
      AND #$80
      BEQ .transfer_loop
    LDA #$39 : STA $4304
    LDA #$20 : STA $4305
    LDA #$01 : STA $420B

    REP #$30
    LDA #$40E0 : STA $2116
    LDA #GFX_D680 ; $D680
    STA $4302
    SEP #$30

    LDA #$20 : STA $4305
    LDA #$39 : STA $4304
    LDA #$01 : STA $420B
    RTL
}

; 22D5C0 ; Unreached
  LDA $8580,Y
  CMP #$02
  BEQ $22D5CA
  JMP $DA80


; These get used in the above routine in the MVN calls
; I think they are related to the 
{
  ; 22D600
  GFX_D600:
    db $00, $00, $00, $00, $21, $00, $7B, $00
    db $37, $0B, $3F, $14, $1D, $0A, $1F, $0B
    db $00, $00, $00, $00, $21, $00, $5B, $00
    db $2F, $0B, $3F, $14, $1E, $0A, $1F, $0B
  GFX_D620:
    db $00, $00, $80, $00, $40, $80, $F8, $00
    db $EC, $D0, $BC, $E8, $FC, $50, $D8, $60
    db $00, $00, $80, $00, $C0, $80, $F8, $00
    db $F4, $D0, $FC, $E8, $DC, $50, $F8, $60
  ; 22D640
  GFX_D640:
    db $1F, $04, $1F, $07, $2F, $19, $2F, $18
    db $7B, $01, $21, $00, $00, $00, $00, $00
    db $1F, $04, $1F, $07, $3F, $19, $3F, $18
    db $5B, $01, $21, $00, $00, $00, $00, $00
  ; 22D660
  GFX_D660:
    db $AC, $D0, $72, $DC, $FC, $C0, $F8, $10
    db $E8, $30, $34, $08, $08, $00, $00, $00
    db $FC, $D0, $FE, $DC, $FC, $C0, $F8, $10
    db $F8, $30, $3C, $08, $08, $00, $00, $00
; 22D680
  GFX_D680:
    db $00, $00, $18, $00, $24, $18, $5A, $24
    db $7E, $24, $3C, $18, $18, $00, $00, $00
    db $00, $00, $18, $00, $3C, $18, $7E, $24
    db $7E, $24, $3C, $18, $18, $00, $00, $00
  ; 22D6A0
  GFX_D6A0:
    db $18, $00, $3C, $18, $2C, $08, $34, $10
    db $34, $10, $34, $00, $24, $00, $18, $00
    db $18, $18, $24, $3C, $34, $3C, $2C, $18
    db $2C, $18, $2C, $08, $3C, $18, $18, $00
  ; 22D6C0
  GFX_D6C0:
    db $00, $00, $00, $00, $7E, $00, $BB, $1A
    db $87, $06, $7E, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $7E, $00, $C5, $5E
    db $F9, $7E, $7E, $00, $00, $00, $00, $00
}

pushpc 

org $07ABAF
  JSL BallChain_ResetTimer

pullpc

; 22D700
; Hooked into LinkState_Hookshotting @ _07ABAF
; Sets Link state to 0x00 and resets the hookshot timer
BallChain_ResetTimer:
{
  LDA $02B2 : CMP #$01 : BNE + 
  ; LDA #$00
  ; STA $5D
  ; STA $7A ; Ball Chain Timer
  STZ $7A
+
  STZ $5D
  RTL
}

pushpc 

org $08BFDA
  JSL BallChain_DrawChainOrHookshot
  NOP #8
  NOP #5

pullpc

; 22D800
; Hooked into AncillaDraw_HookshotChain @ 08BFDA
; Natively NOPs out the bytes 08BFDA - 08BFEA
BallChain_DrawChainOrHookshot:
{
  ; LDA $7EF342 : CMP #$02 BEQ $22D812
  LDA $02B2 : CMP #$01 : BEQ +
  LDA #$19 : STA ($90),Y
  JSR BallChainOrHookshot_Modifier ; $D820
  ORA.b #$02
  RTL
+ ; 22D812
  LDA #$0E : STA ($90),Y
  JSR BallChainOrHookshot_Modifier ; $D820
  ORA.b #$04 ; 02 is gray color 
  RTL
}

; 22D820
BallChainOrHookshot_Modifier:
{
  INY : LDA.b $1A : AND.b #$02
  ASL #6 ; six times
  RTS
}

pushpc

org $8BF1B
  JSL AncillaDraw_Hookshot_BallChain_Properties
  NOP #3

pullpc 

; 22D850
; Hooked into AncillaDraw_HookshotChain @ _08BF1B 
; In place of Hookshot_prop
AncillaDraw_Hookshot_BallChain_Properties:
{
  ; LDA $7EF342 : CMP #$02 : BEQ .ball_chain
  LDA $02B2 : CMP #$01 : BEQ .ball_chain
  LDA $08BD58, X ; 08BD58
  ORA.b #$02
  ORA.b $65
  RTL
; 22D860
.ball_chain
  LDA $08BD58, X ; 08BD58
  ORA.b #$02 ; previously 04 
  ORA.b $65
  RTL
}

; =========================================================
; Start Zarby
HookMaskCheck:
  LDA.w $0202 : AND.w #$00FF : CMP.w #$0008 : BNE .notMask
  LDA.w $0109
  AND #$FF00
  ORA.w #$004A ; #$0042
  RTL
.notMask
  TYA
  AND.w #$00FF
  STA.b $0A
  LDA.w $0109
  AND.w #$FF00
  ORA.b $0A
  RTL

pushpc

org $0DABA2
JSL HookMaskCheck
BRA bralabel

org $0DABB0
bralabel:

; org $008542
; dw $A180, $A1A0, $A1C0, $A1E0
org $008542
dw $A180, $A1A0, $A180, $A1A0
dw $A1C0, $A1C0, $A1E0, $A1E0

; End Zarby 
; =========================================================

org $0DA6E3
  JSL Link_OAM_Actually
  NOP 

pullpc

; 22D880
Link_OAM_Actually:
{
    REP #$20
    ; LDA $7EF342
    LDA $02B2
    AND #$00FF
    ; CMP #$0002
    CMP #$0001
    BEQ + ; $22D892
    LDA $839B,Y
    RTL
  + ;22D892
    LDA $839B,Y
    CMP #$221A
    BEQ ++ ; $22D89B
    RTL
++  ;22D89B
    LDA $0202
    AND #$00FF
    CMP #$0008
    BEQ +++ ; $22D8AA
    LDA $839B,Y
    RTL
 +++ ;22D8AA
    LDA #$241E
    RTL
}

pushpc

; AncillaDraw_HookshotChain_next_object
org $08BFB0
  JML HookshotChain_AncillaDraw

org $08BD64
  Hookshot_box_size_y:

pullpc

; 22D900
HookshotChain_AncillaDraw:
{
  REP #$20
  ; Ball Chain Timer
  LDA $7A  : AND #$00FF : CMP #$0001 : BNE + ; $22D914
  LDA Hookshot_box_size_y, X
  JML $08BFB5 ; Jumps into AncillaDraw_HookshotChain
+ ; $22D914
  CMP #$0000 : BNE ++ ; $22D921
  LDA Hookshot_box_size_y, X
  JML $08BFB5 ; Jumps into AncillaDraw_HookshotChain  
++
  JSR Routine_22E5A0 ; $E5A0 CheckAndClearAncillaId has set the timer in A

  SEP #$30
  ; Compare rotation progress
  CLC : CMP #$FB : BNE +++ ; $22D930
  LDA #$06 : STA $2143
+++ ; 22D930
  BCC ++++ ; $22D935
  JMP StartChainRotation ; $D960
++++ ; 22D935
 ; Compare rotation progress
  CLC : CMP #$AB : BNE +++++ ; $22D93F
  LDA #$06
  STA $2143
+++++ ;22D93F
  ; Compare rotation progress
  CLC : CMP #$5B : BNE ++++++ ; $22D949
  LDA #$06 : STA $2143
++++++ ;22D949
  CLC : CMP #$E6 : BCC +++++++ ; $22D951
  JMP Routine_22D9A0 ; $D9A0
+++++++ ; 22D951
  CLC : CMP #$05 : BCC ++++++++ ; $22D959
  JMP Routine_22D9A0 ; $D9A0
; 22D959
++++++++
  JMP Routine_22DBD0 ; $DBD0
}

; 22D960
StartChainRotation:
{
  REP #$20
  LDA #$0000 : EOR #$FFFF : INC
  CLC
  JSR BallChain_CheckLinkYPosition ; $DA30
  STA $7F5810
  JSR BallChain_CheckLinkXPosition ; $DA50
  STA $7F580E
  SEP #$30
  JSR Routine_22DAD0
  STA $7F5803
  DEC $7A ; Ball Chain Timer
  SEP #$20
  JML $08BFD0 ; Jumps into AncillaDraw_HookshotChain before Hookshot_CheckProximityToLink
}

; $22D9A0
Routine_22D9A0:
{
  LDA $7F5803 : CLC : ADC #$02
  AND #$3F : CPY #$04 : BNE + ; $22D9B6
  STA $7F5803
  CLC : ADC #$02
+ ; 22D9B6
  AND #$3F
  PHX : TAX
  ; Ancilla radial project variable
  LDA $0FFC02,X : STA $4202
  JSR Routine_22DAA0 : STA $4203

  ; Sign of the projected distance.
  LDA $0FFC42,X : STA $02 : STZ $03
  LDA $4216 : ASL
  LDA $4217 : ADC #$00 : STA $00
  STZ $01
  LDA $0FFBC2,X : STA $4202
  JSR Routine_22DAA0 ; $DAA0
  STA $4203

  ; Sign of the projected distance.
  LDA $0FFC82,X : STA $06 : STZ $07

  ; Get X of projected distance
  LDA $4216 : ASL
  LDA $4217 : ADC #$00 : STA $04
  STZ $05

  PHY
  JSL $08DA17 ; Sparkle_PrepOAMFromRadial
  PLY
  PLX
  CPY #$04 : BNE ++ ; $22DA14

  JSR Routine_22DA70 ; $DA70
  NOP #7
  JSR BallChain_SpinAncilla ; $22DB90
++ ;22DA14
  NOP #3
  LDA #$F0 : CPY #$1C : BNE +++ ; $22DA1F
  STA $00
+++ ; 22DA1F
  DEC $7A ; Ball Chain Timer
  SEP #$20
  JML $08BFD0 ; Jumps into AncillaDraw_HookshotChain before Hookshot_CheckProximityToLink
}

;; 22DA30
BallChain_CheckLinkYPosition:
{
  ADC $20 : CLC : ADC #$000C
  CPX #$00 : BNE + ; $22DA3F
  SEC : SBC #$000C
  RTS
+
  CPX #$02 : BNE ++ ; $22DA47
  CLC : ADC #$000C
++
  RTS
}

; 22DA50
BallChain_CheckLinkXPosition:
{
  LDA $22 : CLC : ADC #$0008
  CPX #$04 : BNE + ; $22DA5F
  SEC : SBC #$000C
  RTS
+ ;$22DA5F
  CPX #$06 : BNE ++ ; $22DA67
  CLC : ADC #$000C
++ ;$22DA67
  RTS
}

; 22DA70
Routine_22DA70:
{
  LDY #$00 : LDA $02
  STA ($90),Y

  LDY #$01 : LDA $00
  STA ($90),Y

  LDY #$04
  RTS
}

; 22DA80
Routine_22DA80:
{
  LDA $7EF34A
  CMP #$02
  BNE + ; $22DA89
  RTL
+
  CMP #$01
  BEQ ++ ; $22DA93
  LDA $8580,Y
  STA [$00]
  RTL
++
  LDA #$8F01
  TSC
  SBC ($7E,S),Y
  RTL
}



; 22DAA0
Routine_22DAA0:
{
  CPY #$04 : BNE .alpha ; $22DAA7
  JMP Routine_22DB50 ; $DB50
.alpha ; 22DAA7
  CPY #$08 : BNE + ; $22DAAE
  LDA #$00
  RTS
+ ; 22DAAE
  CPY #$0C : BNE ++ ; $22DAB5
  LDA #$04
  RTS
++ ; 22DAB5
  CPY #$10 : BNE +++ ; $22DABC
  LDA #$08
  RTS
+++ ; 22DABC
  CPY #$14 : BNE ++++ ;$22DAC3
  LDA #$0C
  RTS
++++ ; 22DAC3
  CPY #$18 : BNE +++++ ; $22DACA
  LDA #$10
  RTS
+++++ ; 22DACA
  LDA #$02
  RTS
}

; 22DAD0
Routine_22DAD0:
{
  CPX #$00 : BNE + ; $22DAD7
  LDA #$2E
  RTS
+ ; 22DAD7
  CPX #$02 : BNE ++ ; $22DADE
  LDA #$13
  RTS
++ ; 22DADE
  CPX #$04 : BNE +++ ; $22DAE5
  LDA #$2B
  RTS
+++ ; 22DAE5
  LDA #$09
  RTS
}

pushpc

org $08BF94
  JML BallChain_TryAncillaDraw
  NOP

pullpc

; 22DB00
; Hooks into AncillaDraw_HookshotChain @ 08BF94
; Hookshot box size 
BallChain_TryAncillaDraw:
{
  ; Ball Chain timer should be $FF here on first run
  LDA $7A : AND #$00FF
  CMP #$0000 : BEQ + ; $22DB15
  CMP #$0001 : BEQ + ; $22DB15
  SEP #$20
  JML HookshotChain_AncillaDraw ; $22D900 
+
  LDA Hookshot_box_size_y,X : BNE ++ ; $22DB1F
  JML $08BF99 ; AncillaDraw_HookshotChain
++
  JML $08BFA1 ; Resume AncillaDraw_HookshotChain
}

pushpc 

org $08F7DC
  JML BallChain_CheckProximityToLink

pullpc

; 22DB30
; Hooks into Hookshot_CheckProximityToLink @ 08F7DC
BallChain_CheckProximityToLink:
{
  REP #$20
  ; Ball Chain Timer
  LDA $7A  : AND #$00FF : CMP #$0000 : BNE + ; $22DB44
  ; REP #$20
  LDA.b $00
  JML $08F7E0 ; Hookshot_CheckProximityToLink continue
+ ; 22DB44
  JML $08F820 ; Hookshot_CheckProximityToLink too_far
}

; 22DB50
Routine_22DB50:
{
  ; Ball Chain Timer
  LDA $7A : CLC : CMP #$EA : BCC + ; $22DB5A
  LDA #$08
  RTS
+ ; 22DB5A
  CLC : CMP #$16 : BCC ++ ; $22DB62
  LDA #$14
  RTS
++ ; 22DB62
  CLC
  LDA #$08
  RTS
}


; $22DB90
BallChain_SpinAncilla:
{
  REP #$20
  LDA $00 : CLC : ADC $E8 : CPX #$02
  BNE .alpha
  CLC : ADC #$0010
.alpha
  STA $04
  LDA $02 : CLC : ADC $E2 : STA $06
  SEP #$20
  LDA $04 : STA $0BFE
  LDA $05 : STA $0C12
  LDA $06 : STA $0C08
  LDA $07 : STA $0C1C
  STZ $0C76
  SEP #$30
  RTS
}

; 22DBD0
Routine_22DBD0:
{
  STZ $7A ; Ball Chain Timer
  JSR ClearAncillaVariables ; $DC70
  LDA $2F : CMP #$00 : BNE +
  LDA #$C0 : STA $0C26 
+
  CMP #$02 : BNE ++
  LDA #$40 : STA $0C26 
++
  CMP #$04 : BNE +++
  LDA #$C0 : STA $0C30 
+++
  CMP #$06 : BNE ++++
  LDA #$40 : STA $0C30
++++
  SEP #$20
  STZ $0C58
  STZ $0C62
  STZ $0C54
  REP #$20

  LDA $2F : LSR : STA $0C76
  ASL : TAX
  LDA $20 : CLC
  ADC $099B00,X ; AncillaAdd_Hookshot_offset_y table
  STA $00
  STA $04
  LDA $22 : CLC
  ADC $099B08,X ; AncillaAdd_Hookshot_offset_x table
  STA $02 : STA $06
  SEP #$30
  LDA $00 : STA $0BFE
  LDA $01 : STA $0C12
  LDA $02 : STA $0C08
  LDA $03 : STA $0C1C
  LDX #$06 : LDA Hookshot_box_size_y,X ; hookshot box size y table 
  SEP #$20
  JML $08BFD0 ; Jumps into AncillaDraw_HookshotChain before Hookshot_CheckProximityToLink
}

pushpc

org $08BDFD
  JML HookshotOrBallChain_Extending_ignore_collision

pullpc

; 22DC50
; Hooked into Hookshot_Extending_ignore_collision @ 08BDFD
; P: B0, Index, Memry, Negative, No Carry or Zero 
HookshotOrBallChain_Extending_ignore_collision:
{
  ; Ball Chain Timer
  LDA $7A  : CMP #$00 : BNE + ;$22DC5E
  JSL Hookshot_CheckTileCollision ; $07D576

  JML $08BE01 ; Hookshot_Extending_ignore_collision continue
+ ; 22DC5E
  JML $08BEDC ; AncillaDraw_Hookshot
}

; 22DC70
ClearAncillaVariables:
{
  REP #$30
  LDA #$0000
  STA $7F580E
  STA $7F5810
  STA $7F5803
  SEP #$30
  RTS
}

pushpc

org $08BD7F
  JSL BallChain_SFX_Control
  NOP #1

pullpc

;; 22DC90
; Hooked into Ancilla1F_Hookshot @ 08BD7F before Ancilla_SFX2_Pan
BallChain_SFX_Control:
{
  STA $0C68,X
  ; Ball Chain Timer
  LDA $7A : CMP #$00 : BNE + ; $22DC9C
  LDA.b #$0A ; SFX2.0A
  RTL
+ ;; 22DC9C
  LDA.b #$07 ; Clear SFX2
  RTL
}

; 22DCA0
Routine_22DCA0:
{
  LDA $7A
  CMP #$00
  BNE + ;$A2DCAB
  LDA $0DBB5B,X
  RTL
+
  LDA #$00
  RTL
}

;; 22DD90
CheckAndClearAncillaId:
{
  SEP #$30
  ; Check if hookshot ancillae in this slot
  LDA $0C4A : CMP #$1F : BEQ + ; $22DDC9
  LDA $0C4C : CMP #$1F : BEQ ++ ; $22DDB1
  LDA $0C4D : CMP #$1F : BEQ +++ ; $22DDB9
  LDA $0C4B : CMP #$1F : BEQ ++++ ; $22DDC1
  LDA $7A ; Ball Chain Timer
  RTS
++ ; 22DDB1
  NOP
  NOP
  STZ $0C4C
  LDA $7A
  RTS
+++ ; 22DDB9
  NOP
  NOP
  STZ $0C4D
  LDA $7A
  RTS
++++ ; 22DDC1
  NOP
  NOP
  STZ $0C4B
  LDA $7A
  RTS
+ ; 22DDC9
  STZ $0C4A
  LDA $7A
  RTS
}

; 22E5A0
; Checks for the Somaria block before moving on
Routine_22E5A0:
{
  SEP #$30
  JMP CheckForSomariaBlast ; $EE80
.22E5A5 ; 22E5A5
  LDA $0C4C : CMP #$2C : BNE + ; $22E5B2
  INC $0C4C
  JMP $E5DB
+ ; 22E5B2
  LDA $0C4D : CMP #$2C : BNE ++ ; $22E5BF
  INC $0C4D
  JMP $E5DB
++ ; 22E5BF
  LDA $0C4E : CMP #$2C : BNE +++ ; $22E5CC
  INC $0C4E
  JMP $E5DB
+++ ; 22E5CC
  LDA $0C4F : CMP #$2C : BNE ++++ ; $22E5D9
  INC $0C4F
  JMP $E5DB
++++ ; 22E5D9
  BRA +++++ ; $22E5E0

+++++ ; 22E5E0
  JSR CheckAndClearAncillaId ; $DD90
  RTS
}

; 22E5F0 doesnt execute?
Routine_22E5F0:
{
  LDA $7EF33C
  BNE + ;$22E5F7
  RTL
+ ; 22E5F7
  LDA $4D
  BEQ ++ ; $22E5FC
  RTL
++ ; 22E5FC
  JMP $E108
}

; 22E700
; Hooked into NMI_ReadJoypads @ 0083E7
  STA $F6
  STY $FA
  REP #$30
  LDA $7EE000
  DEC
  BNE $22E721
  LDA $7EF339
  INC
  CMP #$1770
  BCC $22E71A
  LDA #$0000
  STA $7EF339
  LDA #$0E10
  STA $7EE000
  SEP #$30
  RTL


;22EE80
CheckForSomariaBlast:
{
  LDA $0300
  BEQ + ; $22EE88
  JMP $E5DB
; 22EE88
+
  LDA $0C4A
  CMP #$01
  BNE ++ ; $22EE92
  JMP $EEC0
; 22EE92
++
  LDA $0C4B
  CMP #$01
  BNE +++ ; $22EE9C
  JMP $EEC0
; 22EE9C
+++
  LDA $0C4C
  CMP #$01
  BNE ++++ ; $22EEA6
  JMP $EEC0
; 22EEA6
++++
  LDA $0C4D
  CMP #$01
  BNE +++++ ; $22EEB0
  JMP $EEC0
; 22EEB0
+++++
  LDA $0C4E
  CMP #$01
  BNE ++++++ ; $22EEBA
  JMP $EEC0
; 22EEBA
++++++
  JMP Routine_22E5A0_22E5A5 ; $E5A5
}


;; 22EF00
; Hooked inside LinkItem_Hookshot @ 07AB5E
BallChain_StartAnimationFlag:
{
  LDA #$01 : STA $037B ; Vanilla code
  LDA $037A : CMP #$04 ; We are hookshotting

  BNE +
  LDA #$01 : STA $0112 ; Animation flag, prevent menu from opening
+
  RTL
}

pushpc

org $07AB95
  JSL BallChain_Finish
  NOP #2

pullpc

; 22EF12
; Hooked inside LinkState_Hookshotting @ 07AB95 
BallChain_Finish:
{
  STZ.w $0300 : STZ.w $037B ; Restore vanilla
  LDA $037A : CMP #$04 : BNE .not_done ; We are hookshotting
  STZ $0112 ; Clear animation flag
.not_done
  RTL
}

; 22EF30
; Hooked at $07AC98


Hookshot_Init:
{
; ResetAllAcceleration:
 REP #$20

 STZ.w $032F
 STZ.w $0331

 STZ.w $0326
 STZ.w $0328

 STZ.w $032B
 STZ.w $032D

 STZ.w $033C
 STZ.w $033E

 STZ.w $0334
 STZ.w $0336

 SEP #$20


 STZ.w $0300

 LDA.b #$01
 TSB.b $50

 LDA.b #$07
 STA.b $3D

 STZ.b $2E

 LDA.b $67
 AND.b #$F0
 STA.b $67

 LDA.w $037A
 AND.b #$00
 ORA.b #$04
 STA.w $037A

RTL
}
