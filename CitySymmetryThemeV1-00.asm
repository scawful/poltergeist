;=====================================================================================
; The Legend of Zelda: A Link to the Past (Custom Music Track)
; The Legend of Zelda: Oracle of Ages - City Symmetry Theme v1.00
; Original Song by Kyopi, M-Adachi
; Midi by FireMario
; ASM Framework by Zarby89
; Ported by Letterbomb
;=====================================================================================

org $1A9F05; Sections?
CitySymmetryTheme:
!ARAMAddr = $D00C
dw !ARAMAddr+$08
dw $00FF
dw !ARAMAddr
dw $0000


.Channels
!ARAMC = !ARAMAddr-CitySymmetryTheme
dw .Channel0+!ARAMC
dw .Channel1+!ARAMC
dw .Channel2+!ARAMC
dw .Channel3+!ARAMC
dw .Channel4+!ARAMC
dw $0000
dw $0000
dw $0000


.Channel0
%SetMasterVolume($7F)
%SetTempo(55);
%SetInstrument($09) ; Strings
%SetDurationN($24, $7F) ; 1/8
%CallSubroutine(.sub1+!ARAMC, 1)
db F3, A3s, C4, D4s, D4, Tie, A3s, G3
%CallSubroutine(.sub2+!ARAMC, 2)
db F3, Tie, A3s, Tie, C4, $04, Tie, Tie, Tie, A3s, A3, G3s, G3, F3s, $24, F3, Tie, A5, $12, Tie, G5, $24, C5, D5s, F5, A5, G5, Tie, $24, A3, $12, Tie, G3, $24, F3, C3, D3s, Tie, F3, $09, B2, C3, Tie, Tie
%CallSubroutine(.sub1+!ARAMC, 1)
db $48, F3, C4, C3, C4 
db $00 ; End of the channel

.sub1
db $24, F3, Tie, A3s, C4, D4s, Tie, D4, C4
db $00 ; End

.sub2
db D3s, Tie, G3s, A3s, C4s, Tie, C4, A3s
db $00 ; End



.Channel1
%SetInstrument($18) ; Guitar
%SetDurationN($24, $7F) ; 1/8
db F4, A4s, C5, D5s, D5, Tie, $48, G5
%CallSubroutine(.sub3+!ARAMC, 8)
db $24, F4, $12, A3s, C4s, D4s, Tie, Tie, Tie, A4s, Tie, Tie, G4s, F4, Tie, G4s, Tie, A4s, Tie, Tie, Tie, C5, Tie, D5s, Tie, C5, Tie, Tie, D5s, $48, F5
%CallSubroutine(.sub3+!ARAMC, 16)
db $00 ; End of the channel

.sub3
db Tie
db $00 ; End




.Channel2
%SetInstrument($09) ; Strings
%SetDurationN($24, $7F) ; 1/8
db Rest
%CallSubroutine(.sub4+!ARAMC, 1)
db Tie
%CallSubroutine(.sub4+!ARAMC, 1)
db $48, F4, C5, D5s, G5, $24, Tie
%CallSubroutine(.sub5+!ARAMC, 2)
%CallSubroutine(.sub6+!ARAMC, 2)
%CallSubroutine(.sub4+!ARAMC, 1)
db Tie
%CallSubroutine(.sub4+!ARAMC, 1)
db Tie
%CallSubroutine(.sub7+!ARAMC, 2)
%CallSubroutine(.sub8+!ARAMC, 1)
db Tie
%CallSubroutine(.sub8+!ARAMC, 1)
db Tie
%CallSubroutine(.sub4+!ARAMC, 1)
db Tie
%CallSubroutine(.sub4+!ARAMC, 1)
db Tie
%CallSubroutine(.sub8+!ARAMC, 1)
db Tie
%CallSubroutine(.sub8+!ARAMC, 1)
db $00 ; End of the channel

.sub4
db $24, C4, $09, B4, C5, Tie, Tie, $24, Tie
db $00 ; End

.sub5
db A3s, $09, G4s, A4s, Tie, Tie, $24, Tie, Tie
db $00 ; End

.sub6
db A3s, $09, A4, A4s, Tie, Tie, $24, Tie, Tie
db $00 ; End

.sub7
db E4, $09, D5s, E5, Tie, Tie, $24, Tie, Tie
db $00 ; End

.sub8
db F4, $09, E5, F5, Tie, Tie, $24, Tie
db $00 ; End



.Channel3
%SetInstrument($09) ; Strings
%SetDurationN($48, $7F) ; 1/4
db Rest, Tie, Tie, Tie, $24, C3, D3s, F3, G3s, A3s, Tie, G3, Tie, D5s, $12, F5, G5, G5s, Tie, G5, F5, $24, D5s, Tie, F5, C5, $48
%CallSubroutine(.sub3+!ARAMC, 8)
db C4, D4s, $12, F4, Tie, G4, G4s, A4, Tie, Tie, Tie, F3, Tie, Tie, G3, A3, Tie, A3s, Tie, C4, Tie, D4, E4, $48, F4, C3, $24, D3, E3, G3, Tie, F3, D3s, $48
%CallSubroutine(.sub3+!ARAMC, 4)
db $00 ; End of the channel



.Channel4
%SetChannelVolume($7E)
%SetInstrument($09) ; Strings
%SetDurationN($24, $7F) ; 1/8
db Rest, Tie, Tie, $48, C5, Tie, C5, Tie, Tie, Tie, C4, Tie, A4s, Tie, A4s, Tie, A4s, Tie, A4s, Tie, C5, Tie, C5, Tie, E5, Tie, C4, Tie, F5, Tie, F5, Tie, C5, Tie, C5, Tie, F5, Tie, $24, F5
db $00 ; End of the channel



print pc
