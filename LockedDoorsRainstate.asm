; ==============================================================================

pushpc

org $1BBC67
    JML CheckDoorlock
    NotLocked:

org $1BBCC1
    Locked:

pullpc

CheckDoorlock:
{
    ; 16 bit
    STZ $0692

    LDA.b $20 : CMP.w #$0928 : BCC .ytoolow
    CMP.w #$09A8 : BCS .ytoohigh
        LDA.b $22 : CMP.w #$0810 : BCC .xtoolow
        CMP.w #$0880 : BCS .xtoohigh

            LDA #$0DA4
            JSL $1BC97C ; Overworld_DrawPersistentMap16
            LDA.w #$0018 : STA $0692
            JML NotLocked
    .ytoolow
    .ytoohigh
    .xtoolow
    .xtoohigh

    LDA $7EF3C5 : AND.w #$000F : BEQ .lockedDoor
        LDA #$0DA4
        JSL $1BC97C ; Overworld_DrawPersistentMap16
        LDA.w #$0018 : STA $0692
        JML NotLocked

    .lockedDoor

    JML Locked
}

; ==============================================================================