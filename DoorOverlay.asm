org $1EE05F
    JSL Sprite_CheckDamageToPlayer : BCC .nocollision
        LDA $A0 : CMP #$F0 : BNE .wasnoroomF0
            LDA.l $7EF29B : ORA #$20 : STA.l $7EF29B
            BRA .continue

    .nocollision

    RTS
warnpc $1EE07A

org $1EE07C
    .wasnoroomF0
    .continue
