; Zelda Intro Cutscene
; Uses 76 Zelda and C1 Cutscene Agahnim

org $1D8549
Sprite4_DrawMultiple:

org $1DD6B1
AltarZelda_DrawWarpEffect:

org $1DD5E9
AltarZelda_DrawBody:

; We should jump here when sprite 0xC1 comes into frame
; in CutsceneAgahnim_Main before Cutscene_Zelda
org $248000
LevitateZelda_Hook:
{
  ; Check for the position of the player 
  
    ; If player is near, check for Zelda follower
    LDA $7EF3CC : CMP.b #$01 : BNE .no_zelda

      ; Run a dialogue from Zelda.
      ; Grant the player the Sword and Shield.

      ; Remove the follower
      ; Summon a Walking Zelda (0x76) south of player pos
      JSR Zelda_TransitionFromTagalong

      ; Run another dialogue from Zelda
        ; Dismiss 0x76 Zelda, start 0xC1 Cutscene_Zelda
        ; Run the levitate and warp away animation
          ; Based on CutsceneAgahnim_LevitateZelda hardcoded

      ; Set RAM to dismiss village guards
      ; Change the game state(?)

  .no_zelda
    RTS
}

; TODO: Modify this routine to spawn Zelda south of Link
; and have her walk to the right and then up towards the 
; Weathervane and 0xC1 Cutscene_Zelda spawn position 
Zelda_TransitionFromTagalong:
{
    ; Transition princess Zelda back into a sprite from the tagalong
    ; state (the sage's sprite is doing this).
    
    LDA.b #$76 : JSL Sprite_SpawnDynamically
    
    PHX
    
    LDX $02CF
    
    LDA $1A64, X : AND.b #$03 : STA $0EB0, Y : STA $0DE0, Y
    
    LDA $20 : STA $0D00, Y
    LDA $21 : STA $0D20, Y
    
    LDA $22 : STA $0D10, Y
    LDA $23 : STA $0D30, Y
    
    LDA.b #$01 : STA $0E80, Y
    
    LDA.b #$00 : STA $7EF3CC
    
    LDA $0BA0, Y : INC A : STA $0BA0, Y
    
    LDA.b #$03 : STA $0F60, Y
    
    PLX
    
    RTS
}

org $1DD23F
CutsceneAgahnim_Main:
{
  ; Set the timer every frame to prevent anim and dismissal
  LDA.b #$40 : STA $0DF0, X ; Timer0

  ; Skip straight to Levitate Zelda Sprite
  JSR $D57D ; Sprite_AltarZelda -> AltarZelda_Main
}

org $1DD581
AltarZelda_OamGroups:
{
  dw -4,   0 : db $03, $01, $00, $02
  dw 4,   0 : db $04, $01, $00, $02

  dw -4,   0 : db $00, $01, $00, $02
  dw 4,   0 : db $01, $01, $00, $02
}

; Main fn for the Zelda subtype of the Cutscene Agahnim sprite
; This is where the levitate Zelda animation will run
org $1DD5A1
AltarZelda_Main:
{
    LDA.w $0DF0, X : BEQ .not_telewarping_zelda
    
    ; Draw telewarp effect
    PHA : JSR AltarZelda_DrawWarpEffect
    PLA : CMP.b #$01 : BNE .delay_self_termination
    
    STZ.w $0DD0, X

.delay_self_termination

    CMP.b #$0C : BCS .also_draw_zelda_body
    
    RTS

.also_draw_zelda_body
.not_telewarping_zelda

    LDA.b #$08 : JSL OAM_AllocateFromRegionA
    
    LDA.b #$00 : XBA
    
    LDA.w $0DC0, X
    REP   #$20 : ASL #4
    ADC.w #AltarZelda_OamGroups : STA.b $08
    
    SEP #$20
    
    LDA.b #$02 : JSR Sprite4_DrawMultiple
    
    JSR AltarZelda_DrawBody
    
    RTS
}
