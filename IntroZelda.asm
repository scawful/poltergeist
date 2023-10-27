; Zelda Intro Cutscene
; Uses 76 Zelda and C1 Cutscene Agahnim

; Hooked routines 
org $1D8549
Sprite4_DrawMultiple:

; org $1DD6B1
; AltarZelda_DrawWarpEffect:

org $1DD5E9
AltarZelda_DrawBody:

; We should jump here when sprite 0xC1 comes into frame
; in CutsceneAgahnim_Main before Cutscene_Zelda
org $248000
LevitateZelda_CheckForStartCutscene:
{
    ; Check for the position of the player 
    REP #$20
    LDA $0FD8 ; Sprite X
    SEC : SBC $22 ; - Player X
    BPL +
    EOR #$FFFF
    +
    STA $00 ; Distance X (ABS)

    LDA $0FDA ; Sprite Y
    SEC : SBC $20 ; - Player Y
    BPL +
    EOR #$FFFF
    +
    ; Add it back to X Distance
    CLC : ADC $00 : STA $02 ; distance total X, Y (ABS)

    CMP #$0040 : BCS .no_zelda
    SEP #$20

    ; If player is near, check for Zelda follower
    LDA $7EF3CC : CMP.b #$01 : BNE .no_zelda

      ; TODO: Grant the player the Sword and Shield.
      JSR Zelda_TransitionFromTagalong

      LDA #$01 : STA $35
      RTL

      ; TODO: Run the levitate and warp away animation
      ; TODO: Based on CutsceneAgahnim_LevitateZelda hardcoded

      ; TODO: Set RAM to dismiss village guards
      ; TODO: Change the game state(?)

  .no_zelda
    SEP #$20
    RTL
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

Zelda_SpawnAndLevitate:
{
 ; Spawn the Zelda companion sprite so Agahnim has something to teleport.
  LDA.b #$C1 : JSL Sprite_SpawnDynamically
  
  LDA.b #$01 : STA $0D90, Y
               STA $0BA0, Y
  
  JSL Sprite_SetSpawnedCoords
  
  LDA $02 : CLC : ADC.b #$28 : STA $0D00, Y
  
  LDA.b #$00 : STA $0E40, Y
  
  LDA.b #$0C : STA $0F50, Y
  
  RTL
}

; $2ED76-$2ED7D DATA
org $05ED76
Zelda_WalkTowardsPriest:
{
  .timers
    db $26, $1A, $2C, $01

  .directions
    ; db $04, $03, $02, $01
    db $00, $00, $00, $00
}

; *$2EDC4-$2EDEB JUMP LOCATION
org $05EDC4
Zelda_RespondToPriest:
{
    ; "Yes, it was [Name] who helped me escape from the dungeon! ..."
    LDA.b #$1D
    LDY.b #$00
    
    JSL Sprite_ShowMessageUnconditional
    
    INC $0D80, X
    
    LDA.b #$02 : STA $7FFE01
    
    LDA.b #$01 : STA $7EF3C8

    ; JSL $00F9DD ; SavePalaceDeaths
    
    ; LDA.b #$02 : STA $7EF3C5
    
    ; PHX
    
    ; JSL $00FC62 ; Sprite_LoadGfxProperties.justLightWorld
    
    ; PLX
    
    RTS
}

; Hook into the Cutscene Agahnim sprite
org $1DD23F
CutsceneAgahnim_Main:
{
  LDA $35 : BNE .cutscene_started
  JSL LevitateZelda_CheckForStartCutscene
  JMP .draw_zelda  

  .cutscene_started
    ; Skip straight to Levitate Zelda Sprite
    LDA.b #$50 : STA $0DF0, X ; Timer0
    LDA.b #$01 : STA $0DCF
    LDA.b #$02 : STA $0E80, X
    LDA.b #$FF : STA $0E30, X
  .draw_zelda
    JSR $D57D ; Sprite_AltarZelda -> AltarZelda_Main
    
  .no_warp
    RTS
}

; Hook into the Cutscene AltarZelda sprite
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
    BEQ .not_telewarping_zelda
    
    ; Draw telewarp effect
    PHA : JSR AltarZelda_DrawWarpEffect : PLA 
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
WarpEffect_oam_groups:
{
    dw  4, 4 : db $80, $04, $00, $00
    dw  4, 4 : db $80, $04, $00, $00
    
    dw  4, 4 : db $B7, $04, $00, $00
    dw  4, 4 : db $B7, $04, $00, $00
    
    dw -6, 0 : db $24, $05, $00, $02
    dw  6, 0 : db $24, $45, $00, $02
    
    dw -8, 0 : db $24, $05, $00, $02
    dw  8, 0 : db $24, $45, $00, $02
    
    dw  0, 0 : db $C6, $05, $00, $02
    dw  0, 0 : db $C6, $05, $00, $02
}

org $1DD6B1
AltarZelda_DrawWarpEffect:
{
    LDA.b #$08 : JSL OAM_AllocateFromRegionB
    
    LDA.b #$00 : XBA
    
    LDA $0DF0, X : LSR #2 : REP #$20 : ASL #4
    
    ADC.w #WarpEffect_oam_groups : STA $08
    
    SEP #$20
    
    LDA.b #$02 : JMP Sprite4_DrawMultiple
}

; warnpc $1DD5D8