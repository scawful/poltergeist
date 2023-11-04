; Jeibumpkin ? Room 7C
; Dialoge ID - 011D

pushpc

org $09A1EC
  JSL CheckForMaidenInLibrary

pullpc 

CheckForMaidenInLibrary:
{
  LDA $A0 : CMP.b #$7C : BNE .notTheLibrary

  LDA $7FF9D2 : BNE .dialogue_played

    LDA #$1D : LDY #$01
    JSL Sprite_ShowMessageUnconditional
    LDA #$01 : STA $7FF9D2

    .dialogue_played

  .notTheLibrary
  ; Check for blind room vanilla
  REP #$20
  LDA.b $A0
  RTL
}
