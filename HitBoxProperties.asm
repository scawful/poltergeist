; ===================================================================================
; HIT BOX PROPERTIES
; Written by Jeimuzu
; 01-18-2024
; ===================================================================================
; There are numerous sprites that can't be killed that are also acknowledged by clear
; enemy tags by default.  This assembly alters them to be ignored.
; ===================================================================================

;	$0F60 [0x10]	-	(Sprite)

;	isphhhhh

;	i - Ignore collision settings and always check tile interaction on the same
;		layer that the sprite is on.

;	s - 'Statis'. If set, indicates that the sprite should not be considered as
;		"alive" in routines that try to check that property. Functionally, the
;		sprites might not actually be considered to be in statis though.
;		(0 = Acknowledge) (1 = Ignored)

;		Example: Bubbles (aka Fire Fairys) are not considered alive for the
;		purposes of puzzles, because it's not expected that you always have
;		the resources to kill them. Thus, they always have this bit set.

;	p - 'Persist' If set, keeps the sprite from being deactivated from being
;		too far offscreen from the camera. The sprite will continue to move and
;		interact with the game map and other sprites that are also active.

;	h - 5-bit value selecting the sprite's hitbox dimensions and perhaps other
;		related parameters.

; -----------------------------------------------------------------------------------

;	(SNES: 0DB44C) (PC: $06B44C) $0F60 Alive / hit box property
org $0DB44C

;	    00   01   02   03   04   05   06   07   08   09   0A   0B   0C   0D   0E   0F
	db $00, $00, $00, $43, $43, $43, $43, $43, $00, $00, $00, $40, $1C, $00, $00, $02

;	    10   11   12   13   14   15   16   17   18   19   1A   1B   1C   1D   1E   1F
	db $01, $03, $00, $00, $43, $C0, $47, $00, $00, $00, $47, $45, $43, $40, $40, $4D

;	    20   21   22   23   24   25   26   27   28   29   2A   2B   2C   2D   2E   2F
	db $00, $40, $00, $00, $00, $40, $00, $40, $47, $47, $47, $47, $47, $47, $4D, $47

;	    30   31   32   33   34   35   36   37   38   39   3A   3B   3C   3D   3E   3F
	db $47, $47, $47, $43, $47, $47, $47, $40, $43, $47, $4D, $40, $47, $47, $00, $40

;	    40   41   42   43   44   45   46   47   48   49   4A   4B   4C   4D   4E   4F
	db $49, $12, $12, $12, $12, $12, $12, $12, $12, $12, $12, $12, $00, $00, $00, $00

;	    50   51   52   53   54   55   56   57   58   59   5A   5B   5C   5D   5E   5F
	db $80, $12, $09, $09, $00, $40, $00, $0C, $00, $40, $40, $40, $40, $50, $50, $6E

;	    60   61   62   63   64   65   66   67   68   69   6A   6B   6C   6D   6E   6F
	db $6E, $40, $5E, $53, $00, $4A, $00, $00, $00, $00, $12, $12, $40, $00, $00, $40

;	    70   71   72   73   74   75   76   77   78   79   7A   7B   7C   7D   7E   7F
	db $19, $00, $40, $4A, $4D, $4A, $4A, $80, $4A, $41, $00, $40, $00, $49, $40, $40

;	    80   81   82   83   84   85   86   87   88   89   8A   8B   8C   8D   8E   8F
	db $C0, $00, $40, $00, $00, $40, $00, $00, $09, $80, $C0, $00, $40, $00, $00, $80

;	    90   91   92   93   94   95   96   97   98   99   9A   9B   9C   9D   9E   9F
	db $40, $00, $18, $5A, $00, $D4, $D4, $D4, $D4, $00, $40, $00, $80, $80, $40, $40

;	    A0   A1   A2   A3   A4   A5   A6   A7   A8   A9   AA   AB   AC   AD   AE   AF
	db $40, $00, $09, $1D, $00, $00, $00, $00, $00, $00, $00, $40, $40, $4A, $5B, $5B

;	    B0   B1   B2   B3   B4   B5   B6   B7   B8   B9   BA   BB   BC   BD   BE   BF
	db $5B, $5B, $41, $40, $43, $47, $47, $43, $0A, $40, $41, $4A, $4A, $09, $00, $00

;	    C0   C1   C2   C3   C4   C5   C6   C7   C8   C9   CA   CB   CC   CD   CE   CF
	db $40, $00, $09, $00, $40, $40, $40, $00, $40, $00, $40, $89, $80, $80, $00, $1C

;	    D0   D1   D2   D3   D4   D5   D6   D7   D8   D9   DA   DB   DC   DD   DE   DF
	db $00, $40, $00, $00, $1C, $47, $03, $03, $44, $44, $44, $44, $44, $44, $44, $44

;	    E0   E1   E2   E3   E4   E5   E6   E7   E8   E9   EA   EB   EC   ED   EE   EF
	db $44, $44, $44, $43, $44, $43, $40, $C0, $C0, $C7, $C3, $C3, $C0, $5B, $48, $5B

;	    F0   F1   F2
	db $5B, $5B, $43
	


; VANILLA
;	    00   01   02   03   04   05   06   07   08   09   0A   0B   0C   0D   0E   0F
;	db $00, $00, $00, $43, $43, $43, $43, $43, $00, $00, $00, $00, $1C, $00, $00, $02

;	    10   11   12   13   14   15   16   17   18   19   1A   1B   1C   1D   1E   1F
;	db $01, $03, $00, $00, $03, $C0, $07, $00, $00, $00, $07, $45, $43, $00, $40, $0D

;	    20   21   22   23   24   25   26   27   28   29   2A   2B   2C   2D   2E   2F
;	db $00, $00, $00, $00, $00, $00, $00, $00, $07, $07, $07, $07, $07, $07, $0D, $07

;	    30   31   32   33   34   35   36   37   38   39   3A   3B   3C   3D   3E   3F
;	db $07, $07, $07, $03, $07, $07, $07, $40, $03, $07, $0D, $00, $07, $07, $00, $00

;	    40   41   42   43   44   45   46   47   48   49   4A   4B   4C   4D   4E   4F
;	db $09, $12, $12, $12, $12, $12, $12, $12, $12, $12, $12, $12, $00, $00, $00, $00

;	    50   51   52   53   54   55   56   57   58   59   5A   5B   5C   5D   5E   5F
;	db $80, $12, $09, $09, $00, $40, $00, $0C, $00, $00, $00, $40, $40, $10, $10, $2E

;	    60   61   62   63   64   65   66   67   68   69   6A   6B   6C   6D   6E   6F
;	db $2E, $40, $1E, $53, $00, $0A, $00, $00, $00, $00, $12, $12, $40, $00, $00, $40

;	    70   71   72   73   74   75   76   77   78   79   7A   7B   7C   7D   7E   7F
;	db $19, $00, $00, $0A, $0D, $0A, $0A, $80, $0A, $41, $00, $40, $00, $49, $00, $00

;	    80   81   82   83   84   85   86   87   88   89   8A   8B   8C   8D   8E   8F
;	db $C0, $00, $40, $00, $00, $40, $00, $00, $09, $80, $C0, $00, $40, $00, $00, $80

;	    90   91   92   93   94   95   96   97   98   99   9A   9B   9C   9D   9E   9F
;	db $00, $00, $18, $5A, $00, $D4, $D4, $D4, $D4, $00, $40, $00, $80, $80, $40, $40

;	    A0   A1   A2   A3   A4   A5   A6   A7   A8   A9   AA   AB   AC   AD   AE   AF
;	db $40, $00, $09, $1D, $00, $00, $00, $00, $00, $00, $00, $00, $00, $0A, $1B, $1B

;	    B0   B1   B2   B3   B4   B5   B6   B7   B8   B9   BA   BB   BC   BD   BE   BF
;	db $1B, $1B, $41, $00, $03, $07, $07, $03, $0A, $00, $01, $0A, $0A, $09, $00, $00

;	    C0   C1   C2   C3   C4   C5   C6   C7   C8   C9   CA   CB   CC   CD   CE   CF
;	db $00, $00, $09, $00, $00, $40, $40, $00, $00, $00, $00, $89, $80, $80, $00, $1C

;	    D0   D1   D2   D3   D4   D5   D6   D7   D8   D9   DA   DB   DC   DD   DE   DF
;	db $00, $40, $00, $00, $1C, $07, $03, $03, $44, $44, $44, $44, $44, $44, $44, $44

;	    E0   E1   E2   E3   E4   E5   E6   E7   E8   E9   EA   EB   EC   ED   EE   EF
;	db $44, $44, $44, $43, $44, $43, $40, $C0, $C0, $C7, $C3, $C3, $C0, $1B, $08, $1B

;	    F0   F1   F2
;	db $1B, $1B, $03
