; ==============================================================================

; Remove some of the "000" death counters at the end.
org $0EBC51
    dw $0290, $0298, $02A0, $02A8, $02B0, $0310, $FFFF, $FFFF, $FFFF, $FFFF, $FFFF, $FFFF, $FFFF, $FFFF

; Changes which save values corrispond to which death counter.
org $0EBE08
    dw $0004, $0006, $0014, $000C, $0008, $001E, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000 

; Skip end cutscene.
org $0E9889
    LDA #$20 : STA $11
    RTS

; ==============================================================================

org $0EB038
incbin SpookyCredits.bin
warnpc $0EBC51

; ==============================================================================