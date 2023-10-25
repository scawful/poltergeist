; ==============================================================================

pushpc

org $0FFD86
    STZ.w $1CDB ; set count to 00
    STZ.w $1CF3 ; set numeric to 00
    RTL

org $1DFD18 ; New digging game dude
    JML NewDiggingDude
    NOP #$03

    DiggingReturn:
    RTS

    DiggingTimerDone:

org $0696DE ; new Poe Sprite (subtype)
    JSL NewPoe
    NOP #$02

org $1DFE4B
    JML DustSpriteDraw ; LDA.b #$03 : STA $06
    returnDraw:

org $1DFE6D
    returnRTS:

org $07A479 ; book of mudora
    JSL Vacuum
    RTS

; ==============================================================================

 ; New Item Use ( Vacuum )
pullpc
Vacuum:
{
    LDY.b #$0F

    --

        LDA.b #$00 
        STA $0E40, Y 
    DEY : BPL --

    STZ.w $037A
    STZ.w $0B7B

    LDA.b $F0 : AND.b #$40 : BEQ .YNotPressed
        STZ.b $26
        STZ.b $68
        STZ.b $69
        STZ.b $6A
        ; put link into state 04 for item use (hookshot handle)
        LDA.b #$04 : STA.w $037A
        STA.w $0B7B
        ; Make some dust particles appears randomly in front of link and move towards link
        ; Use sprites because they're easier to work with 

        DEC.w $045F : BPL + ; Timer (If timer < 0)
            LDA.b #$08 : STA.w $045F ; set timer back to 08
            LDA.w $045E : CMP.b #$06 : BCS + ; if there is more than 6 dust sprite
                INC.w $045E
                LDA.b #$D5
                JSL Sprite_SpawnDynamically ; never more than 6 at once
                ;$00 low x, $01 high x
                ;$02 low y, $03 high y

                LDA.b #$02 : STA.w $0E30, Y ; subtype
                LDA.b #$14 : STA.w $0E00, Y ; timer
                LDA.b #$03 : STA.w $0E10, Y ; animtimer

                LDA.b $2F : BNE .notUp
                    JSR vacuumup
                    BRA ++

                .notUp

                CMP #$02 : BNE .notDown
                    JSR vacuumdown
                    BRA ++

                .notDown

                CMP #$04 : BNE .notLeft
                    JSR vacuumleft
                    BRA ++

                .notLeft

                CMP #$06 : BNE .notRight
                    JSR vacuumright
                .notRight

                ++

    ; gotta spawn it with an offset depending on direction
    .YNotPressed
    +

    RTL
}

; ==============================================================================

vacuumup:
{
    REP #$20
    LDA.b $20 : SEC : SBC #$0020 : STA $00
    JSL GetRandomInt : AND.w #$0007 : STA.b $02
    LDA.b $22 : SEC : SBC #$0004 : CLC : ADC.b $02 : STA.b $02
    SEP #$20

    LDA.b $00 : STA.w $0D00, Y
    LDA.b $01 : STA.w $0D20, Y

    LDA.b $02 : STA.w $0D10, Y
    LDA.b $03 : STA.w $0D30, Y

    ; Check if there's a ghost in front of link if so suck it in
    ; check all sprites
    LDY.b #$0F

    --
        LDA.w $0E20, Y : CMP #$19 : BNE .notAPoe
            LDA.w $0DD0, Y : CMP #$09 : BNE .spriteIsDead
                ; sprite is a poe and is not dead check if it's colliding
                LDA.w $0D00, Y : STA $04 ; Y
                LDA.w $0D20, Y : STA $05

                LDA.w $0D10, Y : STA $06 ; X
                LDA.w $0D30, Y : STA $07

                REP #$20
                LDA $20 ; Load player.Y position
                CMP $04 : BCC .yishigher ; is it higher than sprite.Y
                    SEC : SBC #$0040 : CMP $04 : BCS .yislower
                        LDA $22 : SEC : SBC #$0008 : CMP $06 : BCS .xislower
                            LDA $22 : CLC : ADC #$0018 : CMP $06 : BCC .xishigher

                            ; Collision happened here
                            SEP #$20
                            JSR CaptureGhost

                            .xishigher
                        .xislower
                    .yislower ; if link.Y was lower than Y+0x30 then no collision
                .yishigher ; if link.Y was bigger then no collision
                
                SEP #$20

            .spriteIsDead
        .notAPoe
    DEY : BPL --

    RTS
}

; ==============================================================================

vacuumdown:
{
    REP #$20
    LDA.b $20 : CLC : ADC #$0020 : STA $00
    JSL GetRandomInt : AND.w #$0007 : STA.b $02
    LDA.b $22 : SEC : SBC #$0004 : CLC : ADC.b $02 : STA.b $02
    SEP #$20
    LDA.b $00 : STA.w $0D00, Y
    LDA.b $01 : STA.w $0D20, Y

    LDA.b $02 : STA.w $0D10, Y
    LDA.b $03 : STA.w $0D30, Y

    ; Check if there's a ghost in front of link if so suck it in
    ; check all sprites
    LDY.b #$0F
    --
    LDA.w $0E20, Y : CMP #$19 : BNE .notAPoe
    LDA.w $0DD0, Y : CMP #$09 : BNE .spriteIsDead
    ; sprite is a poe and is not dead check if it's colliding
    LDA.w $0D00, Y : STA $04 ; Y
    LDA.w $0D20, Y : STA $05

    LDA.w $0D10, Y : STA $06 ; X
    LDA.w $0D30, Y : STA $07

    REP #$20
    LDA $20 ; Load player.Y position
    CMP $04
    BCS .yishigher ; is it higher than sprite.Y
    CLC : ADC #$0050 : CMP $04 : BCC .yislower
        LDA $22 : SEC : SBC #$0008 : CMP $06 : BCS .xislower
            LDA $22 : CLC : ADC #$0018 : CMP $06 : BCC .xishigher

            ; Collision happened here
            SEP #$20
            JSR CaptureGhost

    .xislower
    .xishigher
    .yishigher ; if link.Y was bigger then no collision
    .yislower ; if link.Y was lower than Y+0x30 then no collision

    SEP #$20


    .spriteIsDead
    .notAPoe
    DEY : BPL --

    RTS
    vacuumleft:
    REP #$20
    LDA.b $22 : SEC : SBC #$0020 : STA $00
    JSL GetRandomInt : AND.w #$0007 : CLC : ADC #$0004 : STA.b $02
    LDA.b $20 : CLC : ADC.b $02 : STA.b $02
    SEP #$20

    LDA.b $02 : STA.w $0D00, Y
    LDA.b $03 : STA.w $0D20, Y

    LDA.b $00 : STA.w $0D10, Y
    LDA.b $01 : STA.w $0D30, Y

    LDA.b #$08 : STA.w $0D50, X



    ; Check if there's a ghost in front of link if so suck it in
    ; check all sprites
    LDY.b #$0F
    --
    LDA.w $0E20, Y : CMP #$19 : BNE .notAPoe
    LDA.w $0DD0, Y : CMP #$09 : BNE .spriteIsDead
    ; sprite is a poe and is not dead check if it's colliding
    LDA.w $0D00, Y : STA $04 ; Y
    LDA.w $0D20, Y : STA $05

    LDA.w $0D10, Y : STA $06 ; X
    LDA.w $0D30, Y : STA $07

    REP #$20
    LDA $22 ; Load player.Y position
    CMP $06
    BCC .yishigher ; is it higher than sprite.Y
    SEC : SBC #$0040 : CMP $06 : BCS .yislower
        LDA $20 : SEC : SBC #$0008 : CMP $04 : BCS .xislower
            LDA $20 : CLC : ADC #$0018 : CMP $04 : BCC .xishigher

            ; Collision happened here
            SEP #$20
            JSR CaptureGhost

    .xislower
    .xishigher
    .yishigher ; if link.Y was bigger then no collision
    .yislower ; if link.Y was lower than Y+0x30 then no collision

    SEP #$20

    .spriteIsDead
    .notAPoe
    DEY : BPL --

    RTS
}

; ==============================================================================

vacuumright:
{
    REP #$20
    LDA.b $22 : CLC : ADC #$0020 : STA $00
    JSL GetRandomInt : AND.w #$0007 : CLC : ADC #$0004 : STA.b $02
    LDA.b $20 : CLC : ADC.b $02 : STA.b $02
    SEP #$20
    LDA.b $02 : STA.w $0D00, Y
    LDA.b $03 : STA.w $0D20, Y

    LDA.b $00 : STA.w $0D10, Y
    LDA.b $01 : STA.w $0D30, Y

    LDA.b #$08 : STA.w $0D50, X



    ; Check if there's a ghost in front of link if so suck it in
    ; check all sprites
    LDY.b #$0F
    --
    LDA.w $0E20, Y : CMP #$19 : BNE .notAPoe
    LDA.w $0DD0, Y : CMP #$09 : BNE .spriteIsDead
    ; sprite is a poe and is not dead check if it's colliding
    LDA.w $0D00, Y : STA $04 ; Y
    LDA.w $0D20, Y : STA $05

    LDA.w $0D10, Y : STA $06 ; X
    LDA.w $0D30, Y : STA $07

    REP #$20
    LDA $22 ; Load player.Y position
    CMP $06
    BCS .yishigher ; is it higher than sprite.Y
    CLC : ADC #$0050 : CMP $06 : BCC .yislower
        LDA $20 : SEC : SBC #$0008 : CMP $04 : BCS .xislower
            LDA $20 : CLC : ADC #$0018 : CMP $04 : BCC .xishigher

            ; Collision happened here
            SEP #$20
            JSR CaptureGhost

    .xislower
    .xishigher
    .yishigher ; if link.Y was bigger then no collision
    .yislower ; if link.Y was lower than Y+0x30 then no collision

    SEP #$20


    .spriteIsDead
    .notAPoe
    DEY : BPL --

    RTS
}


CaptureGhost:
{
    LDA.b #$18 : STA.w $0E10, Y ; reset timer
    LDA.w $0DA0, Y : INC : STA.w $0DA0, Y : CMP.b #$08 : BCC .notCaptured
        LDA.b #$06 : STA.w $0DD0, Y ; kill it for test code
        LDA.b #$0F : STA.w $0DF0, Y
        DEC.w $1CDB
        INC $1CF3 ; Increase the count of ghost captured
        LDA $1CF3
        AND #$0F : CMP #$0A : BNE + ; have we reached 10? if so increase next nybble and set it back to 0
            LDA.w $1CF3 : AND #$F0 : CLC : ADC #$10 : STA.w $1CF3
        +

    .notCaptured
    RTS
}


DustSpriteDraw:
{
    LDA $0E30, X
    CMP #$02 : BNE +++

    PHB : PHK : PLB

    JSR Sprite_Dust_Draw
    LDA $0E10, X : BNE +
    LDA.b #$03 : STA.w $0E10, X
    INC.w $0DC0, X
    +


    LDA.b $2F : BNE .notUp
    LDA.b #$12 : STA.w $0D40, X
    BRA ++
    .notUp
    CMP #$02 : BNE .notDown
    LDA.b #$EE : STA.w $0D40, X
    BRA ++
    .notDown

    CMP #$04 : BNE .notLeft
    LDA.b #$12 : STA.w $0D50, X
    BRA ++
    .notLeft
    CMP #$06 : BNE .notRight
    LDA.b #$EE : STA.w $0D50, X
    .notRight
    ++


    JSL Sprite_MoveLong


    LDA.w $0E00, X : BNE +
    STZ.w $0DD0, X
    DEC.w $045E
    +

    PLB

    ; pop an RTS
    PLA : PLA ; to end draw code

    JML returnRTS ; to end sprite code


    +++
    LDA.b #$03 : STA $06
    JML returnDraw
}

;==================================================================================================
; Sprite Draw code
; --------------------------------------------------------------------------------------------------
; Draw the tiles on screen with the data provided by the sprite maker editor
;==================================================================================================
Sprite_Dust_Draw:
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


;==================================================================================================
; Sprite Draw Generated Data
; --------------------------------------------------------------------------------------------------
; This is where the generated Data for the sprite go
;==================================================================================================
.start_index
db $00, $01, $02, $03, $04, $05, $06, $07
.nbr_of_tiles
db 0, 0, 0, 0, 0, 0, 0, 0
.x_offsets
dw 0
dw 0
dw 0
dw 0
dw 4
dw 4
dw 4
dw 4
.y_offsets
dw 0
dw 0
dw 0
dw 0
dw 2
dw 4
dw 4
dw 4
.chr
db $86
db $86
db $86
db $86
db $8A
db $8B
db $9B
db $50
.properties
db $34
db $74
db $B4
db $F4
db $34
db $34
db $34
db $34
.sizes
db $02
db $02
db $02
db $02
db $00
db $00
db $00
db $00


NewPoe:
{
    LDA.w $0E30, X : CMP #$02 : BNE ++
    ; otherwise do not check for damage just float around waiting to be captured

    LDA.w $0E10, X : BNE +
    ; if timer was equal 0 at some point set back ghost to normal state
    STZ.w $0DA0, X ; will set back ghost to moving state
    +

    LDA.w $0DA0, X : BEQ + 
        ; if it's not equal then ghost is being captured
        ; he's getting attracted to player
        LDA #$08
        JSL Sprite_ApplySpeedTowardsPlayer

    +

    INC.w $0E80, X
    RTL
    ++
    ;restore original code kinda
    JSL Sprite_CheckDamageFromPlayer
    JSL Sprite_CheckDamageToPlayer

    INC.w $0E80, X

    RTL

    NewDiggingDude:

    LDA $04B4 : BEQ .timer_elapsed
                BMI .timer_elapsed


    LDA $1CDB : CMP #$03 : BCS +
    INC.w $1CDB
        LDA #$19
        JSL Sprite_SpawnDynamically
        LDA.b #$02 : STA.w $0E30, Y
        LDA #$0A : STA.w $0D20, Y
        JSL GetRandomInt : AND #$7F : CLC : ADC #$88 : STA $0D00, Y
        REP #$20
        JSL GetRandomInt : AND #$007F : CLC : ADC #$0088 : STA $00
        SEP #$20
        LDA $00 : STA $0D10, Y
        LDA $01 : STA $0D30, Y

    +

    JML DiggingReturn

    .timer_elapsed
    JML DiggingTimerDone
}