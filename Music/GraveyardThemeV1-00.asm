;=====================================================================================
; The Legend of Zelda: A Link to the Past (Custom Music Track)
; The Legend of Zelda: Four Swords Adventures - Graveyard Theme v1.00
; Original Song by Koji Kondo
; Midi by Forrest Riedl
; ASM Framework by Zarby89
; Ported by Letterbomb
; Size 0x27A
;=====================================================================================

org $1ABE66; Sections?
GraveyardTheme:
!ARAMAddr = $EF6D
dw !ARAMAddr+$0A ; Intro
dw !ARAMAddr+$1A ; Looping
dw $00FF
dw !ARAMAddr+$02 ; Looping Section
dw $0000

.ChannelsIntro
!ARAMC = !ARAMAddr-GraveyardTheme
dw .Channel0Intro+!ARAMC
dw .Channel1Intro+!ARAMC
dw $0000
dw $0000
dw .Channel4Intro+!ARAMC
dw $0000
dw $0000
dw $0000

.Channels
!ARAMC = !ARAMAddr-GraveyardTheme
dw .Channel0+!ARAMC
dw .Channel1+!ARAMC
dw .Channel2+!ARAMC
dw .Channel3+!ARAMC
dw .Channel4+!ARAMC
dw .Channel5+!ARAMC
dw $0000
dw $0000


.Channel0Intro
%SetMasterVolume($7F)
%SetChannelVolume($7F)
%SetTempo(40);
%SetInstrument($18) ; Guitar
%SetDurationN($48, $7F) ; 1/4
%CallSubroutine(.sub0+!ARAMC, 1)
db $00 ; End of the channel


.Channel1Intro
%SetChannelVolume($79)
%SetInstrument($09) ; Strings
%SetDurationN($48, $7F) ; 1/4
%CallSubroutine(.sub1+!ARAMC, 1)
db $00 ; End of the channel


.Channel4Intro
%SetChannelVolume($65)
%SetInstrument($18) ; Guitar
%SetDurationN($48, $7F) ; 1/4
%CallSubroutine(.sub0+!ARAMC, 1)
db $00 ; End of the channel


.Channel0
%SetDurationN($12, $7F) ; 1/16
%CallSubroutine(.sub2+!ARAMC, 80)
db $48, C1s
%CallSubroutine(.sub5+!ARAMC, 23)
db C1s
%CallSubroutine(.sub5+!ARAMC, 7)
db C1s
%CallSubroutine(.sub5+!ARAMC, 3)
db C1s
%CallSubroutine(.sub5+!ARAMC, 3)
db C2s
%CallSubroutine(.sub5+!ARAMC, 3)
db C1s
%CallSubroutine(.sub5+!ARAMC, 3)
db $00 ; End of the channel

.sub0
db C1s, Tie, Tie, Tie
db $00 ; End

.sub1
db C2s, Tie, Tie, Tie
db $00 ; End

.sub2
db D3s, D3
db $00 ; End


.Channel1
%SetDurationN($48, $7F) ; 1/4
db C1s, Tie, Tie, Tie
%SetDurationN($12, $7F) ; 1/16
%CallSubroutine(.sub3+!ARAMC, 12)
%CallSubroutine(.sub4+!ARAMC, 4)
db $48, C1s, Tie, Tie, Tie
%SetDurationN($12, $7F) ; 1/16
%CallSubroutine(.sub3+!ARAMC, 12)
%CallSubroutine(.sub4+!ARAMC, 4)
db $48, C2s
%CallSubroutine(.sub5+!ARAMC, 9)
db $12
%CallSubroutine(.sub6+!ARAMC, 4)
%CallSubroutine(.sub3+!ARAMC, 4)
%CallSubroutine(.sub4+!ARAMC, 4)
db $48, C1s
%CallSubroutine(.sub5+!ARAMC, 15)
db C1s
%CallSubroutine(.sub5+!ARAMC, 7)
db C1s
%CallSubroutine(.sub5+!ARAMC, 7)
db C1s
%CallSubroutine(.sub5+!ARAMC, 3)
db C1s
%CallSubroutine(.sub5+!ARAMC, 3)
db C2s
%CallSubroutine(.sub5+!ARAMC, 3)
db C1s
%CallSubroutine(.sub5+!ARAMC, 3)
db $00 ; End of the channel

.sub3
db E3, D3s
db $00 ; End

.sub4
db D3, C3s
db $00 ; End

.sub5
db Tie
db $00 ; End

.sub6
db F3s, F3
db $00 ; End



.Channel2
%SetChannelVolume($59)
%SetInstrument($0E) ; Chime
%SetDurationN($48, $7F) ; 1/4
db Rest
%CallSubroutine(.sub5+!ARAMC, 7)
%SetDurationN($24, $7F) ; 1/8
db D4, $09, Tie, G4s, Tie, Tie, $48
%CallSubroutine(.sub5+!ARAMC, 11)
db $24, G4, $09, Tie, A3s, Tie, Tie, $48
%CallSubroutine(.sub5+!ARAMC, 10)
db $24, D4, $09, Tie, Tie, $48, B4, $09, F4s, Tie, $48, Tie, Tie, Tie, G4, Tie, F4, G4, C4s
%CallSubroutine(.sub5+!ARAMC, 39)
db D3s, Tie, Tie, Tie, C3, Tie, Tie, Tie
db $00 ; End of the channel



.Channel3
%SetChannelVolume($60)
%SetInstrument($02) ; Tympani
%SetDurationN($48, $7F) ; 1/4
db Rest
%CallSubroutine(.sub5+!ARAMC, 39)
db $12, C1s, C1s, C1s, $48, C1s
%CallSubroutine(.sub7+!ARAMC, 5)
db $12, C1s, $12, E1, E1, E1, $48, E1, $12, E1, E1, E1, E1, $48, E1, $12, E1, $12, D2, D2, D2, $48, D2
%CallSubroutine(.sub8+!ARAMC, 3)
db $12, D2, E2, E2, E2, $48, E2
%CallSubroutine(.sub9+!ARAMC, 3)
db $12, E2, $09, F2s, F2s, $12, F2s, F2s, $24, F2s, F2s, $12, F2s, F2s, F2s, F2s, $24, F2s, F2s, $12, F2s, $12, G2, G2, G2, $24, G2, G2, $12, G2, G2, G2, G2, $24, G2, G2, $12, G2
%CallSubroutine(.sub10+!ARAMC, 16)
%CallSubroutine(.sub11+!ARAMC, 16)
db $00 ; End of the channel

.sub7
db $12, C1s, C1s, C1s, C1s, $48, C1s
db $00 ; End

.sub8
db $12, D2, D2, D2, D2, $48, D2
db $00 ; End

.sub9
db $12, E2, E2, E2, E2, $48, E2
db $00 ; End

.sub10
db C2
db $00 ; End

.sub11
db B1
db $00 ; End



.Channel4
%SetDurationN($48, $7F) ; 1/4
db C1s
%CallSubroutine(.sub5+!ARAMC, 23)
db C2s
%CallSubroutine(.sub5+!ARAMC, 23)
%CallSubroutine(.sub12+!ARAMC, 1)
db D3
%CallSubroutine(.sub13+!ARAMC, 1)
%CallSubroutine(.sub12+!ARAMC, 1)
db F3
%CallSubroutine(.sub13+!ARAMC, 1)
%CallSubroutine(.sub12+!ARAMC, 1)
db G3
%CallSubroutine(.sub13+!ARAMC, 1)
db G2, A2s, C3, A2s, G2, A2s, C3, D3, F3, G3s, F3, D3, C3, A2s, C3, A2s
%CallSubroutine(.sub14+!ARAMC, 32)
%CallSubroutine(.sub15+!ARAMC, 8)
%CallSubroutine(.sub16+!ARAMC, 8)
db $48, C1s
%CallSubroutine(.sub5+!ARAMC, 7)
db $00 ; End of the channel

.sub12
db $09, G2, A2s, C3, A2s, G2, A2s, C3, D3, D3s
db $00 ; End

.sub13
db D3s, D3, C3, A2s, C3, A2s
db $00 ; End

.sub14
db C4s, D4s, F4s, C5
db $00 ; End

.sub15
db D4s, F4s, G4s, C5s
db $00 ; End

.sub16
db F4s, G4s, A4s, D5s
db $00 ; End



.Channel5
%SetChannelVolume($70)
%SetInstrument($11) ; Trumpet
%SetDurationN($48, $7F) ; 1/4
db Rest
%CallSubroutine(.sub5+!ARAMC, 55)
db D4s, $24, Tie, $12, C4s, D4s, $48, F4, $24, Tie, G3s, $48, G4, $24, Tie, $12, F4, D4s, A4s, $24, Tie, G4s, $12, Tie, G4s, A4s, $48, G4, Tie, Tie, $24, Tie, $12, F4, D4s, $48, F4, C4, $24, Tie, D4s, $12, C4s, D4s, F4, G4, G4s, Tie, $48, Tie, $12, C4s, C4, G4s, $24, Tie, G4s, $12, D4s, F4, G4, D5s, Tie, $48, Tie, $12, D4s, F4, F4s, Tie, $48, Tie, $24, F5, $48, F5s, Tie, Tie, Tie
%SetChannelVolume($50)
db G5, Tie, Tie, Tie
db $00 ; End of the channel



print pc
