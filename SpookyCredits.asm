; ==============================================================================

; The positions of the death counters. 
org $0EBC51
    dw $0290, $0298, $02A0, $02A8, $02B0, $0310, $FFFF, $FFFF, $FFFF, $FFFF, $FFFF, $FFFF, $FFFF, $FFFF

; Changes which save values (dungeon IDs) corrispond to which death counter.
org $0EBE08
    dw $0004, $0006, $0014, $000C, $0008, $001E, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000 

; Skip end cutscene.
org $0E9889
    LDA #$20 : STA $11
    RTS

; Change the final death count to save under Hyrule Castle 2 instead so that 
; it show the count correctly at the end of the credits and start the count
; at 0 instead of what was in ganon's tower.
org $0EBC9E
    LDA $7EF403 : STA $7EF3EF : LDA.w #$0000
    NOP : NOP

; ==============================================================================

org $0EB038 ; $073038 - 073C51
    incbin SpookyCredits.bin
    warnpc $0EBC51

; ==============================================================================