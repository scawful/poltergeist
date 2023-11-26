; ==============================================================================

pushpc

org $07A91A
    NOP #04 ; remove the extra Y button check

org $07A923 ; LDA $7EF3CC : CMP.b #$0A : BNE BRANCH_ALPHA
    JSL NewMirrorCode
    BCS warp ; if carry was set warp
        RTS ; otherwise end the mirror code !

org $07A93C
    warp:

pullpc

; ==============================================================================

NewMirrorCode:
{
    LDA $1B : BEQ .outside
        ; If we arn't in a dungeon, don't warp.
        LDA $040C : CMP.b #$FF : BEQ .dontWarp
            ; warp
            SEC

            RTL

    .outside

    STZ.b $3A
    REP #$20
    LDA.b $20 : CMP.w #$0910 : BCC .toohigh
        CMP.w #$0976 : BCS .toolow
            LDA.b $22 : CMP.w #$00A0 : BCC .tooleft
                CMP.w #$00FE : BCS .tooright
                    SEP #$21 ; use that to set carry at same time
                    RTL
                
                .tooright
            .tooleft
        .toolow
    .toohigh

    SEP #$20 ; use that to clear carry at same time

    .dontWarp
    CLC
    
    RTL
}

; ==============================================================================