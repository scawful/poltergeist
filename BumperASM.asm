; ==============================================================================

pushpc

org $1EA98F ; JSL $06F129
    JSL NewBumper

pullpc

; ==============================================================================

NewBumper:
{
    LDA.w $0E30, X : BNE .spikebumper
        JSL $06F129
        RTL

    .spikebumper

    CMP #$01 : BEQ .withcollision
        JML withoutcollision

    .withcollision

    PHB : PHK : PLB

    LDA $0EB0, X : BNE +
        LDA $0D10, X : STA $0D90, X
        LDA $0D00, X : STA $0DB0, X
        INC $0EB0, X
    +

    LDA.w $0D80, X : BNE .SpikeTrap_InMotion 
        JSL $06EAA0 ;Sprite3_DirectionToFacePlayer

        TYA : STA $0DE0, X
                
        LDA $0F : CLC : ADC.b #$10 : CMP.b #$20 : BCS .not_close_enough1
            BRA .move_towards_player
            
        .not_close_enough1

        LDA $0E : CLC : ADC.b #$10 : CMP.b #$20 : BCS .not_close_enough2
            .move_towards_player

            LDA .timers, Y : STA $0E00, X

            INC $0D80, X

            LDA .x_speeds, Y : STA $0D50, X

            LDA .y_speeds, Y : STA $0D40, X

        .not_close_enough2

        PLB
        JSL $06F129
        RTL

    .SpikeTrap_InMotion

    CMP.b #$01 : BNE .retracting
        JSL $06E496 ; Sprite3_CheckTileCollision 

        BNE .collided_with_tile
            LDA $0E00, X : BNE .moving_on

        .collided_with_tile

        INC $0D80, X

        LDA.b #$50 : STA $0E00, X

        .moving_on

        JSL $1D808C ; sprite move

        PLB
        JSL $06F129
        RTL

    .retracting

    LDA $0E00, X : BNE .delay
        LDY $0DE0, X

        LDA .retract_x_speeds, Y : STA $0D50, X

        LDA .retract_y_speeds, Y : STA $0D40, X

        JSL $1D808C ; sprite move

        LDA $0D10, X : CMP $0D90, X : BNE .delay
            LDA $0D00, X : CMP $0DB0, X : BNE .delay
                STZ $0D80, X

    .delay

    PLB
    JSL $06F129
    RTL

    .x_speeds
    db  32, -32,   0,   0

    .retract_x_speeds
    db -16,  16,   0,   0

    .y_speeds
    db   0,   0,  32, -32

    .retract_y_speeds
    db   0,   0, -16,  16

    .timers
    db $40, $40, $38, $38
}

; ==============================================================================

withoutcollision:
{
    PHB : PHK : PLB

    LDA $0EB0, X : BNE +
        LDA $0D10, X : STA $0D90, X
        LDA $0D00, X : STA $0DB0, X
        INC $0EB0, X
    +

    LDA.w $0D80, X : BNE .SpikeTrap_InMotion   
        JSL $06EAA0 ;Sprite3_DirectionToFacePlayer

        TYA : STA $0DE0, X
                
        LDA $0F : CLC : ADC.b #$10 : CMP.b #$20 : BCS .not_close_enough1
            BRA .move_towards_player
            
        .not_close_enough1

        LDA $0E : CLC : ADC.b #$10 : CMP.b #$20 : BCS .not_close_enough2
            .move_towards_player

            LDA .timers, Y : STA $0E00, X

            INC $0D80, X

            LDA .x_speeds, Y : STA $0D50, X

            LDA .y_speeds, Y : STA $0D40, X

        .not_close_enough2

        PLB
        JSL $06F129
        RTL

    .SpikeTrap_InMotion

    CMP.b #$01 : BNE .retracting
        LDA $0E00, X : BNE .moving_on
            INC $0D80, X

            LDA.b #$50 : STA $0E00, X

        .moving_on

        JSL $1D808C ; sprite move

        PLB
        JSL $06F129
        RTL

    .retracting

    LDA $0E00, X : BNE .delay
        LDY $0DE0, X

        LDA .retract_x_speeds, Y : STA $0D50, X

        LDA .retract_y_speeds, Y : STA $0D40, X

        JSL $1D808C ; sprite move

        LDA $0D10, X : CMP $0D90, X : BNE .delay
            LDA $0D00, X : CMP $0DB0, X : BNE .delay
                STZ $0D80, X

    .delay

    PLB
    JSL $06F129
    RTL

    .x_speeds
    db  40, -40,   0,   0

    .retract_x_speeds
    db -40,  40,   0,   0

    .y_speeds
    db   0,   0,  40, -40

    .retract_y_speeds
    db   0,   0, -40,  40

    .timers
    db $20, $20, $1A, $1A
}

; ==============================================================================