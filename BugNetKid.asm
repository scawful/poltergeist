; ==============================================================================

org $07F4D0
    Sprite_CheckIfPlayerPreoccupied:

org $06F154
    Sprite_CheckDamageToPlayer_same_layer:

; Change the item give to the lamp.
org $06B9C6
    LDY.b #$12

; Change the prep function to check for the lamp instead.
org $068D7F ; probably not needed
    ;LDA $7EF34A

; ==============================================================================

; Remove the bottle condition for the bug net kid. Always give the item.
org $06B962
BugNetKid_Resting:
{
    JSL Sprite_CheckIfPlayerPreoccupied : BCS .dont_awaken
        JSR Sprite_CheckDamageToPlayer_same_layer : BCC .dont_awaken
            LDA $7EF34A : BNE .hasLamp
            
                INC $0D80, X
                
                INC $02E4
    
    .dont_awaken
    
    RTS
    
    .hasLamp
    
    ; "... Do you have a bottle to keep a bug in? ... I see. You don't..."
    LDA.b #$04
    LDY.b #$01
        
    JSL Sprite_ShowSolicitedMessageIfPlayerFacing
        
    RTS
}
warnpc $06B990

; ==============================================================================

; Replaces the prep function.
org $068D7F
SpritePrep_BugNetKid:
{
    INC $0BA0, X
        
    RTS
}
warnpc $068D8D

; ==============================================================================