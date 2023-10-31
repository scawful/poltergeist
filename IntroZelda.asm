; =============================================================================
; Zelda Intro Cutscene
; Uses 76 Zelda and C1 Cutscene Agahnim
;
; $35   - Cutscene State
; $0FA6 - Wallmaster ID for tracking Zelda height

InCutScene = $7EF303

org        $0083F8
LDA        InCutScene : BEQ .notInCutscene
    STZ $F0
    STZ $F2
    STZ $F4
    STZ $F6
    STZ $F8
    STZ $FA ; kill all input

.notInCutscene

RTS

; Hooked routines 
org $1D8549
Sprite4_DrawMultiple:

org $05F93F
Sprite2_DirectionToFacePlayer:

; Aginah in room 11
org $068CE3
CMP.b #$11 : BNE .notAginah
        
      INC $0E80, X
      
      ; Basically changes him to Aginah rather than Sahasralah
      LDA.b #$0F : STA $0F50, X
    
    .notAginah

; -------- Orange Dress ----------
; 76 Zelda Sprite Palette 
org $0DB3CF
  db $1F 

; C1 
org $0DB41A
  db $0E 

; Follower palettes 
org $09A8F9
  db $00
  db $07 ; Zelda

org $08C003
Ancilla_BedSpread:
{

.chr
    db $0A, $0A, $0A, $0A
    db $0C, $0C, $0A, $0A
    
.properties
    db $06, $66, $A6, $E6
    db $06, $66, $A6, $E6
}

; --------------------------------

; ; 76 Zelda Sprite Palette 
; org $0DB3CF
;   db $1D 

; ; C1 
; org $0DB41A
;   db $0C ; yellow 
;   ; db $02 ; weird yellow index $9X
;   ; db $06    ; $BX

; ; Follower palettes 
; org $09A8F9
;   db $00
;   db $0E ; Zelda

; Snitch Draw code ? 
org $1AF8AC
dw 0, -8 : db $E0, $20, $00, $02
dw 0, 0 : db $E8, $20, $00, $02
dw 0, -7 : db $E0, $20, $00, $02
dw 0, 1 : db $E8, $60, $00, $02

dw 0, -8 : db $C0, $20, $00, $02
dw 0, 0 : db $C2, $20, $00, $02
dw 0, -7 : db $C0, $20, $00, $02
dw 0, 1 : db $C2, $60, $00, $02

dw 0, -8 : db $E2, $20, $00, $02
dw 0, 0 : db $E4, $20, $00, $02
dw 0, -7 : db $E2, $20, $00, $02
dw 0, 1 : db $E6, $20, $00, $02

dw 0, -8 : db $E2, $60, $00, $02
dw 0, 0 : db $E4, $60, $00, $02
dw 0, -7 : db $E2, $60, $00, $02
dw 0, 1 : db $E6, $60, $00, $02

; =============================================================================

; Skip the spawning of a second Zelda for the vanilla cutscene
; I'm just mowing through unused agahnim cutscene code here 
; Don't mind me...
org $06893B
SpritePrep_ChattyAgahnim:
{
    LDA $0403 : AND.b #$40 : BEQ .not_triggered
    
    STZ $0DD0, X
    
    RTS

.not_triggered
    JMP $8BA7 ; SpritePrep_IgnoresProjectiles
}

; Hook into the Cutscene Agahnim sprite
org $1DD23F
CutsceneAgahnim_Main:
{
  LDA $35 : BNE .start_cutscene
  JSL Zelda_CheckForStartCutscene
  JMP .return

  .start_cutscene
  CMP.b #$03 : BEQ .old_man_save_me
  CMP.b #$04 : BEQ .no_really_please
  CMP.b #$05 : BEQ .this_isnt_funny
  CMP.b #$06 : BEQ .return

    ; Start the levitate sequence 
    LDA.b #$40 : STA $0DF0, X ; Set Timer0 for AltarZelda_Main
    LDA.b #$01 : STA $0DC0, X ; Move Zelda to next anim frame
    LDA.b #$0C : STA $0E60, X

      LDA $35 : CMP #$02 : BEQ .summoned
        JSL SummonRogueWallmaster
        LDA #$02 : STA $35 ; Advance the cutscene
    .summoned

    JSL Zelda_LevitateAway

  .draw_zelda
    LDA $0D80, X : JSL UseImplicitRegIndexedLocalJumpTable
    dw $D5A1 ; AltarZelda_Main

  .return
    RTS

  .old_man_save_me
    ; Old man needs a minute to prepare his spells
    STZ $02F5
    LDA #$00 : STA InCutScene ; Allow Link to move again
    LDA #$FF : STA SprTimerA, X  ; Start the timer
    LDA #$4F : STA $7E010E ; Set destination of old man
    LDA #$04 : STA $35 ; Advance the cutscene
    JSL OldMan_AdvanceGameState

    ; Run some dialogue from the bad guy
    LDA #$0E : LDY #$00
    JSL Sprite_ShowMessageUnconditional
    RTS

  .no_really_please
    ; Wait for it...
    LDA SprTimerA, X : BNE .return
    LDA #$FF : STA SprTimerA, X ; Start the timer again
    
    LDA #$11 : STA $012D ; Play the church music
    LDA #$05 : STA $35 ; Advance the cutscene 
    RTS

  .this_isnt_funny
    LDA SprTimerA, X : BNE .return
    JSL $0BFFA8 ; WallMaster_SendPlayerToLastEntrance
    LDA #$06 : STA $35 ; End the cutscene 
    RTS

}

warnpc $1DD2D0

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
    LDA.b #$00 : STA $7EF3C8 ; Set Sanctuary Spawn point 

    REP #$30 : LDA.b #$30 : STA SprTimerD, X : SEP   #$30
    
    RTS
}

Zelda_BeCarefulOutThere:
{
    JSR Sprite2_DirectionToFacePlayer : TYA : EOR.b #$03 : STA $0EB0, X

    LDA SprTimerD, X : BNE .didnt_speak
    
    LDA #$01 : STA $35   ; Advance the cutscene state
    LDA #$27 : STA $012F ; Levitate charge sfx 

    STZ $0DD0, X ; Dismiss Zelda

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
    CMP #$0046 : BCS .no_zelda
    SEP #$20

    ; If player is near, check for Zelda follower
    LDA $7EF3CC : CMP.b #$01 : BNE .no_zelda

    LDA #$02 : STA $02F5 ; prevent link from moving 

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
  RTS
}

Zelda_TransitionFromTagalong:
{
    ; Transition princess Zelda back into a sprite from the tagalong
    ; state (the sage's sprite is doing this).
    LDA.b #$76 : JSL Sprite_SpawnDynamically
    
    PHX
    
    LDX $02CF
    
    ; LDA $1A64, X : AND.b #$03 : STA $0EB0, Y : STA $0DE0, Y
    
    LDA $20 : STA $0D00, Y ; SprY Low
    LDA $21 : STA $0D20, Y ; SprY High
    LDA $22 : STA $0D10, Y ; SprX Low
    LDA $23 : STA $0D30, Y ; SprX High
    
    LDA.b #$01 : STA $0E80, Y ; SprDelay
    
    LDA.b #$00 : STA $7EF3CC ; Remove tagalong
    
    ; LDA $0BA0, Y : INC A : STA $0BA0, Y

    ; LDA #$19 : STA $0F50, Y

    ; ISPH HHHH - [I ignore collisions][S Statis (not alive eg beamos)][P Persist code still run outside of camera][H Hitbox] 
    LDA.b #$03 : STA $0F60, Y ; SprHitbox
    
    PLX
    
    RTS
}

SummonRogueWallmaster:
{
  LDA #$90 : JSL Sprite_SpawnDynamically
  JSL Sprite_SetSpawnedCoords
  
  LDA $0F70 : CLC : ADC #$40 : STA $0F70, Y
  LDA $0D00, Y : SEC : SBC.b #$06 : STA $0D00, Y
  LDA #$0C : STA $0F50, Y 
  LDA #$01 : STA InCutScene

  TYA : STA $0FA6
  RTL
}

Zelda_LevitateAway:
{
  LDA.w SprTimerC, X : BNE .dont_levitate
    ; Increase the sprite height with the wallmaster ID in $0FA6
    PHX : LDA $0FA6 : TAX : LDA SprHeight, X : PLX
    STA SprHeight, X
    LDA #$28 : STA $012F ; Play warp away sfx
  .dont_levitate

  ; Check the height of the sprite, dismiss once its gone 
  LDA SprHeight, X : CMP.b #$9F : BCC .draw_zelda

    ; Spawn a rogue wallmaster
    LDA #$90 : JSL Sprite_SpawnDynamically
    LDA #$0C : STA $0F50, Y 
    PHX
    
    LDX $02CF
    
    LDA $1A64, X : AND.b #$03 : STA $0EB0, Y : STA $0DE0, Y
    LDA $20 : STA $0D00, Y ; SprY Low
    LDA $21 : STA $0D20, Y ; SprY High
    LDA $22 : STA $0D10, Y ; SprX Low
    LDA $23 : STA $0D30, Y ; SprX High

    LDA $24 : CLC : ADC #$80 : STA $0F70, Y ; SprZ Low
    LDA.b #$01 : STA $0E80, Y ; SprDelayso yea
    LDA $0BA0, Y : INC A : STA $0BA0, Y
    
    ; ISPH HHHH - [I ignore collisions][S Statis (not alive eg beamos)][P Persist code still run outside of camera][H Hitbox] 
    LDA.b #$03 : STA $0F60, Y ; SprHitbox
    
    PLX

    ; Set destination after Link is kidnapped by Wallmaster
    LDA #$4E : STA $7E010E

    ; Advance the cutscene state 
    LDA #$03 : STA $35

    ; Goodbye Zelda
    STZ $0DD0,     X

.draw_zelda
  RTL
}

OldMan_AdvanceGameState:
{
  ; Change the game state
  LDA.b #$02 : STA $7EF3C5
  LDA.b #$00 : STA $7EF3C8
  LDA.b #$11 : STA $7EF3C6
  
  ; Sprite_LoadGfxProperties.justLightWorld
  PHX : JSL $00FC62 : PLX

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