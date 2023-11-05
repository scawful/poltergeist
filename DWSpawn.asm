; ==============================================================================

pushpc

org $0281AB
    JSL NewDWExitLoad
    
pullpc

; ==============================================================================

NewDWExitLoad:
{
    LDA.l $7EF367 : AND #$08 : BEQ .nobigkey
        LDA.l $7EF354 : BEQ .nomitt
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