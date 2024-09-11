; ===============================================================================
; Allhallows Eve Dungeon Maps
; Special thanks to Letterbomb for tracing the 8x8 tilemap data.
; ===============================================================================

; ===============================================================================
; Disable Dungeon Maps
; ===============================================================================

; org $0288FD ; Replace a BEQ by a BRA
;     db $80


; ===============================================================================
; Dungeon Map Level Title GFX
; ===============================================================================

org $0AE196 : db $FF ; UNUSED
org $0AE197 : db $FF ; UNUSED
org $0AE198 : db $00 ; Pumpkin Patch
org $0AE199 : db $02 ; Living spooM
org $0AE19A : db $08 ; Shadow Castle
org $0AE19B : db $FF ; UNUSED
org $0AE19C : db $06 ; Abandoned Mineshaft
org $0AE19D : db $FF ; UNUSED
org $0AE19E : db $FF ; UNUSED
org $0AE19F : db $FF ; UNUSED
org $0AE1A0 : db $04 ; Haunted Manor
org $0AE1A1 : db $FF ; UNUSED
org $0AE1A2 : db $FF ; UNUSED
org $0AE1A3 : db $FF ; UNUSED


; ===============================================================================
; DungeonMap_DrawRoomMarkers
; ===============================================================================

; .offset_x_base
; org $0AE7F7 : dw $0090

; .fairy_rooms
org $0AE7F9 : dw $004C ; ROOM 004C - Manor Anti-Fairy Room
; org $0AE7FB : dw $00A7 ; ROOM 00A7 - Hera fairy room
; org $0AE7FD : dw $004F ; ROOM 004F - Ice Palace fairy room

; .fairy_room_replacements
org $0AE7FF : dw $005B ; ROOM 005B - Manor Rectangle Floor Drop Room
; org $0AE801 : dw $0077 ; ROOM 0077 - Hera lobby
; org $0AE803 : dw $00BE ; ROOM 00BE - Ice Palace block switch room

; .floor_threshold
; org $0AE805 : dw $0004


; ===============================================================================
; Boss Skulls
; ===============================================================================

; .offsets
org $0AEE5D : db $FF, $FF, $FF, $FF
org $0AEE61 : db $08, $08, $08, $00
org $0AEE65 : db $FF, $FF, $08, $00
org $0AEE69 : db $04, $04, $08, $00
org $0AEE6D : db $08, $08, $00, $08
org $0AEE71 : db $08, $08, $08, $08
org $0AEE75 : db $08, $00, $08, $00

; -------------------------------------------------------------------------------

; DungeonMap_BossRoomFloor:
; org $0AEE79 : dw $FFFF ; // - Sewers
; org $0AEE7B : dw $FFFF ; // - Hyrule Castle
org $0AEE7D : dw $00FF   ; B1 - Pumpkin Patch (Eastern Palace)
org $0AEE7F : dw $00FF   ; 2F - Living spooM (Desert Palace)
org $0AEE81 : dw $FFFF   ; // - Shadow Castle (Agahnim's Tower)
; org $0AEE83 : dw $00FF ; B1 - Swamp Palace
org $0AEE85 : dw $00FE   ; B1 - Abandoned Mineshaft (Palace of Darkness)
; org $0AEE87 : dw $00FF ; B1 - Misery Mire
; org $0AEE89 : dw $00FE ; B2 - Skull Woods
; org $0AEE8B : dw $00F9 ; B7 - Ice Palace
org $0AEE8D : dw $00FE   ; B2 - Haunted Manor (Tower of Hera)
; org $0AEE8F : dw $00FF ; B1 - Thieves' Town
; org $0AEE91 : dw $00FD ; B3 - Turtle Rock
; org $0AEE93 : dw $0006 ; 7F - Ganon's Tower


; ==================================================================================================
; DungeonMapFloorCountData:
; ==================================================================================================

org $0AF5D9 : db $10, $00 ; UNUSED
org $0AF5DB : db $10, $00 ; UNUSED
org $0AF5DD : db $11, $00 ; Pumpkin Patch
org $0AF5DF : db $11, $00 ; Living spooM
org $0AF5E1 : db $81, $01 ; Shadow Castle
org $0AF5E3 : db $10, $00 ; UNUSED
org $0AF5E5 : db $22, $00 ; Abandoned Mineshaft
org $0AF5E7 : db $10, $00 ; UNUSED
org $0AF5E9 : db $10, $00 ; UNUSED
org $0AF5EB : db $10, $00 ; UNUSED
org $0AF5ED : db $22, $00 ; Haunted Manor
org $0AF5EF : db $10, $00 ; UNUSED
org $0AF5F1 : db $10, $00 ; UNUSED
org $0AF5F3 : db $10, $00 ; UNUSED


; ===============================================================================
; Pumpkin Patch
; By Jeimuzu
; ===============================================================================

org $219090
dw $0b40, $0b41, $0b42, $0b43, $0b44, $0b45, $0b48, $0b49
dw $0b46, $0b47, $0b00, $0b4a, $0b00, $0b00, $0b50, $0b51
dw $0b4b, $0b4c, $0b52, $4b47, $0b4d, $4b4d, $0b53, $0b54
dw $4b4c, $4b4b, $4b47, $0b55, $0b4e, $0b4f, $0b56, $0b57
dw $cb52, $8b47, $4b5c, $0b5b, $0b58, $0b59, $cb5b, $8b5b
dw $8b47, $0b5a, $4b5b, $0b5c, $0b00, $0b00, $0b5d, $0b00
dw $0b5e, $0b5f, $0b60, $0b61, $0b63, $4b63, $1362, $5362
dw $575f, $4b5e, $4b61, $4b60, $0b00, $0b00, $0b00, $0b64


; ===============================================================================
; Living spooM
; By Jeimuzu
; ===============================================================================

org $219110
dw $0b65, $0b66, $0b6b, $0b00, $0b67, $0b68, $0b6c, $0b6d
dw $0b69, $0b6a, $0b6e, $176f, $4b66, $4b65, $0b00, $4b6b
dw $8b6b, $0b70, $0b72, $0b73, $0b71, $0b70, $0b74, $0b75
dw $0b00, $0b00, $0b76, $0b00, $0b00, $cb6b, $0b77, $0b78
dw $0b72, $0b79, $0b7d, $0b7e, $0b7a, $0b7b, $0b7f, $0b80
dw $cb47, $0b47, $4b47, $0b81, $0b7c, $0b78, $cb7c, $4b6b
dw $0b84, $0b85, $0b8a, $0b8b, $0b68, $0b86, $0b8c, $0b8d
dw $0b87, $4b87, $0b8e, $0b8f, $0b88, $0b89, $4b7e, $0b90
dw $0b92, $0b00, $1391, $0b00


; ===============================================================================
; The Haunted Manor
; By Jeimuzu
; ===============================================================================

org $219018
dw $1341, $5341, $0b43, $4b43, $cb5b, $0b00, $4b5b, $0b00

org $219030
dw $1345, $4b45, $0b46, $4b46, $1744, $0b47, $0b5b, $8b47
dw $1348, $5348, $8b48, $cb48, $4b47, $0b5c, $cb47, $cb42
dw $1349, $134a, $0b5d, $8b4a, $8b4b, $cb4b, $134b, $534b
dw $4b40, $0b4c, $0b4d, $cb44, $134e, $0b4f, $0b50, $0b51
dw $0b00, $0b52, $0b53, $0b54, $0b45, $0b55, $0b56, $0b57
dw $1358, $1359, $0b00, $8b4c, $0b00, $0b00, $0b00, $0b5a

org $219410
dw $0b00, $0b40, $0b00, $1342


; ===============================================================================
; Abandoned Mineshaft
; By Jeimuzu with a few minor tweaks by Letterbomb
; ===============================================================================

org $219280
dw $1382, $5382, $0b83, $4b83, $0b84, $0b85, $0b86, $0b87
dw $0b88, $4b88, $0b89, $4b89

org $2192A0
dw $0b8e, $0b8f, $0b00, $0b00, $0b90, $4b90, $0b91, $4b91
dw $0b92, $4b8e, $0b00, $0b00, $0b93, $0b94, $0b95, $8b94
dw $1796, $5796, $0b97, $4b97, $0b98, $4b84, $0b99, $0b9a
dw $0b9b, $0b9c, $8b9b, $cb9b, $0b9d, $0b9e, $0b9f, $0ba0
dw $0ba1, $0ba2, $0ba3, $0ba4, $0ba5, $0ba6, $0ba7, $0ba8
dw $0b84, $4b84, $4ba8, $0ba8, $0ba9, $0baa, $0bab, $0bac
dw $0bad, $4bad, $13ae, $53ae, $0baf, $0bb0, $0bb1, $0bb2
dw $0bb3, $0bb4, $0bb5, $0bb6, $0bb7, $0bb8, $0bb9, $0bba
dw $0bbb, $4bbb, $8bbb, $cbbb, $0b80, $4b80, $0b81, $4b81
dw $0b8a, $0b8b, $0b8c, $0b8d


; ===============================================================================
; Shadow Castle
; By Jeimuzu
; ===============================================================================

; dw $0b00, $0b00, $0b93, $0b00 ; Room 21
; dw $0b94, $1376, $0b74, $4b74 ; Room 31

org $2191A8
dw $0b00, $8b74, $0b97, $cb97
dw $0b95, $1396, $0b00, $0b00, $0b74, $136f, $0b00, $0b00
dw $0b98, $1399, $0b73, $0b00, $139b, $0b00, $0b9c, $0b9d
dw $0b94, $0b00, $4b74, $0b00, $0b00, $0b00, $4b6f, $0b9f
dw $0b97, $139e, $4b74, $0b00, $13a0, $0b94, $0ba1, $4b74
dw $8b74, $136f, $0ba2, $0b00, $8b73, $0b00, $8b98, $13a3
dw $13a4, $53a4, $0ba5, $4ba5, $8b74, $cb74, $1794, $13a6
dw $13a7, $53a7, $13a8, $53a8, $0b00, $0b98, $0b00, $0b73
dw $8b8e, $cb8e, $578f, $178f, $0ba9, $0b9a, $0baa, $0bab
dw $0b00, $0bac, $0b00, $4b73, $4b51, $0b51, $0b00, $0b00
dw $0bad, $0bae, $0baf, $0bb0, $13b1, $13b2, $0bb6, $0bb7
dw $13b3, $53b3, $13b8, $53b8, $0bb4, $0bb5, $0bb9, $0bba
dw $93a8, $d3a8, $0bbb, $4ba8, $0bbc, $0bbd, $0bbf, $4b74
dw $0ba9, $0bbe, $cbbe, $cba9, $4bbe, $0bbe, $8ba9, $8bbe
