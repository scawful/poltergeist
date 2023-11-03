; ==============================================================================

pushpc

org $05FFAC ; Spiderman
db $08
org $05FFBC
db $08
org $05FFCC
db $08
org $05FFDC
db $08

; ==============================================================================

org $05E9DA ; Mario
db $0E
org $05E9EA
db $4E
org $05E9FA
db $0E
org $05EA0A
db $4E
org $05EA1A
db $0E
org $05EA2A
db $0E
org $05EA3A
db $4E
org $05EA4A
db $4E

; ==============================================================================

org $0DDAA8 ; Archer Guy
db $08
org $0DDAAA
db $08
org $0DDAAE
db $08
org $0DDAB1
db $08
org $0DDAB4
db $08

; ==============================================================================

org $1AF861 ; Drink Guy
db $08
org $1AF871
db $08
org $1AF879
db $08
org $1AF889
db $08

; ==============================================================================

org $0DB457 ; Chicken Fix
db $40

org $05E3D1
db $0C
org $05E3D9
db $0C

; ==============================================================================

org $1EB214
Pool_Zol_DrawMultiple:
{
    .oam_groups
    dw 0, 8 : db $6C, $03, $00, $00
    dw 8, 8 : db $6D, $03, $00, $00
    dw 0, 8 : db $6D, $00, $00, $00
    dw 8, 8 : db $7D, $00, $00, $00
    dw 0, 8 : db $7D, $40, $00, $00
    dw 8, 8 : db $6D, $40, $00, $00
    dw 0, 0 : db $40, $00, $00, $02
    dw 0, 0 : db $40, $00, $00, $02
}

; ==============================================================================

org $08EDF9 ; Gravestones moved to sheet00 instead of 03
    db $08, $08, $18, $18

org $0DB393 ; Half Magic Fix
    db $59

org $05FBA2
    NOP #$0B 

; ==============================================================================

; Causes the intro uncle to flicker.
org $05DE2C
    JSL NewUncleDraw

pullpc

NewUncleDraw:
{
    LDA $1A : AND #$03 : BEQ + ; Change 03 to 01 if too slow
        JSL $0DD391 ; Draw Uncle Sprite

    +
    RTL
}

; ==============================================================================

; Fixes a bug with the stalfos OAM layering.
pushpc

org $0DC246
    db $80 ; BRA

pullpc

; org $0DC25C
; JSL StalfosCheckLayered
; NOP
; pullpc


; StalfosCheckLayered:
; AND #$8F : PHA ; keep that


; LDA $0FB3 : BEQ +
; PLA : ORA.l .head_properties_layered, X
; RTL
; +
; PLA : ORA.l .head_properties, X
; RTL


; .head_properties_layered
;     db $40, $00, $00, $00

; .head_properties
;     db $70, $30, $30, $30

; ==============================================================================

; Lumberjacks palette to blue
org $0DB359+$2C
db $49