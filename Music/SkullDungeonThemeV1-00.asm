; =================================================================================
; The Legend of Zelda: A Link to the Past (Custom Music Track)
; The Legend of Zelda: Oracle of Ages - Skull Dungeon Theme v1.00
; Original Song by Kyopi, M-Adachi
; Midi by FireMario
; ASM Framework by Zarby89
; Ported by Letterbomb
; Size 0x1F8=====================================================================================


org $1AC7EF; Sections?
SkullDungeonTheme:
!ARAMAddr = $F8F6
dw !ARAMAddr+$08
dw $00FF
dw !ARAMAddr
dw $0000


.Channels
!ARAMC = !ARAMAddr-SkullDungeonTheme
dw $0000
dw .Channel1+!ARAMC
dw .Channel2+!ARAMC
dw .Channel3+!ARAMC
dw .Channel4+!ARAMC
dw $0000
dw $0000
dw $0000







.Channel1
%SetMasterVolume($7F)
%SetTempo(54);
%SetInstrument($18) ; Guitar
%SetDurationN($24, $7F) ; 1/8
db Rest, D4s, F4s, G4s, A4s, G4s, F4s, F4
%CallSubroutine(.sub3+!ARAMC, 1)
db B4, Tie, Tie, A4s, G4s, Tie, Tie, F4s, G4s, Tie, F4, G4s, A4s, Tie, Tie, Tie, B4, Tie, C5s, $12, D5s, B4, $24, A4s, Tie, Tie, A4s, G4s, Tie, F4, G4s, A4s, Tie, Tie, A4s
%CallSubroutine(.sub4+!ARAMC, 4)
db $12, A3s, C4, D4, D4s, F4, D4s, D4, C4, $48, A3s, Tie, $24
%CallSubroutine(.sub3+!ARAMC, 1)
db B4, A4s, G4s, F4s, G4s, F4, G4s, A4s, $12, C5s, B4, A4s, G4s, A4s, G4s, F4s, G4s, F4s, F4, D4s, F4, D4, D4s, F4, F4s, $24, G4s, Tie, A4s, B4, A4s, Tie, Tie, Tie, Tie
db $00 ; End of the channel

.sub1
db Tie
db $00 ; End

.sub3
db A4s, G4s, F4s, F4, F4s, D4s, G4s, A4s
db $00 ; End

.sub4
db B4, A4s
db $00 ; End



.Channel2
%SetInstrument($18) ; Guitar
%SetDurationN($24, $7F) ; 1/8
db Rest, A3s, D4s, F4, F4s, F4, D4s, D4
%CallSubroutine(.sub6+!ARAMC, 1)
db G4s, Tie, Tie, F4s, F4, Tie, Tie, D4s, F4, Tie, D4s, Tie, $12, D4, C4, A3s, A3, A3s, C4, D4, F4, $24, G3s, B3, G3s, B3, $12, A3s, B3, A3s, A3, A3s, D4, F4, A4s, $24, F4, D4s, D4, C4, $12, A3, B3, A3, B3, A3, D4, F4, A4s
%CallSubroutine(.sub2+!ARAMC, 2)
db G4s, G4, F4s, F4, E4, D4s, D4, C4s, D4, D4s, F4, F4s, G4, F4s, F4, D4s, D4, F4, G4s, B4, $24, A4s, Tie
%CallSubroutine(.sub6+!ARAMC, 1)
db G4s, F4s, F4, D4s, F4, D4, F4, D4, F3, Tie, Tie, F3s, G3s, A3s, B3, C4, C4s, D4, D4s, Tie, D4, C4, A3s, Tie
db $00 ; End of the channel

.sub2
db G4s, G4, F4s, G4
db $00 ; End

.sub6
db F4s, F4, D4s, D4, D4s, A3s, D4s, F4s
db $00 ; End



.Channel3
%SetInstrument($09) ; Strings
%SetDurationN($48, $7F) ; 1/4
db Rest
%CallSubroutine(.sub1+!ARAMC, 8)
db G4s, Tie, F4, $24, Tie, $09, Tie, $48, F4, D4s, Tie, Tie, $24, G3s, B3, G3s, B3, $48, Tie, Tie, $24, F4, D4s, D4, $12, C4, Tie, Tie, $04, Tie, $48, Tie
%CallSubroutine(.sub1+!ARAMC, 8)
db A4s, Tie, Tie, $24, D4s, A3s, D4s, A3s, $48, Tie, Tie, F4, D4, F4, D4, $48
%CallSubroutine(.sub1+!ARAMC, 7)
db $00 ; End of the channel




.Channel4
%SetInstrument($09) ; Strings
%SetDurationN($48, $7F) ; 1/4
%CallSubroutine(.sub5+!ARAMC, 4)
db F2, $24, Tie, D2s, D2, Tie, Tie, C2, A1s, Tie, F2, Tie, A2s, $04, A2, G2s, Tie, G2, F2s, F2, Tie, E2, $48, A1s, G2s, A2, $12, A2s, Tie, A1s, B1, A1s, B1, A1s, Tie, F2
%CallSubroutine(.sub1+!ARAMC, 4)
db D2s, D2, B1, A1, Tie, F2, A2, $24, A2s, Tie, E2, D2s, D2, D2s, E2, D2s, E2, D2s, A2s, Tie, Tie, $04, A2, G2, F2s, E2, D2s, C2s, C2, C1, $24, A1s, Tie, A1s, Tie, D2s, D2s, Tie, D2s, $12, Tie, D2s
%CallSubroutine(.sub7+!ARAMC, 1)
db D2s, $24, F2, F2, Tie, F2, $12, Tie, F2 
%CallSubroutine(.sub7+!ARAMC, 1)
db F2, A1s, D2s
%CallSubroutine(.sub8+!ARAMC, 1)
db D2s, A1s, D2
%CallSubroutine(.sub8+!ARAMC, 1)
db D2, A1s, D2, F2, G2s, A2s
%CallSubroutine(.sub9+!ARAMC, 4)
db F2, D2, A1s
db $00 ; End of the channel

.sub5
db D2s, E2
db $00 ; End

.sub7
db F2s, G2s, A2s, G2s, F2s
db $00 ; End

.sub8
db F2, G2s, A2s, G2s, F2
db $00 ; End

.sub9
db B2, A2s
db $00 ; End
