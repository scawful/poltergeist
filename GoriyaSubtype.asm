; ==============================================================================

pushpc

org $1EC700
Goriya:
{
    LDA $048E
    LDA $0E30, X : BEQ .not_goriya
        .is_goriya

        INC $0DA0, X

        LDA $0E20, X : CMP.b #$83 : BNE .not_red_goriya
            ; Disable some of the invulnerability properties.
            STZ $0CAA, X

        .not_red_goriya
    .not_goriya

    RTL
}

pullpc

; ==============================================================================