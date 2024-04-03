; ===============================================================================
; Allhallows Eve Dungeon Maps
; Special thanks to Letterbomb for tracing the 8x8 tilemap data.
; ===============================================================================

; ------------------------------------------------------------------------------
; Disable Dungeon Maps
; ------------------------------------------------------------------------------

org $0288FD ; Replace a BEQ by a BRA
    db $80


; ------------------------------------------------------------------------------
; DungeonMap_DrawRoomMarkers
; ------------------------------------------------------------------------------

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


; -------------------------------------------------------------------------------
; Pumpkin Patch
; By Jeimuzu
; -------------------------------------------------------------------------------

org $219090
dw $0b40, $0b41, $0b42, $0b43, $0b44, $0b45, $0b48, $0b49
dw $0b46, $0b47, $0b00, $0b4a, $0b00, $0b00, $0b50, $0b51
dw $0b4b, $0b4c, $0b52, $4b47, $0b4d, $4b4d, $0b53, $0b54
dw $4b4c, $4b4b, $4b47, $0b55, $0b4e, $0b4f, $0b56, $0b57
dw $cb52, $8b47, $4b5c, $0b5b, $0b58, $0b59, $cb5b, $8b5b
dw $8b47, $0b5a, $4b5b, $0b5c, $0b00, $0b00, $0b5d, $0b00
dw $0b5e, $0b5f, $0b60, $0b61, $0b63, $4b63, $1362, $5362
dw $575f, $4b5e, $4b61, $4b60, $0b00, $0b00, $0b00, $0b64


; -------------------------------------------------------------------------------
; Living spooM
; By Jeimuzu
; -------------------------------------------------------------------------------

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


; -------------------------------------------------------------------------------
; The Haunted Manor
; By Jeimuzu
; -------------------------------------------------------------------------------

org $219018
dw $1341, $5341, $0b43, $4b43

org $219020
dw $4b44, $0b00, $cb44, $0b00

org $219030
dw $1345, $4b45, $0b46, $4b46, $1744, $0b47, $8b44, $8b47
dw $1348, $5348, $8b48, $cb48, $4b47, $4b42, $cb47, $cb42
dw $1349, $134a, $8b49, $8b4a, $8b4b, $cb4b, $134b, $534b
dw $4b40, $0b4c, $0b4d, $cb44, $134e, $0b4f, $0b50, $0b51
dw $0b00, $0b52, $0b53, $0b54, $0b45, $0b55, $0b56, $0b57
dw $1358, $1359, $0b00, $8b4c, $0b00, $0b00, $0b00, $0b5a

org $219410
dw $0b00, $0b40, $0b00, $1342


; -------------------------------------------------------------------------------
; Abandoned Mineshaft
; By
; -------------------------------------------------------------------------------


; -------------------------------------------------------------------------------
; Shadow Castle
; By
; -------------------------------------------------------------------------------

; dw 000b 000b 930b 000b ; Room 21
; dw 940b 7613 740b 744b ; Room 31
; org $2191A8
; dw $000b 748b 970b 97cb
; 950b 9613 000b 000b 740b 6f13 000b 000b
; 980b 9913 730b 000b 9b13 000b 9c0b 9d0b
; 940b 000b 744b 000b 000b 000b 6f4b 9f0b
; 970b 9e13 744b 000b a013 940b a10b 744b
; 748b 6f13 a20b 000b 738b 000b 988b a313
; a413 a453 a50b a54b 748b 74cb 9417 a613
; a713 a753 a813 a853 000b 980b 000b 730b
; 8e8b 8ecb 8f57 8f17 a90b 9a0b aa0b ab0b
; 000b ac0b 000b 734b 514b 510b 000b 000b
; ad0b ae0b af0b b00b b113 b213 b60b b70b
; b313 b353 b813 b853 b40b b50b b90b ba0b
; a893 a8d3 bb0b a84b bc0b bd0b bf0b 744b
; a90b be0b becb a9cb be4b be0b a98b be8b

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
