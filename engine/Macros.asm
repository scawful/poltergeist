SprAction    = $0D80
SprFrame     = $0D90 ; This is also used to do various things in different sprites
SprMiscA     = $0DA0 ; This can be used to do anything in sprite
SprMiscB     = $0DB0 ; This can be used to do anything in sprite
SprMiscC     = $0DE0 ; This can be used to do anything in sprite (Mainly used for sprite direction)
SprMiscD     = $0E90 ; This can be used to do anything in sprite
SprMiscE     = $0EB0 ; This can be used to do anything in sprite
SprMiscF     = $0EC0 ; This can be used to do anything in sprite
SprMiscG     = $0ED0 ; This can be used to do anything in sprite

SprStunTimer = $0B58

SprTimerA    = $0DF0 ; This address value is decreased by one every frames
SprTimerB    = $0E00 ; This address value is decreased by one every frames
SprTimerC    = $0E10 ; This address value is decreased by one every frames
SprTimerD    = $0EE0 ; This address value is decreased by one every frames
SprTimerE    = $0F10 ; This address value is decreased by one every frames
SprTimerF    = $0F80 ; This address value is decreased by 2 every frames is also used by the gravity routine

SprPause     = $0F00 ; Can probably be used for anything 
SprFloor     = $0F20
SprType      = $0E20 ; This contains the ID of the sprite 00 = raven, 01 = vulture, etc...
SprSubtype   = $0E30 ; This contains the Sub ID of the sprite
SprState     = $0DD0 ; This tells if the sprite is alive, dead, frozen, etc...

SprNbrOAM    = $0E40 ; Bits 0-4: define the number of OAM slots used by the sprite
SprHealth    = $0E50
SprGfxProps  = $0E60
SprCollision = $0E70 ; When a sprite hit a wall, this gets set to the direction in which the collision occurred.
SprDelay     = $0E80 ; Used in sprite state 0x03 (falling in water), used as delay in most of the sprites
SprRecoil    = $0EA0 ; Recoil Timer
SprDeath     = $0EF0

SprProps     = $0F50 ; DIWS UUUU - [D boss death][I Impervious to all attacks][W Water slash] [S Draw Shadow] [U Unused]
SprHitbox    = $0F60 ; ISPH HHHH - [I ignore collisions][S Statis (not alive eg beamos)][P Persist code still run outside of camera][H Hitbox] 
SprHeight    = $0F70 ; Distance from the shadow
SprHeightS   = $0F90 ; Distance from the shadow subpixel

SprYRecoil   = $0F30
SprXRecoil   = $0F40

SprGfx       = $0DC0 ; Determine the GFX used for the sprite
OAMPtr       = $90
OAMPtrH      = $92

SprY         = $0D00
SprX         = $0D10
SprYH        = $0D20
SprXH        = $0D30

SprYSpeed    = $0D40
SprXSpeed    = $0D50

SprYRound    = $0D60
SprXRound    = $0D70

SprCachedX   = $0FD8 ; This doesn't need to be indexed with X it contains the 16bit position of the sprite
SprCachedY   = $0FDA ; This doesn't need to be indexed with X it contains the 16bit position of the sprite

; Write Sprite Properties in the rom MACRO
macro Set_Sprite_Properties(SprPrep, SprMain)

pushpc ; Save writing Position for the sprite
org $0DB080+!SPRID ; Oam Harmless ($0E40)
db ((!Harmless<<7)|(!HVelocity<<6)|!NbrTiles)

org $0DB173+!SPRID ; Sprite HP ($0E50)
db !Health

org $0DB266+!SPRID ; Sprite Damage ($0CD2)
db !Damage

org $0DB359+!SPRID ; Sprite Data ($0E60 / $0F50)
db ((!DeathAnimation<<7)|(!ImperviousAll<<6)|(!SmallShadow<<5)|(!Shadow<<4)|(!Palette<<1))

org $0DB44C+!SPRID ; Sprite Hitbox ($0F60)
db ((!CollisionLayer<<7)|(!Statis<<6)|(!Persist<<5)|(!Hitbox))

org $0DB53F+!SPRID ; Sprite Fall ($0B6B)
db ((!DeflectArrow<<3)|(!Boss<<1)|!CanFall)

org $0DB632+!SPRID ; Sprite Prize ($0BE0)
db ((!Interaction<<7)|(!WaterSprite<<6)|(!Blockable<<5)|(!Sound<<4)|!Prize)

org $0DB725+!SPRID ; Sprite ($0CAA)
db ((!Statue<<5)|(!DeflectProjectiles<<4)|(!ImpervSwordHammer<<2)|(!ImperviousArrow<<1))

org $069283+(!SPRID*2) ; Vanilla Sprite Main Pointer
dw NewMainSprFunction

org $06865B+(!SPRID*2) ; Vanilla Sprite Prep Pointer
dw NewSprPrepFunction

org NewSprRoutinesLong+(!SPRID*3) ; New Long Sprite Pointer
dl <SprMain>

org NewSprPrepRoutinesLong+(!SPRID*3) ; New Long Sprite Pointer
dl <SprPrep>
pullpc ; Get back the writing position for the sprite

endmacro

; Go to the action specified ID can be Hex or Decimal
macro GotoAction(action)
    LDA.b #<action> : STA.w SprAction, X
endmacro


; Increase the sprite frame every (frames_wait) frames
; reset to (frame_start) when reaching (frame_end)
; This is using SprTimerB
macro PlayAnimation(frame_start, frame_end, frame_wait)
    LDA.w SprTimerB, X : BNE +
        LDA.w SprFrame, X : INC : STA.w SprFrame, X : CMP.b #<frame_end>+1 : BCC .noframereset
        LDA.b #<frame_start> : STA.w SprFrame, X
        .noframereset
        LDA.b #<frame_wait> : STA.w SprTimerB, X
    +
endmacro


; Show message if the player is facing toward sprite and pressing A
; Return Carry Set if message is displayed
; can use BCC .label <> .label to see if message have been displayed
macro ShowSolicitedMessage(message_id)
    LDY.b #(<message_id>)>>8
    LDA.b #<message_id>
    JSL Sprite_ShowSolicitedMessageIfPlayerFacing
endmacro

; Show message no matter what (should not be used without code condition)
macro ShowUnconditionalMessage(message_id)
    LDY.b #(<message_id>)>>8
    LDA.b #<message_id>
    JSL Sprite_ShowMessageUnconditional
endmacro

; Make the sprite move towards the player at a speed of (speed)
macro MoveTowardPlayer(speed)
    LDA.b #<speed>
    JSL Sprite_ApplySpeedTowardsPlayer
    JSL Sprite_MoveLong
endmacro

; Prevent the player from passing through sprite hitbox
macro PlayerCantPassThrough()
    JSL Sprite_PlayerCantPassThrough
endmacro

; Do damage to player on contact if sprite is on same layer as player
macro DoDamageToPlayerSameLayerOnContact()
    JSL Sprite_CheckDamageToPlayerSameLayer
endmacro

; Set harmless flag, 0 = harmful, 1 = harmless
macro SetHarmless(value)
    LDA.w SprNbrOAM, X
    AND #$7F
    if <value> != 0
        ORA.b #(<value>)<<7 
    endif
    STA.w SprNbrOAM, X
endmacro

; Set Room Flag (Chest 6) 
; Do not use if you have more than 5 chests or a small key under a pot
; in that room unless you want it to be already opened/taken
macro SetRoomFlag(value)
    if <value> != 0
    LDA $0403 : ORA #$20 : STA $0403
    else
    LDA $0403 : AND #$DF : STA $0403
    endif
endmacro

; Will prevent the player from moving or opening his menu
macro PreventPlayerMovement()
LDA #$01 : STA $02E4
endmacro

; Will allow the player to move or open his menu
macro AllowPlayerMovement()
STZ.w $02E4
endmacro

; Enter 16bit mode
macro Set16bitmode()
REP #$30
endmacro

; Enter 8bit mode
macro Set8bitmode()
SEP #$30
endmacro

; This is a 16 bit will load A with current rupee count
; to use with instructions CMP and BCC/BCS
macro GetPlayerRupees()
LDA $7EF360
endmacro

; Set the velocity Y of the sprite at (speed) value
; this require the use of the function JSL Sprite_MoveLong
macro SetSpriteSpeedY(speed)
LDA.b #<speed> : STA.w SprYSpeed, x
endmacro

; Set the velocity X of the sprite at (speed) value
; this require the use of the function JSL Sprite_MoveLong
macro SetSpriteSpeedX(speed)
LDA.b #<speed> : STA.w SprXSpeed, x
endmacro

; Will play a sound SFX 1 See Zelda_3_RAM.log for more informations
macro PlaySFX1(sfxid)
LDA.b #<sfxid> : STA $012E
endmacro

; Will play a sound SFX 2 See Zelda_3_RAM.log for more informations
macro PlaySFX2(sfxid)
LDA.b #<sfxid> : STA $012F
endmacro

; Will play a music See Zelda_3_RAM.log for more informations
macro PlayMusic(musicid)
LDA.b #<musicid> : STA $012C
endmacro

; Will set the timer A to wait (length) amount of frames
macro SetTimerA(length)
LDA.b #<length> : STA.w SprTimerA, X
endmacro

; Will set the timer B to wait (length) amount of frames
macro SetTimerB(length)
LDA.b #<length> : STA.w SprTimerB, X
endmacro

; Will set the timer C to wait (length) amount of frames
macro SetTimerC(length)
LDA.b #<length> : STA.w SprTimerC, X
endmacro

; Will set the timer D to wait (length) amount of frames
macro SetTimerD(length)
LDA.b #<length> : STA.w SprTimerD, X
endmacro

; Will set the timer E to wait (length) amount of frames
macro SetTimerE(length)
LDA.b #<length> : STA.w SprTimerE, X
endmacro

; Will set the timer F to wait (length) amount of frames
macro SetTimerF(length)
LDA.b #<length> : STA.w SprTimerF, X
endmacro