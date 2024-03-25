; --------------------
; Collision Properites
; By Jeimuzu
; --------------------

; 00 = No collision
; 01 = Standard collision (deflects projectiles)
; 02 = Standard collision (ignores projectiles)

; -----------------------
; GLOBAL COLLISION TABLES
; -----------------------

; Table 00 (SNES: E9659 > E9698) (PC: 71659 > 71698)
; --------------------------------------------------
; org $E9659

;     00   01   02   03   04   05   06   07   08   09   0A   0B   0C   0D   0E   0F
;      1    2    3    4    5    6    7    8    9   10   11   12   13   14   15   16
; -----------------------------------------------------------------------------------
;	db $01, $01, $01, $00, $02, $01, $02, $00, $01, $01, $02, $02, $02, $02, $02, $02
;	db $02, $02, $02, $00, $00, $00, $00, $00, $02, $00, $00, $02, $02, $02, $02, $02
;	db $02, $02, $02, $02, $01, $01, $01, $02, $02, $02, $02, $02, $01, $01, $00, $00 
;	db $02, $02, $02, $02, $02, $02, $01, $02, $02, $02, $02, $02, $01, $01, $00, $00


; Table 01 (SNES: E9699 > E96D8) (PC: 71699 > 716D8)
; -----------------------------------------------
org $E9699

    db $00, $00, $00, $2A, $01, $20, $01, $01, $04, $01, $01, $18, $01, $02, $1C, $01 
    db $28, $28, $2A, $2A, $01, $02, $01, $01, $04, $00, $00, $00, $28, $01, $0A, $00 
    db $01, $01, $0C, $0C, $02, $02, $02, $02, $02, $02, $20, $20, $20, $02, $08, $00 
    db $04, $04, $01, $01, $01, $02, $02, $02, $00, $00, $20, $20, $00, $02, $00, $00


; -------------------------
; Blockset Collision Groups
; -------------------------

; Blocksets 00 > 20 (blocksets 21/22/23 in HM = invalid?)
; (0x71000 > 0x71029) [LENGTH: 2A]

; group1 = 00 00		Curtains/Vines		Blockset 0; 1; 2; 9
; group2 = 80 00		Houses				Blockset 3; 4; 17
; group3 = 00 01		Converors			Blockset 5; 6; 7; 10; 15; 16; 18; 20
; group4 = 80 01		Deep Water			Blockset 8
; group5 = 00 02		Ice Floor			Blockset 11
; group6 = 80 02		Slime/Conveyor		Blockset 12
; group7 = 00 03		Trinexx Data		Blockset 13
; group8 = 80 03		Ganon's Tower		Blockset 14; 19

; Group Offsets (PC: $71000-$71029) (SNES: $E9000-$E9029)
; -------------------------------------------------------
org $E9000

;      00     01     02     03     04     05     06
  dw $0000, $0000, $0000, $0080, $0080, $0100, $0100
;      07     08     09     10     11     12     13
  dw $0100, $0180, $0200, $0100, $0200, $0280, $0300
;      14     15     16     17     18     19     20
  dw $0380, $0100, $0100, $0080, $0100, $0380, $0100


; Animated Tile Edits for Shadow Castle
; Room Blocksets 0; 1; 2; 9 (PC: $7102A > $710A9) (SNES: $E902A > $E90A9) - Group 00
; -----------------------------------------------------------------------------------
org $E902A

;		00   01   02   03   04   05   06   07   08   09   0A   0B   0C   0D   0E   0F
;		 1    2    3    4    5    6    7    8    9   10   11   12   13   14   15   16
; -----------------------------------------------------------------------------------
	db $02, $02, $02, $02, $02, $02, $6E, $6F, $01, $6C, $02, $01, $01, $01, $01, $01
	db $02, $02, $02, $02, $02, $02, $00, $00, $00, $00, $02, $01, $01, $01, $01, $01
	db $01, $01, $01, $01, $01, $01, $6E, $6F, $01, $6C, $02, $02, $02, $02, $01, $02
	db $00, $00, $22, $00, $00, $00, $02, $02, $02, $02, $02, $02, $00, $00, $01, $00

	db $01, $01, $01, $01, $01, $01, $01, $02, $02, $02, $02, $02, $02, $02, $02, $02
	db $01, $01, $01, $01, $01, $01, $01, $02, $02, $02, $02, $02, $02, $02, $02, $02
	db $02, $02, $02, $02, $18, $00, $00, $00, $00, $00, $02, $02, $01, $01, $01, $01 
	db $02, $02, $02, $01, $02, $02, $08, $08, $08, $08, $09, $09, $09, $09, $09, $09 ; Animated Tiles



; Final Boss Room
; Room Blockset = 08 (PC: 711AA > 71229) (SNES: E91AA > E9229) - group 4
; ---------------------------------------------------------------------------------
org $E91AA
    db $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $01, $01, $01, $01, $01
    db $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $02, $02, $02, $02, $02, $02
    db $00, $00, $22, $00, $00, $00, $00, $00, $00, $00, $02, $02, $00, $00, $00, $00

    db $01, $01, $01, $01, $01, $01, $01, $01, $00, $00, $00, $00, $00, $00, $02, $02
    db $01, $01, $01, $01, $01, $01, $01, $01, $00, $00, $00, $00, $00, $00, $02, $02
    db $02, $02, $02, $02, $18, $00, $00, $00, $00, $00, $00, $00, $01, $01, $01, $01

; Animations (7141A > 71429)
; ---------------------------------------------------------------------------------
    db $6B, $6A, $02, $01, $02, $02, $08, $08, $08, $08, $0E, $0E, $0E, $0E, $68, $69


; Haunted Mansion Basement
; Room Blockset = 09 (PC: 7122A > 712A9) (SNES: E922A > E92A9) - group 5
; ---------------------------------------------------------------------------------
org $E922A

;     00   01   02   03   04   05   06   07   08   09   0A   0B   0C   0D   0E   0F
;      1    2    3    4    5    6    7    8    9   10   11   12   13   14   15   16
; ---------------------------------------------------------------------------------
    db $02, $02, $00, $00, $00, $02, $02, $02, $02, $02, $02, $01, $01, $01, $01, $01
    db $02, $02, $00, $00, $00, $02, $02, $02, $02, $02, $02, $01, $01, $01, $01, $01
    db $01, $01, $00, $00, $00, $01, $01, $01, $01, $01, $01, $02, $02, $02, $02, $02
    db $00, $00, $34, $00, $00, $02, $02, $02, $02, $00, $02, $02, $02, $02, $00, $00
    
    db $01, $01, $00, $00, $02, $02, $02, $02, $02, $02, $02, $00, $02, $02, $02, $01
    db $01, $01, $00, $00, $02, $02, $02, $02, $02, $02, $02, $00, $01, $01, $02, $01
    db $00, $00, $00, $00, $02, $02, $00, $00, $00, $00, $00, $00, $02, $02, $02, $02

; Animations (PC: 7141A > 71429) (SNES: E941A > E9429)
; ---------------------------------------------------------------------------------
    db $6B, $6A, $02, $01, $02, $02, $08, $08, $08, $08, $0E, $0E, $0E, $0E, $68, $69


; Pumpkin Patch
; Room Blockset = 0C/12  (PC: 712AA > 71329) (SNES: E92AA > E9329) - group 6
; ---------------------------------------------------------------------------------
org $E92AA

;     00   01   02   03   04   05   06   07   08   09   0A   0B   0C   0D   0E   0F
;      1    2    3    4    5    6    7    8    9   10   11   12   13   14   15   16
; ---------------------------------------------------------------------------------
    db $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $01, $01, $01, $01, $01
    db $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $02, $02, $01, $02, $02, $02, $02, $02, $02, $02
    db $00, $00, $22, $00, $00, $00, $00, $00, $00, $00, $02, $02, $00, $00, $00, $00

    db $00, $00, $00, $00, $00, $00, $00, $02, $02, $02, $02, $02, $02, $02, $02, $02
    db $00, $00, $00, $00, $00, $00, $00, $02, $02, $02, $02, $02, $02, $02, $02, $02
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $02, $02, $02, $02, $02, $02
  

; Animations (7131A > 71329)
; -----------------------------------------------
    db $6B, $6A, $02, $01, $02, $02, $08, $08, $08, $08, $09, $09, $09, $09, $68, $69


; Abandoned Mineshaft
; Room Blockset = 0D/13 (PC: 7132A > 713A9) (SNES: E932A > E93A9) - group 7
; ---------------------------------------------------------------------------------
org $E932A

;     00   01   02   03   04   05   06   07   08   09   0A   0B   0C   0D   0E   0F
;      1    2    3    4    5    6    7    8    9   10   11   12   13   14   15   16
; ---------------------------------------------------------------------------------
    db $02, $02, $00, $00, $02, $02, $02, $02, $02, $02, $02, $01, $01, $01, $01, $01
    db $02, $02, $00, $00, $02, $02, $02, $02, $02, $02, $02, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $00, $00, $00, $00, $02, $02, $02, $02, $02, $02
    db $00, $00, $22, $00, $00, $00, $00, $00, $00, $00, $02, $02, $00, $00, $00, $00
    
    db $00, $00, $00, $00, $00, $00, $00, $02, $01, $01, $01, $02, $02, $02, $00, $00
    db $00, $00, $00, $00, $00, $00, $B0, $02, $01, $01, $02, $BE, $00, $02, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $02, $02, $02, $02, $02, $02

; Animations (PC: 7139A > 713A9) (SNES: E939A > E93A9)
; ------------------------------------------------------------
    db $00, $00, $00, $00, $00, $0E, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00


; Haunted Mansion First & Second Floors
; Room Blockset = 0E/14 (PC: 713AA > 71419) (SNES: E93AA > E9419) - group 8
; -------------------------------------------------------------------------
org $E93AA

;     00   01   02   03   04   05   06   07   08   09   0A   0B   0C   0D   0E   0F
;      1    2    3    4    5    6    7    8    9   10   11   12   13   14   15   16
; ---------------------------------------------------------------------------------
    db $02, $02, $02, $02, $02, $01, $01, $01, $02, $02, $02, $01, $01, $01, $01, $01
    db $02, $02, $02, $02, $02, $02, $01, $01, $02, $02, $02, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $02, $02, $02, $01, $01, $02, $02, $02, $02, $02, $02
    db $00, $00, $34, $00, $02, $02, $02, $02, $00, $00, $02, $02, $00, $00, $02, $00
    
    db $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $00, $00, $00, $02, $02
    db $02, $02, $02, $02, $01, $01, $02, $02, $02, $02, $02, $00, $00, $00, $02, $02
    db $02, $02, $02, $02, $00, $00, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02

; Animations (PC: 7141A > 71429) (SNES: E941A > E9429)
; ------------------------------------------------------------
    db $6B, $6A, $02, $01, $02, $02, $08, $08, $08, $08, $0E, $0E, $0E, $0E, $68, $69

; ------------------------
; Animated Object Graphics
; ------------------------

; (PC: 01011E) (SNES: 02811E)

; 5D = Deep Water
; 5E = Lava
; 5F = Slime

org $2811E
    ;   00   01   02   03   04   05   06   07   08   09   0A   0B
    db $5E, $5D, $5E, $5D, $5D, $5D, $5D, $5F, $5D, $63, $5F, $5E
    ;   0C   0D   0E   0F   10   11   12   13   14   15   16   17
    db $5F, $5E, $63, $5D, $5D, $5E, $5D, $5D, $5D, $5D, $5D, $5D
