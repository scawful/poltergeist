; ==============================================================================

pushpc

; Add sparkles to all of the held up items.
org $08C5F9
    JML CheckForSparkles

org $08C613
    NoSparkle:

org $08CC93
    Ancilla_AddSwordChargeSpark:

org $08C5FD
    Ancilla_AddSwordChargeSparkLONG:
    JSR Ancilla_AddSwordChargeSpark
    RTL

; Play the crystal falling down sound and load the pendant gfx instead.
org $08CAB2
    LDA.b #$0F : STA $012D
    NOP #$0A

; Interupts the code that sets the palette for the crystals to place our own palette here.
org $08CAE0
    JSL LoadAmuletPalette
    NOP #$1B

; Add sparkles to all of the on the floor items.
org $08CAFF
    JSL CheckForSparkles2
    NOP #$07

; Link holds up the 4th amulet like the medallions and not 2 handed like the crystals.
org $0799FA
    NOP #$08

; Set the freezing link value, needs to be changed to affect things later on.
org $098602
    NOP #$09

; Change a BNE to a BRA to prevent a crystal check.
org $0986CC
    db $80

; Change what gfx link holds up when getting a crystal.
org $098424
    db $23

; Don't shift over the x position of the held up crystal.
org $0988D0
    NOP #$08

; Prevents the player from moving while the victory jingle is playing i'm pretty sure.
org $08C3EE
    JML PendantTimer
    NOP #$0B

org $08C3FD
    IsPendant:

org $08C407
    NotPendant:

; Change what message shows when you get the crystal.
org $08C31D
    dw $011C

; Trigger dungeon exit for the crystals.
org $08C500
    NOP #$05

; Change where to write the SRM. ; not needed probably
org $98528
    ;dw $F37A

; Changes what value to write to the SRM.
org $0985A0
    db #$01

function hexto555(h) = ((((h&$FF)/8)<<10)|(((h>>8&$FF)/8)<<5)|(((h>>16&$FF)/8)<<0))

pullpc

; ==============================================================================

CheckForSparkles:
{
    LDA $0C5E, X : CMP.b #$20 : BEQ .sparkle
                   CMP.b #$37 : BEQ .sparkle
                   CMP.b #$38 : BEQ .sparkle
                   CMP.b #$39 : BEQ .sparkle

    JML NoSparkle

    .sparkle

    ; Set a timer to zero.
    STZ $029E, X 
        
    JSL Ancilla_AddSwordChargeSparkLONG

    JML NoSparkle
}

; ==============================================================================

CheckForSparkles2:
{
    LDA $0C5E, X : CMP.b #$20 : BEQ .sparkle
                   CMP.b #$37 : BEQ .sparkle
                   CMP.b #$38 : BEQ .sparkle
                   CMP.b #$39 : BEQ .sparkle

    RTL

    .sparkle
        
    JSL Ancilla_AddSwordChargeSparkLONG

    RTL
}

; ==============================================================================

PendantTimer:
{
    LDA $0C5E, X : CMP.b #$20 : BEQ .isPendant
                   CMP.b #$37 : BEQ .isPendant
                   CMP.b #$38 : BEQ .isPendant
                   CMP.b #$39 : BEQ .isPendant

        JML NotPendant

    .isPendant

    JML IsPendant
}

; ==============================================================================

LoadAmuletPalette:
{
    LDA $0C5E, X : CMP.b #$20 : BEQ .crystalPalette
                   CMP.b #$37 : BEQ .pendantPalette
                   CMP.b #$38 : BEQ .pendantPalette
                   CMP.b #$39 : BEQ .pendantPalette
        RTL

    .crystalPalette

    LDA.b #$01 : STA $039F, X

    .pendantPalette

    REP #$20

    ; Pendant 1 green -> orange.
    LDA.w #hexto555($D58200) : STA $7EC696
    LDA.w #hexto555($FFB345) : STA $7EC698

    LDA.w #hexto555($E8E8E8) : STA $7EC69C
    LDA.w #hexto555($A9A9A9) : STA $7EC69E

    ; Pendant 2 blue -> purple.
    LDA.w #hexto555($7C00D5) : STA $7EC656
    LDA.w #hexto555($AD45FF) : STA $7EC658

    LDA.w #hexto555($E8E8E8) : STA $7EC65C
    LDA.w #hexto555($A9A9A9) : STA $7EC65E

    ; Pendant 3 red -> green.
    LDA.w #hexto555($00B51E) : STA $7EC636
    LDA.w #hexto555($15FF36) : STA $7EC638

    LDA.w #hexto555($E8E8E8) : STA $7EC63C
    LDA.w #hexto555($A9A9A9) : STA $7EC63E

    ; Pendant 4 crystal -> yellow.
    LDA.w #hexto555($F8F8F8) : STA $7EC6D2

    LDA.w #hexto555($BFB400) : STA $7EC6D6
    LDA.w #hexto555($FFED23) : STA $7EC6D8
    LDA.w #hexto555($282828) : STA $7EC6DA
    LDA.w #hexto555($E8E8E8) : STA $7EC6DC
    LDA.w #hexto555($A9A9A9) : STA $7EC6DE

    INC $15

    SEP #$20

    RTL
}

; ==============================================================================