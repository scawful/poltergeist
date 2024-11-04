org $0DFAF3
dw $140A, $1410, $1414, $1418, $141E ; Cursor Positions

org $0DE5C7
LDA.w #$140A ; Bottle Position

org $0DF054
LDA.w #$140A ; Bottle Position 2

org $0DE21A
LDA.w #$140A ; Bottle Position 3

org $0DE5EC
LDA.w #$1410 ; Somaria Position

org $0DE618
LDA.w #$1418 ; Cape Position

org $0DE62E
LDA.w #$141E ; Mirror Position


org $0DF8B1
dw $28D6, $68D6, $28E6, $28E7 ; Big key
dw $28D6, $68D6, $28E6, $28E7 ; Big key and Chest (Now just Big Key)

; org $0DF871
; dw $34FF, $74FF, $349F, $749F ; Fire shield Restore

org $0DF849
dw $2C8A, $2C65, $2474, $2D26 ; Master sword pixel fix


;=============================================================================

; FIREROD NAME DISPLAY (NOW FIRE ROD)
org $0DF269
dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5   ; TOP LINE
dw $2555, $2558, $2561, $2554, $24F5, $2561, $255E, $2553   ; BOTTOM LINE

; ICEROD NAME DISPLAY (NOW ICE ROD)
org $0DF289
dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5   ; TOP LINE
dw $2558, $2552, $2554, $24F5, $2561, $255E, $2553, $24F5   ; BOTTOM LINE

; FAERIE NAME DISPLAY (NOW FAIRY)
org $0DF4E9
dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5   ; TOP LINE
dw $2555, $2550, $2558, $2561, $2568, $24F5, $24F5, $24F5   ; BOTTOM LINE

; BOMB NAME DISPLAY (NOW BOMBS)
org $0DF229
dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5   ; TOP LINE
dw $2551, $255E, $255C, $2551, $2562, $24F5, $24F5, $24F5   ; BOTTOM LINE

; BOMBOS NAME DISPLAY (NOW TURTLE MASK)
org $0DF2A9
dw $2563, $2564, $2561, $2563, $255B, $2554, $24F5, $24F5   ; TOP LINE
dw $24F5, $24F5, $24F5, $24F5, $255C, $2550, $2562, $255A   ; BOTTOM LINE

; ETHER NAME DISPLAY (NOW DEITY MASK)
org $0DF2C9
dw $2553, $2554, $2558, $2563, $2568, $24F5, $24F5, $24F5   ; TOP LINE
dw $24F5, $24F5, $24F5, $24F5, $255C, $2550, $2562, $255A   ; BOTTOM LINE

; QUAKE NAME DISPLAY (NOW STALFOS MASK)
org $0DF2E9
dw $2562, $2563, $2550, $255B, $2555, $255E, $2562, $24F5   ; TOP LINE
dw $24F5, $24F5, $24F5, $24F5, $255C, $2550, $2562, $255A   ; BOTTOM LINE

; FLUTE NAME DISPLAY (NOW OCARINA)
org $0DF569
dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5   ; TOP LINE
dw $255E, $2552, $2550, $2561, $2558, $255D, $2550, $24F5   ; BOTTOM LINE

; FLUTE NAME DISPLAY 2 (NOW OCARINA)
org $0DF589
dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5   ; TOP LINE
dw $255E, $2552, $2550, $2561, $2558, $255D, $2550, $24F5   ; BOTTOM LINE
