
org $078028
  Player_DoSfx2:

org $02A1B1
  Dungeon_SaveRoomData:

org $07A91A
; Magic Mirror routine
; *$3A91A-$3A9B0 JUMP LOCATION
LinkItem_Mirror:
{
  ; Check for a press of the Y button.
  BIT $3A : BVS .BRANCH_ALPHA
  
  JSR $B073 : BCC $A8EB
  
  LDA $8A : CMP.b #$58 : BNE $A8EB

  LDA $20   
  CMP.w #$0968 : BCC $A8EB
  CMP.w #$08A0 : BCS $A8EB
          
  LDA $22
  CMP.w #$0040 : BCC .cantWarp
  CMP.w #$01A0 : BCS .cantWarp

  ; ; Seems the Kiki tagalong prevents you from warping?
  ; LDA $7EF3CC : CMP.b #$0A : BNE .BRANCH_ALPHA
  
  ; REP #$20
  
  ; ; Probably Kiki bitching at you not to warp.
  ; LDA.w #$0121 : STA $1CF0
  
  ; SEP #$20
  
  ; JSL Main_ShowTextMessage
  
  ; BRL .cantWarp

.BRANCH_ALPHA: ; Y Button pressed.

  ; Erase all input except for the Y button.
  LDA $3A : AND.b #$BF : STA $3A
  
  ; If Link's standing in a doorway he can't warp
  LDA $6C : BNE .BRANCH_BETA
  
  LDA $037F : BNE .BRANCH_GAMMA
  
  ; Am I indoors?
  LDA $1B : BNE .BRANCH_GAMMA
  
  ; Check if we're in the dark world.
  LDA $8A : AND.b #$40 : BNE .BRANCH_GAMMA

; *$3A955 ALTERNATE ENTRY POINT
.BRANCH_BETA:

  ; Play the "you can't do that" sound.
  LDA.b #$3C : JSR Player_DoSfx2
  
  BRA .cantWarp

; *$3A95C ALTERNATE ENTRY POINT
.BRANCH_GAMMA:

  LDA $1B : BEQ .outdoors
  
  LDA $0FFC : BNE .cantWarp
  
  JSL Dungeon_SaveRoomData ; $121B1 IN ROM
  
  LDA $012E : CMP.b #$3C : BEQ .cantWarp
  
  STZ $05FC
  STZ $05FD
  
  BRA .cantWarp

.outdoors

  LDA $10 : CMP.b #$0B : BEQ .inSpecialOverworld
  
  LDA $8A : AND.b #$40 : STA $7B : BEQ .inLightWorld
  
  ; If we're warping from the dark world to the light world
  ; we generate new coordinates for the warp vortex
  LDA $20 : STA $1ADF
  LDA $21 : STA $1AEF
  
  LDA $22 : STA $1ABF
  LDA $23 : STA $1ACF

.inLightWorld

  LDA.b #$23

; *$3A99C ALTERNATE ENTRY POINT

  STA $11
  
  STZ $03F8
  
  LDA.b #$01 : STA $02DB
  
  STZ $B0
  STZ $27
  STZ $28
  
  ; Go into magic mirror mode.
  LDA.b #$14 : STA $5D

.cantWarp
.inSpecialOverworld

  RTS
}
warnpc $07A9B0