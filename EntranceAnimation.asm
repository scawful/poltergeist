; ==============================================================================

pushpc

org $1BC97C
    Overworld_DrawPersistentMap16:

org $1BCE16
    dw EntranceOpening1
    dw EntranceOpening2
    dw EntranceOpening3
    dw EntranceOpening4
    dw EntranceOpening5

; ==============================================================================

org $1BCE48
EntranceOpening1:
{
    LDA $7EF298 : ORA #$20 : STA $7EF298
    INC $B0
    LDA #$40 : STA $C8 ; Timer wait C0 frames before doing anything!

    RTS
}

; ==============================================================================

EntranceOpening2:
{
    DEC $C8 : BNE +
        REP #$30

        LDX.w #$0310 ; top left
        LDA.w #$0548 ; Tile ID
        JSL Overworld_DrawPersistentMap16

        LDX.w #$0312 ; top right
        LDA.w #$0549 ; Tile ID
        JSL Overworld_DrawPersistentMap16

        LDX.w #$390 ; bottom left
        LDA.w #$054A ; Tile ID
        JSL Overworld_DrawPersistentMap16

        LDX.w #$392 ; bottom right
        LDA.w #$054B ; Tile ID
        JSL Overworld_DrawPersistentMap16

        SEP #$30

        JSL PlayThudSound

        LDA #$40 : STA $C8 ; Timer wait 40 frames before playing jingle and end the animation
        INC $B0 ; State of bombosentrance animation

    +

    RTS
}

; ==============================================================================

EntranceOpening3:
{
    DEC $C8 : BNE +
        REP #$30

        LDX.w #$0310 ; top left
        LDA.w #$0548 ; Tile ID
        JSL Overworld_DrawPersistentMap16

        LDX.w #$0312 ; top right
        LDA.w #$0549 ; Tile ID
        JSL Overworld_DrawPersistentMap16

        LDX.w #$390 ; bottom left
        LDA.w #$0545 ; Tile ID
        JSL Overworld_DrawPersistentMap16

        LDX.w #$392 ; bottom right
        LDA.w #$0546 ; Tile ID
        JSL Overworld_DrawPersistentMap16
        SEP #$30
        INC $B0

        JSL PlayThudSound
        LDA #$40 : STA $C8 ; Timer wait 40 frames before playing jingle and end the animation

    +

    RTS
}

; ==============================================================================

EntranceOpening4:
{
    DEC $C8 : BNE +
        REP #$30

        LDX.w #$0310 ; top left
        LDA.w #$0552 ; Tile ID
        JSL Overworld_DrawPersistentMap16

        LDX.w #$0312 ; top right
        LDA.w #$053A ; Tile ID
        JSL Overworld_DrawPersistentMap16

        LDX.w #$390 ; bottom left
        LDA.w #$02A9 ; Tile ID
        JSL Overworld_DrawPersistentMap16

        LDX.w #$392 ; bottom right
        LDA.w #$02AA ; Tile ID
        JSL Overworld_DrawPersistentMap16

        SEP #$30
        INC $B0
        JSL PlayThudSound
        LDA #$40 : STA $C8 ; Timer wait 40 frames before playing jingle and end the animation

    +

    RTS
}

; ==============================================================================

EntranceOpening5:
{
    DEC $C8 : BNE +
        REP #$30

        LDX.w #$0310 ; top left
        LDA.w #$0744 ; Tile ID
        JSL Overworld_DrawPersistentMap16

        LDX.w #$0312 ; top right
        LDA.w #$0745 ; Tile ID
        JSL Overworld_DrawPersistentMap16

        LDX.w #$390 ; bottom left
        LDA.w #$02A9 ; Tile ID
        JSL Overworld_DrawPersistentMap16

        LDX.w #$392 ; bottom right
        LDA.w #$02AA ; Tile ID
        JSL Overworld_DrawPersistentMap16

        SEP #$30

        JSL PlayThudSound

        LDA.b #$1B : STA $012F

        STZ $04C6
        STZ $B0
        STZ $0710
        STZ $02E4

        STZ $0FC1

        STZ $011A
        STZ $011B
        STZ $011C
        STZ $011D

    +

    RTS
}

warnpc $1BCF5F

pullpc

; ==============================================================================

; Plays the thud sound.
; Yeah I know this is dumb but theres no space.
PlayThudSound:
{
    LDA.b #$01 : STA $14 ; replaced code

    LDA.b #$03 : STA $012F

    RTL
}

; ==============================================================================