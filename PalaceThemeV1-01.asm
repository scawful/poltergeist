;=====================================================================================
; The Legend of Zelda: A Link to the Past (Custom Music Track)
; The Legend of Zelda: The Adventure of Link - Palace Theme v1.01
; Original Song by Akito Nakatsuka
; Midi by (Unknown)
; ASM Framework by Zarby89
; Ported by Letterbomb
; Size 0x478
;=====================================================================================

lorom

org $1B804A; Sections?
PalaceTheme: 
!ARAMAddr = $D046
dw !ARAMAddr+$0A ; Intro
dw !ARAMAddr+$1A ; Looping
dw $00FF
dw !ARAMAddr+$02 ; Looping Section
dw $0000

.ChannelsIntro
!ARAMC = !ARAMAddr-PalaceTheme
dw .Channel0Intro+!ARAMC
dw .Channel1Intro+!ARAMC
dw .Channel2Intro+!ARAMC
dw $0000
dw $0000
dw $0000
dw $0000
dw $0000

.Channels
!ARAMC = !ARAMAddr-PalaceTheme
dw .Channel0+!ARAMC
dw .Channel1+!ARAMC
dw .Channel2+!ARAMC
dw .Channel3+!ARAMC
dw .Channel4+!ARAMC
dw $0000
dw $0000
dw $0000


.Channel0Intro
%SetMasterVolume($EF)
%SetTempo(95);
%SetInstrument($09) ; Strings
%SetDurationN($24, $7F) ; 1/8
db G4, $48, G4, G4, G4, $24, Tie, A4s, Tie, Tie, A4, Tie, Tie, G4s, Tie
db $00 ; End of the channel


.Channel1Intro
%SetInstrument($09) ; Strings
%SetDurationN($24, $7F) ; 1/8
db G2, $48, G2, G2, G2, $24, Tie, A2s, A2s, A2s, A2, A2, A2, G2s, G2s
db $00 ; End of the channel


.Channel2Intro
%SetInstrument($0F) ; Harp
%SetDurationN($24, $7F) ; 1/8
db G2, $48, G2, G2, G2, $24, Tie, A2s, A2s, A2s, A2, A2, A2, G2s, G2s
db $00 ; End of the channel


.Channel0:
%CallSubroutine(.sub1+!ARAMC, 2)
%CallSubroutine(.sub2+!ARAMC, 1)
%CallSubroutine(.sub37+!ARAMC, 1)
%CallSubroutine(.sub2+!ARAMC, 1)
%CallSubroutine(.sub3+!ARAMC, 1)
%CallSubroutine(.sub1+!ARAMC, 2)
%CallSubroutine(.sub4+!ARAMC, 1)
db F5, C5, D5, D5s, Tie, D5, C5, Tie, C5, G4s, A4s, C5, Tie, D5, D5s, Tie
%CallSubroutine(.sub4+!ARAMC, 1)
db D4, D4, Tie, D4s, Tie, Tie, Tie, Tie, D4, D4, Tie, F4s, Tie, A4, Tie, C5
%CallSubroutine(.sub5+!ARAMC, 1)
%CallSubroutine(.sub7+!ARAMC, 1)
%CallSubroutine(.sub6+!ARAMC, 1)
%CallSubroutine(.sub5+!ARAMC, 1)
%CallSubroutine(.sub7+!ARAMC, 1)
%CallSubroutine(.sub6+!ARAMC, 1)
%CallSubroutine(.sub2+!ARAMC, 1)
%CallSubroutine(.sub37+!ARAMC, 1)
%CallSubroutine(.sub2+!ARAMC, 1)
%CallSubroutine(.sub3+!ARAMC, 1)
db $00 ; End of the channel

.sub1
db $24, G4, Tie, Tie, Tie, Tie, A4, A4s, D5, D5s, Tie, Tie, A4s, Tie, Tie, D5s, Tie, E5, Tie, Tie, A4s, Tie, Tie, E5, Tie, D5s, Tie, G5, F5, Tie, D5s, Tie, Tie
db $00 ; End

.sub2
db $24, D5, $48, D5, D5, $24, D5, $48, C5, Tie, Tie, Tie, Tie
db $00 ; End

.sub3
db $24, D5, D5, Tie, D5, Tie, D5, F5, Tie, Tie, Tie, Tie, D5s, Tie, Tie, D5, Tie
db $00 ; End

.sub4
db C5, A4, A4s, C5, Tie, A4s, A4, Tie, A4, F4s, G4, A4, Tie, G4, F4s, Tie
db $00 ; End

.sub5
db $5A, D5, Tie, $48, C5, $24, A4s, $2D, A4, $36, A4s, $2D, C5, D5, $36, D5s, $2D, F5
db $00

.sub6
db $5A, G5, Tie, $48, G4, $24, A4, $2D, B4, $36, C5, $2D, D5, E5, $36, F5, $2D, G5

.sub7
db $5A, F5, Tie, $48, D5s, $24, D5, $2D, D5s, $36, D5, $2D, C5, D5, $36, D5s, $2D, F5
db $00 ; End

.sub37
db $24, D5, $48, D5, D5, $24, D5, $48, D5s, Tie, Tie, Tie, Tie
db $00 ; End


.Channel1
%CallSubroutine(.sub8+!ARAMC, 1)
%CallSubroutine(.sub9+!ARAMC, 1)
%CallSubroutine(.sub10+!ARAMC, 1)
%CallSubroutine(.sub9+!ARAMC, 1)
%CallSubroutine(.sub8+!ARAMC, 1)
%CallSubroutine(.sub9+!ARAMC, 1)
%CallSubroutine(.sub10+!ARAMC, 1)
%CallSubroutine(.sub9+!ARAMC, 1)
%CallSubroutine(.sub11+!ARAMC, 3)
%CallSubroutine(.sub12+!ARAMC, 1)
%CallSubroutine(.sub8+!ARAMC, 1)
%CallSubroutine(.sub9+!ARAMC, 1)
%CallSubroutine(.sub10+!ARAMC, 1)
%CallSubroutine(.sub9+!ARAMC, 1)
%CallSubroutine(.sub8+!ARAMC, 1)
%CallSubroutine(.sub9+!ARAMC, 1)
%CallSubroutine(.sub10+!ARAMC, 1)
%CallSubroutine(.sub9+!ARAMC, 1)
%CallSubroutine(.sub13+!ARAMC, 2)
%CallSubroutine(.sub14+!ARAMC, 2)
%CallSubroutine(.sub13+!ARAMC, 2)
%CallSubroutine(.sub18+!ARAMC, 1)
%CallSubroutine(.sub15+!ARAMC, 4)
%CallSubroutine(.sub16+!ARAMC, 4)
%CallSubroutine(.sub17+!ARAMC, 4)
%CallSubroutine(.sub16+!ARAMC, 4)
%CallSubroutine(.sub15+!ARAMC, 4)
%CallSubroutine(.sub16+!ARAMC, 4)
%CallSubroutine(.sub17+!ARAMC, 4)
%CallSubroutine(.sub16+!ARAMC, 4)
%CallSubroutine(.sub11+!ARAMC, 3)
%CallSubroutine(.sub12+!ARAMC, 1)
db $00 ; End of the channel

.sub8
db G3, Tie, D3, G3, Tie, D3, A3s, D3
db $00 ; End

.sub9
db G3, Tie, D3s, G3, Tie, D3s, A3s, D3s
db $00 ; End

.sub10
db G3, Tie, E3, G3, Tie, E3, A3s, E3
db $00 ; End

.sub11
db D3, D3, Tie, D3, Tie, D3, $48, D3, Tie, $24, D3, Tie, F3s, Tie, A3, Tie
db $00 ; End

.sub12
db D3, D3, Tie, D3, Tie, D3, D3, Tie, Tie, Tie, Tie, F3s, Tie, Tie, A3, Tie
db $00 ; End

.sub13
db D3, A3, F3s, D3, Tie, C4, A3, Tie
db $00 ; End

.sub14
db F3, C4, G3s, F3, Tie, C4, G3s, Tie
db $00 ; End

.sub15
db G3, D3, G3, A3s
db $00 ; End

.sub16
db F3, C3, F3, G3s
db $00 ; End

.sub17
db E3, B3, E3, G3
db $00 ; End

.sub18
db F3s, F3s, Tie, F3s, Tie, F3s, F3s, F3s, F3s, F3s, Tie, D3, Tie, F3s, Tie, D3
db $00 ; End


.Channel2
%CallSubroutine(.sub8+!ARAMC, 1)
%CallSubroutine(.sub9+!ARAMC, 1)
%CallSubroutine(.sub10+!ARAMC, 1)
%CallSubroutine(.sub9+!ARAMC, 1)
%CallSubroutine(.sub8+!ARAMC, 1)
%CallSubroutine(.sub9+!ARAMC, 1)
%CallSubroutine(.sub10+!ARAMC, 1)
%CallSubroutine(.sub9+!ARAMC, 1)
%CallSubroutine(.sub11+!ARAMC, 3)
%CallSubroutine(.sub12+!ARAMC, 1)
%CallSubroutine(.sub8+!ARAMC, 1)
%CallSubroutine(.sub9+!ARAMC, 1)
%CallSubroutine(.sub10+!ARAMC, 1)
%CallSubroutine(.sub9+!ARAMC, 1)
%CallSubroutine(.sub8+!ARAMC, 1)
%CallSubroutine(.sub9+!ARAMC, 1)
%CallSubroutine(.sub10+!ARAMC, 1)
%CallSubroutine(.sub9+!ARAMC, 1)
%CallSubroutine(.sub13+!ARAMC, 2)
%CallSubroutine(.sub14+!ARAMC, 2)
%CallSubroutine(.sub13+!ARAMC, 2)
%CallSubroutine(.sub18+!ARAMC, 1)
%CallSubroutine(.sub15+!ARAMC, 4)
%CallSubroutine(.sub16+!ARAMC, 4)
%CallSubroutine(.sub17+!ARAMC, 4)
%CallSubroutine(.sub16+!ARAMC, 4)
%CallSubroutine(.sub15+!ARAMC, 4)
%CallSubroutine(.sub16+!ARAMC, 4)
%CallSubroutine(.sub17+!ARAMC, 4)
%CallSubroutine(.sub16+!ARAMC, 4)
%CallSubroutine(.sub11+!ARAMC, 3)
%CallSubroutine(.sub12+!ARAMC, 1)
db $00 ; End of the channel


.Channel3
%SetInstrument($09) ; Strings
%SetDurationN($24, $7F) ; 1/8
%CallSubroutine(.sub25+!ARAMC, 1)
%CallSubroutine(.sub26+!ARAMC, 1)
%CallSubroutine(.sub27+!ARAMC, 1)
%CallSubroutine(.sub26+!ARAMC, 1)
%CallSubroutine(.sub25+!ARAMC, 1)
%CallSubroutine(.sub26+!ARAMC, 1)
%CallSubroutine(.sub27+!ARAMC, 1)
%CallSubroutine(.sub26+!ARAMC, 1)
%CallSubroutine(.sub28+!ARAMC, 3)
%CallSubroutine(.sub29+!ARAMC, 1)
%CallSubroutine(.sub25+!ARAMC, 1)
%CallSubroutine(.sub26+!ARAMC, 1)
%CallSubroutine(.sub27+!ARAMC, 1)
%CallSubroutine(.sub26+!ARAMC, 1)
%CallSubroutine(.sub25+!ARAMC, 1)
%CallSubroutine(.sub26+!ARAMC, 1)
%CallSubroutine(.sub27+!ARAMC, 1)
%CallSubroutine(.sub26+!ARAMC, 1)
%CallSubroutine(.sub30+!ARAMC, 2)
%CallSubroutine(.sub31+!ARAMC, 2)
%CallSubroutine(.sub30+!ARAMC, 2)
%CallSubroutine(.sub32+!ARAMC, 1)
db $12
%CallSubroutine(.sub33+!ARAMC, 4)
%CallSubroutine(.sub34+!ARAMC, 4)
%CallSubroutine(.sub33+!ARAMC, 4)
%CallSubroutine(.sub34+!ARAMC, 4)
%CallSubroutine(.sub33+!ARAMC, 4)
%CallSubroutine(.sub34+!ARAMC, 4)
%CallSubroutine(.sub33+!ARAMC, 4)
%CallSubroutine(.sub34+!ARAMC, 4)
db $24
%CallSubroutine(.sub35+!ARAMC, 3)
%CallSubroutine(.sub36+!ARAMC, 1)
db $00 ; End of the channel

.sub25
db D3, A2s, G2, D3, A2s, G2, D3, A2s
db $00 ; End

.sub26
db D3s, A2s, G2, D3s, A2s, G2, D3s, A2s
db $00 ; End

.sub27
db E3, A2s, G2, E3, A2s, G2, E3, A2s
db $00 ; End

.sub28
db $48, D2, Tie, Tie, D2, Tie, Tie, Tie, Tie
db $00 ; End

.sub29
db $24, D2, Tie, Tie, Tie, Tie, Tie, D2, Tie, Tie, Tie, Tie, Tie, F2s, Tie, Tie, F2s, Tie
db $00 ; End

.sub30
db F3s, C3, A2, F3s, C3, Tie, F3s, C3
db $00 ; End

.sub31
db G2s, C3, F3, G2s, C3, F3, G2s, C3
db $00 ; End

.sub32
db A2, A2, Tie, A2, Tie, Tie, Tie, Tie, A2, A2, Tie, A2, Tie, D3, Tie, F3s
db $00 ; End

.sub33
db G2, A2s, D3, G3, A3s, G3, D3, A2s
db $00 ; End

.sub34
db G2s, C3, F3, G3s, C4, G3s, F3, C3
db $00 ; End

.sub35
db $24, F3s, $48, F3s, F3s, $24, F3s, $48, F3s, Tie, Tie, Tie, Tie
db $00 ; End

.sub36
db $24, F3s, F3s, Tie, F3s, Tie, F3s, F3s, Tie, Tie, Tie, Tie, $48, F3s, Tie, F3s, Tie
db $00 ; End


.Channel4
%SetInstrument($18) ; Guitar
%SetDurationN($24, $7F) ; 1/8
%CallSubroutine(.sub25+!ARAMC, 1)
%CallSubroutine(.sub26+!ARAMC, 1)
%CallSubroutine(.sub27+!ARAMC, 1)
%CallSubroutine(.sub26+!ARAMC, 1)
%CallSubroutine(.sub25+!ARAMC, 1)
%CallSubroutine(.sub26+!ARAMC, 1)
%CallSubroutine(.sub27+!ARAMC, 1)
%CallSubroutine(.sub26+!ARAMC, 1)
%CallSubroutine(.sub28+!ARAMC, 3)
%CallSubroutine(.sub29+!ARAMC, 1)
%CallSubroutine(.sub25+!ARAMC, 1)
%CallSubroutine(.sub26+!ARAMC, 1)
%CallSubroutine(.sub27+!ARAMC, 1)
%CallSubroutine(.sub26+!ARAMC, 1)
%CallSubroutine(.sub25+!ARAMC, 1)
%CallSubroutine(.sub26+!ARAMC, 1)
%CallSubroutine(.sub27+!ARAMC, 1)
%CallSubroutine(.sub26+!ARAMC, 1)
%CallSubroutine(.sub30+!ARAMC, 2)
%CallSubroutine(.sub31+!ARAMC, 2)
%CallSubroutine(.sub30+!ARAMC, 2)
%CallSubroutine(.sub32+!ARAMC, 1)
db $12
%CallSubroutine(.sub33+!ARAMC, 4)
%CallSubroutine(.sub34+!ARAMC, 4)
%CallSubroutine(.sub33+!ARAMC, 4)
%CallSubroutine(.sub34+!ARAMC, 4)
%CallSubroutine(.sub33+!ARAMC, 4)
%CallSubroutine(.sub34+!ARAMC, 4)
%CallSubroutine(.sub33+!ARAMC, 4)
%CallSubroutine(.sub34+!ARAMC, 4)
db $24
%CallSubroutine(.sub35+!ARAMC, 3)
%CallSubroutine(.sub36+!ARAMC, 1)
db $00 ; End of the channel


<<<<<<< Updated upstream

=======
>>>>>>> Stashed changes
print pc