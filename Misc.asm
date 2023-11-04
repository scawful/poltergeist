; ==============================================================================
; This file is for ASM that is too small to desrve its own file.

pushpc

; Start from textbox removed.
org $0281F2
   NOP #4

; ==============================================================================

; Teleports the dropped boss hearts to the player instead of dropping them on the floor.
org $09EE57
    LDA $04    : STA $0F70, Y
    LDA.b #$20 : STA $0F80, Y
        
    LDA $EE    : STA $0F20, Y
    LDA.b #$02 : STA $0D90, Y
    
    ; Set the heart's position to link's position.
    LDA $22 : STA $0D10, Y
    LDA $23 : STA $0D30, Y

    LDA $20 : STA $0D00, Y
    LDA $21 : STA $0D20, Y
    
    RTS

; ==============================================================================

; Tavern Backdoor Fix
org $02D7AA
dw $FFFF

; ==============================================================================

; Changes the skull woods entrance trigger tiles.
org $1BB90B
    dw $016F

org $1BB963
    dw $015A

; ==============================================================================

; Fixes a bug that causes the bottles not to appear in the inventory if it is
; the first item obtained.

org $098960
    JSL BottleFix

pullpc

BottleFix:
{
    STA $7EF35C, X 

    LDA.b #$01 : STA $7EF34F

    RTL
}

pushpc

; ==============================================================================

; Book of madora dash item room.
org $068CFE
    db #$7C ; low byte

org $068D04
    db #$00 ; high byte (00 to use rooms < 256) and 01 to use rooms > 256

; ==============================================================================

; Reduce the damage done by the hammer.
org $06ED79
    db $02 ; master sword damage

; ==============================================================================

; Remove the sparkles from the sword on the titlescreen
org $0CFF17
    db $80

org $0CFF55
    db $80

; ==============================================================================

; Rain music? I can't remember exactly what this one does.
org $0AFD59
LDA #$05 ; change ambient song to nothing indoor

org $0283AD
LDA #$05 ; change ambient song to nothing outdoor

org $0284F2
LDX #$05

; ==============================================================================

;Master Sword Wind Fix
org $08C5D3
    LDA.b #$00
    STA $012D

org $09876D
    db $80

org $0987CA
    db $80

; ==============================================================================

; Change the dungeon that makes it so the tower of hera pendant falls in a set
; location to Letter's dungeon instead. Change to something else if this breaks it.
org $098C25
    db #$0C

; ==============================================================================

pullpc