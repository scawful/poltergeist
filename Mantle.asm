; ==============================================================================

pushpc

org $068841
    JSL NewMantlePrep
    RTS

org $1AFC52
    db $06 ; check for maiden instead of zelda

org $1AFCA7
    ; Tiles
    db $0C, $0E, $0C, $2C, $2E, $2C
    ; Mantle Properties : 
    db $3B, $3B, $7B, $3B, $3B, $7B

pullpc

NewMantlePrep:
{
    LDA $0D00, X : CLC : ADC.b #$07 : STA $0D00, X
    LDA $0D10, X : CLC : ADC.b #$08 : STA $0D10, X

    LDA $7EF0DA : AND #$0F : BEQ +
    LDA $0D10, X : CLC : ADC.b #$28 : STA $0D10, X
    +

    RTL
}

; ==============================================================================