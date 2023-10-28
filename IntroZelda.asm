; =============================================================================
; Zelda Intro Cutscene
; Uses 76 Zelda and C1 Cutscene Agahnim

; Hooked routines 
org $1D8549
Sprite4_DrawMultiple:

org $05F93F
Sprite2_DirectionToFacePlayer:

; =============================================================================

; Hook into the Cutscene Agahnim sprite
org $1DD23F
CutsceneAgahnim_Main:
{
  LDA $35 : BNE .start_cutscene
  JSL Zelda_CheckForStartCutscene
  JMP .return

  .start_cutscene
    ; Start the levitate sequence 
    LDA.b #$40 : STA $0DF0, X ; Set Timer0 for AltarZelda_Main
    LDA.b #$01 : STA $0DC0, X ; Move Zelda to next anim frame

      LDA $35 : CMP #$02 : BEQ .summoned
        LDA #$90 : JSL Sprite_SpawnDynamically
        JSL Sprite_SetSpawnedCoords
      LDA #$02 : STA $35
    .summoned

    JSL Zelda_LevitateAway

  .draw_zelda
    
    ; JSR $D57D ; Sprite_AltarZelda -> AltarZelda_Main
    LDA $0D80, X : JSL UseImplicitRegIndexedLocalJumpTable

    dw $D5A1 ; AltarZelda_Main

  .return
    RTS
}
warnpc $1DD284

; =============================================================================
; 0x76 Zelda Sprite Hooks

; $2ED76-$2ED7D DATA
org    $05ED76
Zelda_WalkTowardsPriest:
{
  .timers
    ;db $26, $1A, $2C, $01
    db $1A, $1A, $2C, $01
  .directions
    ; db $04, $03, $02, $01
    db   $00, $00, $00, $00
}

; *$2EDC4-$2EDEB JUMP LOCATION
org $05EDC4
Zelda_RespondToPriest:
{
    ; "Yes, it was [Name] who helped me escape from the dungeon! ..."
    LDA.b #$1D : LDY.b #$00
    JSL   Sprite_ShowMessageUnconditional
    
    INC $0D80, X ; Move to Zelda_BeCarefulOutThere next state
    
    LDA.b #$02 : STA $7FFE01 ; Zelda rescue dialog counter 
    LDA.b #$01 : STA $7EF3C8 ; Set Sanctuary Spawn point 

    REP #$30 : LDA.b #$30 : STA SprTimerD, X : SEP   #$30
    
    RTS
}

Zelda_BeCarefulOutThere:
{
    JSR Sprite2_DirectionToFacePlayer : TYA : EOR.b #$03 : STA $0EB0, X

    LDA SprTimerD, X : BNE .didnt_speak
    
    LDA #$01 : STA $35
    LDA #$27 : STA $012F
    STZ $0DD0, X
    ; ; "[Name], be careful out there! I know you can save Hyrule!"
    ; LDA.b #$1E
    ; LDY.b #$00
    
    ; JSL Sprite_ShowSolicitedMessageIfPlayerFacing : BCC .didnt_speak
    
    ; STA $0DE0, X
    ; STA $0EB0, X

  .didnt_speak

    RTS
}

; =============================================================================
; Custom Code Region 

org $248000
; Check for the position of the player 
Zelda_CheckForStartCutscene:
{
    REP #$20
    ; Sprite X - Player X
    LDA $0FD8 : SEC : SBC $22 : BPL .positive_x
    EOR #$FFFF
  .positive_x
    STA $00                                     ; Distance X (ABS)
    ; Sprite Y - Player Y
    LDA $0FDA : SEC : SBC $20 : BPL .positive_y
    EOR #$FFFF
  .positive_y
    ; Add it back to X Distance
    CLC : ADC $00 : STA $02    ; distance total X, Y (ABS)
    ; Distance away from player
    CMP #$0040 : BCS .no_zelda
    SEP #$20

    ; If player is near, check for Zelda follower
    LDA $7EF3CC : CMP.b #$01 : BNE .no_zelda

    LDA.b #$21 : LDY.b #$00
    JSL   Sprite_ShowMessageUnconditional

    JSR Uncle_GiveSwordAndShield
    JSR Zelda_TransitionFromTagalong

    LDA #$99 : STA SprTimerC, X
    
    RTL

  .no_zelda
    SEP #$20
    RTL
}

Uncle_GiveSwordAndShield:
{
  LDY.b #$00 : STZ $02E9
  JSL   Link_ReceiveItem
  LDA.b #$01 : STA $0DC0, X

  LDA.b #$01 : STA $7EF3C5
  RTS
}

Zelda_TransitionFromTagalong:
{
    ; Transition princess Zelda back into a sprite from the tagalong
    ; state (the sage's sprite is doing this).
    LDA.b #$76 : JSL Sprite_SpawnDynamically
    
    PHX
    
    LDX $02CF
    
    LDA $1A64, X : AND.b #$03 : STA $0EB0, Y : STA $0DE0, Y
    
    LDA $20 : STA $0D00, Y ; SprY Low
    LDA $21 : STA $0D20, Y ; SprY High
    LDA $22 : STA $0D10, Y ; SprX Low
    LDA $23 : STA $0D30, Y ; SprX High
    
    LDA.b #$01 : STA $0E80, Y ; SprDelay
    
    LDA.b #$00 : STA $7EF3CC ; Remove tagalong
    
    LDA $0BA0, Y : INC A : STA $0BA0, Y
    
    ; ISPH HHHH - [I ignore collisions][S Statis (not alive eg beamos)][P Persist code still run outside of camera][H Hitbox] 
    LDA.b #$03 : STA $0F60, Y ; SprHitbox
    
    PLX
    
    RTS
}

SummonRogueWallmaster:
{
  LDA #$90 : JSL Sprite_SpawnDynamically
  JSL Sprite_SetSpawnedCoords
  LDA $0D00, Y : SEC : SBC.b #$20 : STA $0D00, Y
  ; LDA #$01 : STA $0D80, Y ; Set subtype
  RTL
}

Zelda_LevitateAway:
{
  ; Increase the sprite height 
  LDA.w SprTimerC, X : BNE .dontchangeheight
    INC.w SprHeight, X
    LDA #$28 : STA $012F ; Play warp away sfx
    ; LDA.w SprMiscA, X : STA.w SprTimerC, X : DEC : STA.w SprMiscA, X
  .dontchangeheight

  ; Check the height of the sprite, dismiss once its gone 
  LDA SprHeight, X : CMP.b #$9F : BCC .draw_zelda

    ; Spawn a rogue wallmaster
    LDA #$90 : JSL Sprite_SpawnDynamically

    PHX
    
    LDX $02CF
    
    LDA $1A64, X : AND.b #$03 : STA $0EB0, Y : STA $0DE0, Y
    LDA $20 : CLC : ADC.b #$02 : STA $0D00, Y ; SprY Low
    LDA $21 : STA $0D20, Y ; SprY High
    LDA $22 : STA $0D10, Y ; SprX Low
    LDA $23 : STA $0D30, Y ; SprX High
    LDA.b #$01 : STA $0E80, Y ; SprDelay
    LDA $0BA0, Y : INC A : STA $0BA0, Y
    
    ; ISPH HHHH - [I ignore collisions][S Statis (not alive eg beamos)][P Persist code still run outside of camera][H Hitbox] 
    LDA.b #$03 : STA $0F60, Y ; SprHitbox
    
    PLX

    ; Change the game state
    LDA.b #$02 : STA $7EF3C5
    LDA.b #$01 : STA $7EF3C8
    LDA.b #$04 : STA $7EF3C6
    
    ; Sprite_LoadGfxProperties.justLightWorld
    PHX : JSL $00FC62 : PLX

    LDA #$4D : STA $04AA

    ; Goodbye Zelda
    STZ $0DD0,     X

.draw_zelda
  RTL
}


; =============================================================================

; Hook into the Cutscene AltarZelda sprite
org $1DD5E9
AltarZelda_DrawBody:

; sheet00 $03, $04, $00, $00
; sheet01 $43, $44, $40, $40
; sheet02 $83, $84, $80, $80
; sheet03 $C3, $C4, $C0, $C0
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
    LDA.w $0DF0, X
    BEQ   .not_telewarping_zelda
    
    ; Draw telewarp effect
    PHA   : JSR AltarZelda_DrawWarpEffect : PLA
    CMP.b #$01 : BNE .delay_self_termination
    
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

; $ED661-$ED6B0 DATA
org $1DD661
AltarZelda_WarpEffectOam:
{
    dw 4, 4 : db $80, $04, $00, $00
    dw 4, 4 : db $80, $04, $00, $00
    
    dw 4, 4 : db $B7, $04, $00, $00
    dw 4, 4 : db $B7, $04, $00, $00
    
    dw -6, 0 : db $24, $05, $00, $02
    dw 6, 0 : db $24, $45, $00, $02
    
    dw -8, 0 : db $24, $05, $00, $02
    dw 8, 0 : db $24, $45, $00, $02
    
    dw 0, 0 : db $C6, $05, $00, $02
    dw 0, 0 : db $C6, $05, $00, $02
}

org $1DD6B1
AltarZelda_DrawWarpEffect:
{
    LDA.b #$08 : JSL OAM_AllocateFromRegionB
    
    LDA.b #$00 : XBA
    
    LDA $0DF0, X : LSR #2 : REP #$20 : ASL #4
    
    ADC.w #AltarZelda_WarpEffectOam : STA $08
    
    SEP #$20
    
    LDA.b #$02 : JMP Sprite4_DrawMultiple
}

; warnpc $1DD5D8