; ==============================================================================

pushpc

; $4BA56-$4BAAB LOCAL
org $09BA56
    JSL NewSpawnFlyingTile

org $1EBBF0
    JSL NewTileReplace

pullpc

; ==============================================================================

NewSpawnFlyingTile:
{
    LDA.b #$94 : JSL Sprite_SpawnDynamically : BMI .spawn_failed
        LDA.b #$01 : STA $0E90, Y

        PHX : LDA $0B28, X : TAX

        LDA $A0 : CMP #$8D : BNE +
            LDA.l TilesRoom8DX, X : STA $0D10, Y
            LDA.l TilesRoom8DY, X : SEC : SBC #$08 : STA $0D00, Y

        +
        ;LDA $A0 : CMP #$08 : BNE +

        ;+
        ;LDA $A0 : CMP #$08 : BNE +

        ;+


        ; Add more room here


        ; Default code
        LDA.l DefaultTilesX, X : STA $0D10, Y

        LDA.l DefaultTilesY, X : SEC : SBC #$08 : STA $0D00, Y

        PLX

        LDA $0B20, X : STA $0D20, Y
        LDA $0B10, X : STA $0D30, Y

        LDA $0B40, X : STA $0F20, Y

        LDA.b #$04 : STA $0E50, Y

        LDA.b #$00 : STA $0BE0, Y
                     STA $0E50, Y

        LDA.b #$08 : STA $0CAA, Y
        LDA.b #$04 : STA $0E40, Y
        LDA.b #$01 : STA $0F50, Y
        LDA.b #$04 : STA $0CD2, Y

    .spawn_failed

    RTL


    DefaultTilesX:
    db $70, $80, $60, $90, $90, $60, $70, $80
    db $80, $70, $50, $A0, $A0, $50, $50, $A0
    db $A0, $50, $70, $80, $80, $70

    DefaultTilesY:
    db $80, $80, $70, $90, $70, $90, $60, $A0
    db $60, $A0, $60, $B0, $60, $B0, $80, $90
    db $80, $90, $70, $90, $70, $90

    TilesRoom8DX:
    db $70, $80, $60, $90, $90, $60, $70, $80
    db $80, $70, $50, $A0, $A0, $50, $50, $A0
    db $A0, $50, $70, $80, $80, $70

    TilesRoom8DY:
    db $40, $40, $60, $80, $60, $90, $60, $A0
    db $60, $A0, $60, $B0, $60, $B0, $80, $90
    db $80, $90, $70, $90, $70, $90

}

; ==============================================================================

NewTileReplace:
{
    STA $03

    LDA $A0 : CMP #$8D : BNE +
        LDY #$04
        RTL

    +

    LDY #$06
    RTL
}

; ==============================================================================