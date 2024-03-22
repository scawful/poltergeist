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
    db $0C

; ==============================================================================

;-------------------------------------------------------------------------------------
;Sword and Shield Textbox Fix
;-------------------------------------------------------------------------------------

org $08C2DD
    dw $FFFF

org $05AF75
    RTS ; Remove portal warp

; ==============================================================================

; Mansion roof music fix.
org $0283f4
    CMP.b #$FF

; ==============================================================================

; Fix the capital 'B' debug item cheat.
org $0CDC26
    db $80 ; replace a $F0 (BEQ) with a $80 (BRA).

; ==============================================================================

; Uncle will not set the zelda tagalong when he leaves.
org $05DEF8
    LDA.b #$00

; ==============================================================================

; OverworldSpritesPaletteSet:
; org $0ED580 : db $FF, $FF	; Palette 00
; org $0ED582 : db $03, $0A	; Palette 01
; org $0ED584 : db $03, $06	; Palette 02
; org $0ED586 : db $03, $01	; Palette 03
; org $0ED588 : db $00, $02	; Palette 04
; org $0ED58A : db $03, $0E	; Palette 05
; org $0ED58C : db $03, $02	; Palette 06
; org $0ED58E : db $13, $01	; Palette 07
; org $0ED590 : db $0B, $0C	; Palette 08
org $0ED592 : db $03, $06	; Palette 09
; org $0ED594 : db $07, $05	; Palette 0A
; org $0ED596 : db $11, $00	; Palette 0B
; org $0ED598 : db $09, $0B	; Palette 0C
; org $0ED59A : db $0F, $05	; Palette 0D
; org $0ED59C : db $03, $05	; Palette 0E
; org $0ED59E : db $03, $07	; Palette 0F
; org $0ED5A0 : db $0F, $02	; Palette 10
; org $0ED5A2 : db $0A, $02	; Palette 11
; org $0ED5A4 : db $05, $01	; Palette 12
; org $0ED5A6 : db $0C, $0E	; Palette 13

; ==============================================================================

pullpc
