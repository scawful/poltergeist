; ==============================================================================

pushpc

; Hook for glowing palettes here
org $01CC08 ; Replace hole(3) and hole(4) tag DO NOT USE hole(4) use hole(3)
    LDA.l $7EC1A1 : DEC : STA.l $7EC1A1 : BPL .wait
        LDA #$06 : STA.l $7EC1A1
        LDA.l $7EC1A0 : BNE .DoPalMax
            JSL GlowingPaletteMax
            RTS

        .DoPalMax

        JSL GlowingPaletteMin

    .wait

    RTS

pullpc

; ==============================================================================

GlowingPaletteMax:
{
    ; for each colors in palette 
    REP #$30
    LDX #$0008 ; Numbers of colors in the palette
    LDY #$0004 ; C0 / 2

    ; Load the current color check if value match the target we're trying to reach either PalMin or PalMax
    .LoopAllColors

        LDA.l $7EC5E8, X : BEQ .colorAlreadyAtGoalDEY ; Color is $0000 no need to change
        CMP.l PalMax, X : BEQ .colorAlreadyAtGoalDEY
            STA.b $00
            AND.w #$001F : STA.b $02
            LDA.b $00 : AND.w #$03E0 : STA $04
            LDA.b $00 : AND.w #$7C00 : STA $06

            LDA.l PalMax, X : STA $08

            AND.w #$001F : CMP $02 : BEQ .RedIsSame ; Is RED the same as goal?
                BCC .GoalRedIsLowerThanCurrent
                    ; Red is lower than goal here so INC here
                    INC $02
                    BRA .RedIsSame

                .GoalRedIsLowerThanCurrent

                ; Red is higher than goal here so DEC here
                DEC $02

            .RedIsSame

            LDA.b $08
            AND.w #$03E0 : CMP $04 : BEQ .GreenIsSame
                BCC .GoalGreenIsLowerThanCurrent
                    ; Green is lower than goal here so INC here
                    LDA.b $04 : CLC : ADC.w #$0020 : STA $04
                    BRA .GreenIsSame

                .GoalGreenIsLowerThanCurrent

                ; Green is higher than goal here so DEC here
                LDA.b $04 : SEC : SBC.w #$0020 : STA $04

            .GreenIsSame

            LDA.b $08 : AND.w #$7C00 : CMP $06 : BEQ .BlueIsSame
                BCC .GoalBlueIsLowerThanCurrent
                    ; Blue is lower than goal here so INC here
                    LDA.b $06 : CLC : ADC.w #$0400 : STA $06
                    BRA .BlueIsSame

                .GoalBlueIsLowerThanCurrent

                ; Blue is higher than goal here so DEC here
                LDA.b $06 : SEC : SBC.w #$0400 : STA $06

            .BlueIsSame

            BRA .endcolors

            .colorAlreadyAtGoal
            DEX : DEX

    BPL .LoopAllColors

    INC.b $15
    SEP #$30

    RTL

    .colorAlreadyAtGoalDEY

    DEY : CPY #$0001 : BCC .reverseColor
        BRA .colorAlreadyAtGoal

    .reverseColor

    SEP #$30
    LDA.l $7EC1A0 : EOR.b #$01 : STA.l $7EC1A0

    RTL

    ; $00 = Current color (faster to load from DP)
    ; $02 = R
    ; $04 = G
    ; $06 = B
    ; $08 = goal color
    .endcolors
    LDA.w #$0000 : ORA.b $02 : ORA.b $04 : ORA.b $06
    STA.l $7EC5E8, X
    BRA .colorAlreadyAtGoal
}

GlowingPaletteMin:
{
    ; for each colors in palette 
    REP #$30
    LDX #$0008 ; Numbers of colors in the palette
    LDY #$0004 ; C0 / 2

    ; Load the current color check if value match the target we're trying to reach either PalMin or PalMax
    .LoopAllColors
        LDA.l $7EC5E8, X : BEQ .colorAlreadyAtGoalDEY ; Color is $0000 no need to change
        CMP.l PalMin, X : BEQ .colorAlreadyAtGoalDEY
            STA.b $00
            AND.w #$001F : STA.b $02
            LDA.b $00 : AND.w #$03E0 : STA $04
            LDA.b $00 : AND.w #$7C00 : STA $06

            LDA.l PalMin, X : STA $08

            AND.w #$001F : CMP $02 : BEQ .RedIsSame ; Is RED the same as goal?
                BCC .GoalRedIsLowerThanCurrent
                    ; Red is lower than goal here so INC here
                    INC $02
                    BRA .RedIsSame

                .GoalRedIsLowerThanCurrent

                ; Red is higher than goal here so DEC here
                DEC $02

            .RedIsSame

            LDA.b $08 : AND.w #$03E0 : CMP $04 : BEQ .GreenIsSame
                BCC .GoalGreenIsLowerThanCurrent
                    ; Green is lower than goal here so INC here
                    LDA.b $04 : CLC : ADC.w #$0020 : STA $04
                    BRA .GreenIsSame

                .GoalGreenIsLowerThanCurrent

                ; Green is higher than goal here so DEC here
                LDA.b $04 : SEC : SBC.w #$0020 : STA $04

            .GreenIsSame

            LDA.b $08
            AND.w #$7C00 : CMP $06 : BEQ .BlueIsSame
                BCC .GoalBlueIsLowerThanCurrent
                    ; Blue is lower than goal here so INC here
                    LDA.b $06 : CLC : ADC.w #$0400 : STA $06
                    BRA .BlueIsSame

                .GoalBlueIsLowerThanCurrent
                ; Blue is higher than goal here so DEC here
                LDA.b $06 : SEC : SBC.w #$0400 : STA $06

            .BlueIsSame

            BRA .endcolors

        .colorAlreadyAtGoal
        DEX : DEX
    BPL .LoopAllColors

    INC.b $15
    SEP #$30
    RTL

    .colorAlreadyAtGoalDEY

    DEY : CPY #$0001 : BCC .reverseColor
        BRA .colorAlreadyAtGoal

    .reverseColor

    SEP #$30
    LDA.l $7EC1A0 : EOR.b #$01 : STA.l $7EC1A0

    RTL

    ; $00 = Current color (faster to load from DP)
    ; $02 = R
    ; $04 = G
    ; $06 = B
    ; $08 = goal color
    .endcolors
    LDA.w #$0000 : ORA.b $02 : ORA.b $04 : ORA.b $06
    STA.l $7EC5E8, X
    BRA .colorAlreadyAtGoal
}

    PalMin:
    dw $0060, $0900, $0980, $0E27

    PalMax:
    dw $0100, $2220, $26E0, $0663

; ==============================================================================