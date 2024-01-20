;==============================================================================
; Sprite Properties
;==============================================================================

!SPRID              = $A1; The sprite ID you are overwriting (HEX)
!NbrTiles           = 6 ; Number of tiles used in a frame
!Harmless           = 01  ; 00 = Sprite is Harmful,  01 = Sprite is Harmless
!HVelocity          = 00  ; Is your sprite going super fast? put 01 if it is
!Health             = 0  ; Number of Health the sprite have
!Damage             = 0  ; (08 is a whole heart), 04 is half heart
!DeathAnimation     = 00  ; 00 = normal death, 01 = no death animation
!ImperviousAll      = 00  ; 00 = Can be attack, 01 = attack will clink on it
!SmallShadow        = 00  ; 01 = small shadow, 00 = no shadow
!Shadow             = 00  ; 00 = don't draw shadow, 01 = draw a shadow 
!Palette            = 0  ; Unused in this template (can be 0 to 7)
!Hitbox             = 3  ; 00 to 31, can be viewed in sprite draw tool
!Persist            = 00  ; 01 = your sprite continue to live offscreen
!Statis             = 00  ; 00 = is sprite is alive?, (kill all enemies room)
!CollisionLayer     = 00  ; 01 = will check both layer for collision
!CanFall            = 00  ; 01 sprite can fall in hole, 01 = can't fall
!DeflectArrow       = 00  ; 01 = deflect arrows
!WaterSprite        = 00  ; 01 = can only walk shallow water
!Blockable          = 00  ; 01 = can be blocked by link's shield?
!Prize              = 0  ; 00-15 = the prize pack the sprite will drop from
!Sound              = 00  ; 01 = Play different sound when taking damage
!Interaction        = 00  ; ?? No documentation
!Statue             = 00  ; 01 = Sprite is statue
!DeflectProjectiles = 00  ; 01 = Sprite will deflect ALL projectiles
!ImperviousArrow    = 00  ; 01 = Impervious to arrows
!ImpervSwordHammer  = 00  ; 01 = Impervious to sword and hammer attacks
!Boss               = 00  ; 00 = normal sprite, 01 = sprite is a boss
%Set_Sprite_Properties(Sprite_Captain_Prep, Sprite_Captain_Long)

;==================================================================================================
; Sprite Long Hook for that sprite
; --------------------------------------------------------------------------------------------------
; This code can be left unchanged
; handle the draw code and if the sprite is active and should move or not
;==================================================================================================

Sprite_Captain_Long:
{
   PHB : PHK : PLB

   JSR Sprite_Captain_Draw ; Call the draw code
   JSL Sprite_CheckActive   ; Check if game is not paused
   BCC .SpriteIsNotActive   ; Skip Main code is sprite is innactive
      JSR Sprite_Captain_Main ; Call the main sprite code

   .SpriteIsNotActive

   PLB ; Get back the databank we stored previously
   RTL ; Go back to original code
}

;==================================================================================================
; Sprite initialization
; --------------------------------------------------------------------------------------------------
; this code only get called once perfect to initialize sprites substate or timers
; this code as soon as the room transitions/ overworld transition occurs
;==================================================================================================

Sprite_Captain_Prep:
{
   PHB : PHK : PLB

   ; Spawn the 'Parrot'.
   LDA #$0B
   JSL Sprite_SpawnDynamically
   JSL Sprite_SetSpawnedCoords

   ; Set the color to red.
   LDA $0F50, Y : AND.b #$F1 : ORA.b #$06 : STA $0F50, Y

   TYA
   STA.w SprMiscA, X ; keep sprite index

   PLB
   RTL
}

;==================================================================================================
; Sprite Main routines code
; --------------------------------------------------------------------------------------------------
; This is the main local code of your sprite
; This contains all the Subroutines of your sprites you can add more below
;==================================================================================================

Sprite_Captain_Main:
{
   LDA.w SprAction, X; Load the SprAction
   JSL UseImplicitRegIndexedLocalJumpTable; Goto the SprAction we are currently in
   
   dw CaptainMain
   dw MapAnswerCheck
   dw Answer100000
   dw AnswerShovel120
   dw Message03
   dw Message04
   dw GiveShovel
   dw GiveMapAndX
}

CaptainMain:
{
   JSL Sprite_PlayerCantPassThrough

   LDA.l $7EF34C : BNE +
      %ShowSolicitedMessage($113) : BCC .no_message
         %GotoAction(1)
         RTS

      .no_message
   +

   CMP #$02 : BNE + ; we have flute desactivated
      %ShowSolicitedMessage($11F) : BCC .no_message2
         LDA.w SprMiscA, X : TAY
         LDA #$00 : STA.w SprState, Y ;kill cucco sprite
         LDA #$03 : STA.l $7EF34C
         RTS

      .no_message2
   +

   ; doesn't talk anymore if you have activated flute
   RTS
}

MapAnswerCheck:
{
   LDA.w $1CE8 : BNE .No
      %ShowUnconditionalMessage($114)
      %GotoAction(2)
      RTS

   .No

   %GotoAction(0)

   RTS
}

Answer100000:
{
   LDA.w $1CE8 : BNE .Crazy
      %ShowUnconditionalMessage($115)
      %GotoAction(0)
      RTS

   .Crazy

   %ShowUnconditionalMessage($11B)
   %GotoAction(3)

   RTS
}

AnswerShovel120:
{
   LDA.w $1CE8 : BNE .NoDeal
      REP #$20 
      LDA.l $7EF360 : CMP #$0078 : BCC .notenoughrupee
         SEC : SBC #$0078 : STA.l $7EF360
         SEP #$20

      %ShowUnconditionalMessage($11E)
      %GotoAction(6)
      RTS

   .NoDeal

   %GotoAction(0)
   RTS

   .notenoughrupee

   SEP #$20
   %ShowUnconditionalMessage($115)
   %GotoAction(0)

   RTS
}

Message03:
{
   LDY #$13
   JSL Link_ReceiveItem
   %GotoAction(7)

   RTS
}

Message04:
{
   ; NOT ENOUGH RUPEES
   %ShowUnconditionalMessage($115)
   %GotoAction(0)

   RTS
}

GiveShovel:
{
   LDY #$13
   JSL Link_ReceiveItem
   %GotoAction(7)

   RTS
}

GiveMapAndX:
{
   LDY #$33
   JSL Link_ReceiveItem
   LDA #$01 : STA $7EF280 ; set area 00 to non-zero
   %GotoAction(0)

   RTS
}

;==================================================================================================
; Sprite Draw code
; --------------------------------------------------------------------------------------------------
; Draw the tiles on screen with the data provided by the sprite maker editor
;==================================================================================================
Sprite_Captain_Draw:
{
   JSL Sprite_PrepOamCoord
   JSL Sprite_OAM_AllocateDeferToPlayer

   LDA $0DC0, X : CLC : ADC $0D90, X : TAY;Animation Frame
   LDA .start_index, Y : STA $06

   PHX
   LDX .nbr_of_tiles, Y ;amount of tiles -1
   LDY.b #$00

   .nextTile

      PHX ; Save current Tile Index?
         
      TXA : CLC : ADC $06 ; Add Animation Index Offset

      PHA ; Keep the value with animation index offset?

      ASL A : TAX 

      REP #$20

      LDA $00 : CLC : ADC .x_offsets, X : STA ($90), Y
      AND.w #$0100 : STA $0E 
      INY
      LDA $02 : CLC : ADC .y_offsets, X : STA ($90), Y
      CLC : ADC #$0010 : CMP.w #$0100
      SEP #$20

      BCC .on_screen_y
         LDA.b #$F0 : STA ($90), Y ;Put the sprite out of the way
         STA $0E

      .on_screen_y

      PLX ; Pullback Animation Index Offset (without the *2 not 16bit anymore)
      INY
      LDA .chr, X : STA ($90), Y
      INY
      LDA .properties, X : STA ($90), Y

      PHY 
         
      TYA : LSR #2 : TAY
         
      LDA .sizes, X : ORA $0F : STA ($92), Y ; store size in oam buffer
         
      PLY : INY
   PLX : DEX : BPL .nextTile

   PLX

   RTS
}

;==================================================================================================
; Sprite Draw Generated Data
; --------------------------------------------------------------------------------------------------
; This is where the generated Data for the sprite go
;==================================================================================================
   
   .start_index
   db $00

   .nbr_of_tiles
   db 5

   .x_offsets
   dw 0, 0, -4, 12, 12, -5

   .y_offsets
   dw 0, -8, -15, -15, -7, 1

   .chr
   db $88, $86, $8A, $8C, $9C, $8D

   .properties
   db $39, $39, $33, $33, $33, $33

   .sizes
   db $02, $02, $02, $00, $00, $00
