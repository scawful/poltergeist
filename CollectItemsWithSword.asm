; ==============================================================================
; COLLECT ITEMS WITH SWORD
; By Con
; ==============================================================================
; Non-Expanded Space
; ==============================================================================

pushpc

org $86F725
    JSL collectSword

pullpc

; ==============================================================================
; Expanded Space
; ==============================================================================

CollectSword:
{
    ADC.b #$00 : STA.b $09

    LDA.b $79 : BEQ +
        RTL
    +

    LDA.w $0E20, X : CMP.b #$AC : BEQ .apples ; Collect Apples

    LDA.w $0E20, X : SEC : SBC.b #$D8 : BCS + ; Collect items with Sprite IDs greater than D8
        RTL
    +

    LDA.w $0E20, X : SEC : SBC.b #$E7 : BCC + ; Collect items with Sprite IDs less than E7
        RTL
    +

    .apples

    PHY

    LDY.b $3C : BPL +
        PLY
        RTL
    +

    LDA.w $F571, Y : BEQ +
        PLY
        RTL
    +

    PHX

    LDA.b $2F
    ASL A : ASL A : ASL A
    CLC : ADC.b $3C
    TAX

    INX
    LDY.b #$00
    LDA.b $45 : CLC : ADC.w $F46D, X : BPL +
        DEY
    +

    CLC : ADC.b $22 : STA.b $00

    TYA
    ADC.b $23 : STA.b $08

    LDY.b #$00
    LDA.b $44 : CLC : ADC.w $F4EF, X : BPL +
        DEY
    +

    CLC : ADC.b $20 : STA.b $01

    TYA
    ADC.b $21 : STA.b $09

    LDA.w $F4AE, X : STA.b $02
    LDA.w $F530, X : STA.b $03

    PLX
    PLY
    RTL
}

; ==============================================================================
