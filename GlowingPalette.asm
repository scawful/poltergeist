; ==============================================================================

pushpc

; Hook for glowing palettes here
org $01CC08 ; Replace hole(3) and hole(4) tag DO NOT USE hole(4) use hole(3)
    LDA.l $7EC1A1 : DEC : STA.l $7EC1A1 : BPL .wait
        LDA #$08 : STA.l $7EC1A1
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
    ; for each colors in palette 
    REP #$30
    LDX #$00C0 ; Numbers of colors in the palette
    LDY #$0060 ; C0 / 2
    ; Load the current color check if value match the target we're trying to reach either PalMin or PalMax
    .LoopAllColors
    LDA.l $7EC540, X : BEQ .colorAlreadyAtGoalDEY ; Color is $0000 no need to change
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
    STA.l $7EC540, X
    BRA .colorAlreadyAtGoal


    GlowingPaletteMin:
    ; for each colors in palette 
    REP #$30
    LDX #$00C0 ; Numbers of colors in the palette
    LDY #$0060 ; C0 / 2
    ; Load the current color check if value match the target we're trying to reach either PalMin or PalMax
    .LoopAllColors
    LDA.l $7EC540, X : BEQ .colorAlreadyAtGoalDEY ; Color is $0000 no need to change
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
    STA.l $7EC540, X
    BRA .colorAlreadyAtGoal

    PalMin:
    dw $0000, $0862, $0041, $0062, $04A3, $08E5, $0483, $0482, $7FFF, $0862, $0062, $0482, $04A4, $0906, $4209, $3187
    dw $0000, $0C63, $18C6, $294A, $3DEF, $1088, $0D6C, $14EA, $7FFF, $1085, $0482, $0482, $04C4, $04A2, $04A3, $04A2
    dw $0000, $7FFF, $3673, $3718, $37BD, $14A5, $3529, $35CE, $7FFF, $1085, $1088, $10A9, $14CB, $1086, $192C, $10C8
    dw $0000, $1463, $1508, $196B, $3252, $5318, $190C, $18EB, $7FFF, $1085, $0482, $04A3, $08C4, $0905, $0CE5, $0CE6
    dw $0000, $18C6, $2D6B, $5294, $6B5A, $4108, $1ABA, $61AD, $7FFF, $0C63, $110D, $1D91, $2E35, $212D, $5294, $739C
    dw $0000, $14A5, $0C72, $109C, $11FF, $4D27, $61EC, $7E4E, $7FFF, $0862, $0442, $0000, $19CE, $35A5, $1085, $1085

    dw $0000, $0862, $0041, $0062, $04A3, $08E5, $0483, $0482, $7FFF, $0862, $0062, $0482, $04A4, $0906, $4209, $3187
    dw $0000, $18C6, $2D6B, $5294, $77BD, $252F, $1ABA, $29F5, $7FFF, $1085, $0482, $0482, $04C4, $04A2, $04A3, $04A2
    dw $0000, $7FFF, $3673, $3718, $37BD, $14A5, $3529, $35CE, $7FFF, $1085, $1088, $10A9, $14CB, $1086, $192C, $10C8
    dw $0000, $1463, $1508, $196B, $3252, $5318, $190C, $18EB, $7FFF, $1085, $0482, $04A3, $08C4, $0905, $0CE5, $0CE6
    dw $0000, $18C6, $2D6B, $5294, $6B5A, $4108, $1ABA, $61AD, $7FFF, $0C63, $110D, $1D91, $2E35, $212D, $5294, $739C
    dw $0000, $14A5, $0C72, $109C, $11FF, $4D27, $61EC, $7E4E, $7FFF, $0862, $0442, $0000, $19CE, $35A5, $1085, $1085


    PalMax:
    dw $0000, $1085, $0187, $024B, $02EC, $03F3, $06CE, $026B, $7FFF, $1085, $0187, $024A, $02F1, $03F3, $4209, $3187
    dw $0000, $18C6, $2D6B, $5294, $77BD, $252F, $1ABA, $29F5, $7FFF, $1085, $01A5, $0208, $02AB, $0165, $02AB, $020A
    dw $0000, $7FFF, $3673, $3718, $37BD, $14A5, $3529, $35CE, $7FFF, $1085, $1088, $10A9, $14CB, $1086, $192C, $10C8
    dw $0000, $1463, $1508, $196B, $3252, $5318, $190C, $18EB, $7FFF, $1085, $01A7, $0208, $06AC, $076F, $27D4, $63FD
    dw $0000, $18C6, $2D6B, $5294, $6B5A, $4108, $1ABA, $61AD, $7FFF, $0C63, $110D, $1D91, $2E35, $212D, $5294, $739C
    dw $0000, $14A5, $0C72, $109C, $11FF, $4D27, $61EC, $7E4E, $7FFF, $1085, $01A7, $0000, $19CE, $35A5, $1085, $1085

; ==============================================================================