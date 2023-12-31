; ==============================================================================

pushpc

org $0281AB
    JSL NewDWExitLoad
    
org $09F524
    CMP #$02 ; check for gamestate 02 instead of 03
    
pullpc

; ==============================================================================

NewDWExitLoad:
{
    LDA.l $7EF367 : AND #$08 : BEQ .nobigkey
        LDA.l $7EF354 : CMP #$02 : BNE .nomitt
            LDA #$14 : STA $A0 ; respawn at the tower
            RTL

        .nomitt

        LDA #$05 : STA $A0 ; respawn at the yard
        RTL

    .nobigkey

    LDA #$04 : STA $A0 ; respawn at the warp
    RTL
}

; ==============================================================================