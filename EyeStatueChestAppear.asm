; ==============================================================================
; Eye Statue Chest Appear
; Written by Zarby89
; 10-7-2024
; ==============================================================================

pushpc

org $05E64D
JSL NewEyeStatue
NOP #$01

pullpc

; ==============================================================================

NewEyeStatue:
LDA.w $0E30, X : BEQ .normalcode ; Load subtype
; if subtype is not 0
; then spawn a chest by using the pushblock code
INC.w $0641 ; 0641 instead to trigger pushblock
LDA.b #$01
RTL

.normalcode
INC.w $0642
LDA.b #$01
RTL

; ==============================================================================