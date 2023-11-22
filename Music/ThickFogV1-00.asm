;=====================================================================================
; The Legend of Zelda: A Link to the Past (Custom Music Track)
; Pocky & Rocky - Thick Fog Theme v1.00
; Original Song by Hiroyuki
; Midi by ???
; ASM Framework by Zarby89
; Ported by Letterbomb
; Size 0x167=====================================================================================

org $1AABA0; Sections?
ThickFogTheme:
!ARAMAddr = $DCA7
dw !ARAMAddr+$08
dw $00FF
dw !ARAMAddr
dw $0000   ;ends at 44


.Channels
!ARAMC = !ARAMAddr-ThickFogTheme
dw .Channel0+!ARAMC
dw .Channel1+!ARAMC
dw .Channel2+!ARAMC
dw .Channel3+!ARAMC
dw $0000
dw $0000
dw $0000
dw $0000



.Channel0
%SetMasterVolume($9F)
%SetChannelVolume($70)
%SetTempo(90);
%SetInstrument($0E) ; Chime
%SetDurationN($24, $7F) ; 1/8
%CallSubroutine(.sub1+!ARAMC, 24)
db $48
%CallSubroutine(.sub2+!ARAMC, 72)
db $00 ; End of the channel

.sub1
db A4, A4s, A4, G4
db $00 ; End

.sub2
db Tie
db $00 ; End



.Channel1
%SetInstrument($09) ; Strings
%SetDurationN($48, $7F) ; 1/4
db A1
%CallSubroutine(.sub2+!ARAMC, 5)
db G1
%CallSubroutine(.sub2+!ARAMC, 5)
db A1
%CallSubroutine(.sub2+!ARAMC, 5)
db G1
%CallSubroutine(.sub2+!ARAMC, 5)
db A1
%CallSubroutine(.sub2+!ARAMC, 5)
db G1
%CallSubroutine(.sub2+!ARAMC, 5)
db A1
%CallSubroutine(.sub2+!ARAMC, 5)
db G1
%CallSubroutine(.sub2+!ARAMC, 5)
db $24
%CallSubroutine(.sub5+!ARAMC, 1)
db E1, E1, Tie, E2, E1, D2
%CallSubroutine(.sub5+!ARAMC, 1)
db E1, E1, Tie, E1, F1, F1s
%CallSubroutine(.sub6+!ARAMC, 1)
db G1, Tie, G2, G1, F2, G2, G1, G1, Tie, G2, G1, F2
%CallSubroutine(.sub6+!ARAMC, 1)
%CallSubroutine(.sub7+!ARAMC, 3)
db A2s, A2s, A2s
db $00 ; End of the channel

.sub5
db F1, F1, F2, Tie, F2, Tie, F1, F1, Tie, F2, Tie, F2, E1, Tie, E2, E1, D2, E2
db $00 ; End

.sub6
db G1s, G1s, G2s, Tie, G2s, Tie, G1s, G1s, Tie, G2s, Tie, G2s
db $00 ; End

.sub7
db A1s, Tie, Tie
db $00 ; End



.Channel2
%SetInstrument($09) ; Strings
%SetDurationN($48, $7F) ; 1/4
%CallSubroutine(.sub3+!ARAMC, 1)
db E3
%CallSubroutine(.sub2+!ARAMC, 5)
db E3
%CallSubroutine(.sub2+!ARAMC, 5)
%CallSubroutine(.sub3+!ARAMC, 1)
db E4
%CallSubroutine(.sub2+!ARAMC, 5)
db E4
%CallSubroutine(.sub2+!ARAMC, 4)
db E4, F4
%CallSubroutine(.sub2+!ARAMC, 5)
db E4
%CallSubroutine(.sub2+!ARAMC, 5)
db F4
%CallSubroutine(.sub2+!ARAMC, 5)
db E4, Tie, Tie, Tie, $24, Tie, E4, F4, F4s, $48, G4s
%CallSubroutine(.sub2+!ARAMC, 5)
db G4
%CallSubroutine(.sub2+!ARAMC, 5)
db G4s
%CallSubroutine(.sub2+!ARAMC, 5)
db $24
%CallSubroutine(.sub4+!ARAMC, 3)
db A4s, A4s, A4s
db $00 ; End of the channel

.sub3
db A3, Tie, Tie, C4, Tie, Tie, A3s, Tie, D3, Tie, Tie, Tie
db $00 ; End

.sub4
db A4s, Tie, Tie
db $00 ; End



.Channel3
%SetInstrument($18) ; Guitar
%SetDurationN($48, $7F) ; 1/4
db Rest
%CallSubroutine(.sub2+!ARAMC, 47)
db $24
%CallSubroutine(.sub8+!ARAMC, 2)
%CallSubroutine(.sub9+!ARAMC, 1)
db G4, G4, Tie, Tie, Tie, Tie, G5, G5, Tie, Tie, Tie, Tie
%CallSubroutine(.sub9+!ARAMC, 1)
%CallSubroutine(.sub4+!ARAMC, 3)
db A4s, A4s, A4s
db $00 ; End of the channel

.sub8
db F3, F3, F4, Tie, F4, Tie, F3, F3, Tie, F4, Tie, F4, E4, E4, Tie, Tie, Tie, Tie, E5, E5, Tie, Tie, Tie, Tie
db $00 ; End

.sub9
db G3s, G3s, G4s, Tie, G4s, Tie, G3s, G3s, Tie, G4s, Tie, G4s
db $00 ; End
