; ==============================================================================

pushpc
org $05F14D ; Sahasrala main code
{
    LDA.w SprAction, X ; Load the current action of the sprite
    JSL UseImplicitRegIndexedLocalJumpTable

    dw Sahasrahla_Idle         ; 0x00
    dw Sahasrahla_ShowMessage  ; 0x01 Message 12
    dw Sahasrahla_GiveFlippers ; 0x02 - no message just to give you flippers
    dw Sahasrahla_HaveFlippers ; 0x03 Message 17 if we have flippers
}

Sahasrahla_Idle:
{
    LDA.l $7EF356 : BEQ .donthaveflippers
        LDA #$03 : STA.w SprAction, X
        RTS

    .donthaveflippers

    STZ $00
    CLC
    LDA.l $7EF374 : AND #$07

    LSR : BCC +
        INC $00
    +

    LSR : BCC +
        INC $00
    +

    LSR : BCC +
        INC $00
    +

    LDA.l $7EF37A : AND #$01 : BEQ +
        INC $00
    +

    LDA $00 : STA.w SprMiscA, X
    INC.w SprAction, X

    RTS
}

Sahasrahla_ShowMessage:
{
    LDY.b #$00
    LDA.w SprMiscA, X : CLC : ADC #$12 ; show message 12 + number of pendants

    JSL Sprite_ShowSolicitedMessageIfPlayerFacing : BCC .no_message
        LDA.w SprMiscA, X : CMP #$04 : BNE .no_message
            LDA #$02 : STA.w SprAction, X

    .no_message

    BRA animate
    RTS
}
warnpc $05F1DC

org $05F1DC
    animate:

org $05F1E9

Sahasrahla_GiveFlippers:
{
    LDY.b #$1E ; give flippers
    STZ $02E9
    JSL Link_ReceiveItem
    STZ.w SprAction, X

    RTS
}

Sahasrahla_HaveFlippers:
{
    LDY.b #$00
    LDA.b #$17
    JSL Sprite_ShowSolicitedMessageIfPlayerFacing

    BRA animate

    RTS
}
warnpc $05F219

pullpc

; ==============================================================================