; ==============================================================================

pushpc

; Disables the master sword beam.
org $079C9A
    JSL SwordBeamAdded
    NOP #02

pullpc

; ==============================================================================

SwordBeamAdded:
{
    LDA.l $7EF281 : AND #$40 : BEQ .noBeam
        LDY.b #$00
        JSL $0FF67B ; AncillaAdd_SwordBeam

    .noBeam

    RTL
}

; ==============================================================================