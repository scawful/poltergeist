
;=====================================================================================
; The Legend of Zelda: A Link to the Past (Custom Music Track)
; Etrian Odyssey III: The Drowned City - Calling That Detestable Name Theme v1.00
; Original Song by Yuzo Koshiro
; Midi by Kiku
; ASM Framework by Zarby89
; Ported by Letterbomb
;=====================================================================================

lorom

; Test code to play the song as the game start (Only for Testing)
!n = $7F
org $00FFD7; Set rom on 16mb
db #$0B
org $3FFFFF; write at the last position to expand on 2mb
db #$00
org $0CC120
LDA #$02 : STA $012C
STA $2140 : STA $0133 : STA $0130
RTL

incsrc yourfilename.asm

org $1A9FF8; Sections?
CallingThatDetestableNameTheme:
!ARAMAddr = $D0FF
dw !ARAMAddr+$08
dw $00FF
dw !ARAMAddr
dw $0000


.Channels
!ARAMC = !ARAMAddr-CallingThatDetestableNameTheme
dw .Channel0+!ARAMC
dw .Channel1+!ARAMC
dw .Channel2+!ARAMC
dw .Channel3+!ARAMC
dw .Channel4+!ARAMC
dw .Channel5+!ARAMC
dw $0000
dw $0000



.Channel0
%SetMasterVolume($CF)
%SetChannelVolume($C0)
%SetTempo(114);
%SetInstrument($09) ; Strings
%SetDurationN($24, $7F) ; 1/8
%CallSubroutine(.sub1+!ARAMC, 8)
%CallSubroutine(.sub2+!ARAMC, 3)
%CallSubroutine(.sub3+!ARAMC, 1)
%CallSubroutine(.sub2+!ARAMC, 3)
%CallSubroutine(.sub4+!ARAMC, 1)
%CallSubroutine(.sub2+!ARAMC, 3)
%CallSubroutine(.sub3+!ARAMC, 1)
%CallSubroutine(.sub2+!ARAMC, 3)
%CallSubroutine(.sub4+!ARAMC, 1)
%CallSubroutine(.sub5+!ARAMC, 2)
%CallSubroutine(.sub6+!ARAMC, 2)
%CallSubroutine(.sub7+!ARAMC, 2)
db $48, Rest
%CallSubroutine(.sub8+!ARAMC, 100)
db $00 ; End of the channel


.sub1
db E2, G2, B2, E2, G2, A2s, E2, G2, B2, E2, G2, A2s, E2, G2, C3, Tie, E2, G2, B2, E2, G2, A2s, E2, G2, B2, E2, G2, A2s, E2, G2, D3, Tie
db $00 ; End


.sub2
db $48, D3s, Tie, $24, G3s, F3s, F3, D3s
db $00 ; End


.sub3
db D3s, Tie, Tie, D3, Tie, Tie, F3, Tie
db $00 ; End


.sub4
db D3, F3, D3s, F3s, A3s, G3s, F3, G3s
db $00 ; End


.sub5
db G2, A2s, Tie, G2, A2s, Tie, G2, A2s, Tie, G2, A2s, Tie, A2s, C3, Tie, Tie, G2, A2s, Tie, G2, A2s, Tie, G2, A2s, Tie, G2, A2s, Tie, A2s, D3, Tie, Tie
db $00 ; End


.sub6
db E2, G2, Tie, E2, G2, Tie, E2, G2, Tie, E2, G2, Tie, G2, A2, Tie, Tie, E2, G2, Tie, E2, G2, Tie, E2, G2, Tie, E2, G2, Tie, G2, B2, Tie, Tie
db $00 ; End


.sub7
db F2, G2s, Tie, F2, G2s, Tie, F2, G2s, Tie, F2, G2s, Tie, G2s, A2s, Tie, Tie, F2, G2s, Tie, F2, G2s, Tie, F2, G2s, Tie, F2, G2s, Tie, G2s, C3, Tie, Tie
db $00 ; End



.Channel1
%SetChannelVolume($A0)
%SetInstrument($09) ; Strings
%SetDurationN($48, $7F) ; 1/4
db Rest
%CallSubroutine(.sub8+!ARAMC, 127)
db $24
%CallSubroutine(.sub9+!ARAMC, 4)
db $24, Rest
%CallSubroutine(.sub8+!ARAMC, 125)
db $48, Rest, $12, G4s, Tie, $24, Tie, Tie, $12, F4, $48, Tie, Tie, $12, Tie, A4s, G4s, G4, F4, G4s, G4, F4, D4s, A4s, G4s, G4, F4, C5, A4s, G4s, G4, D5, C5, A4s, C5, G4, F4, D4s, F4, D5, C5, A4s, C5, G5, F5, D5s, F5, A5s, G5s, G5, G5s, G5, F5, D5s, F5, A5s, G5s, G5, G5s, D6, C6, A5s, C6, A5s, G5, F5, G5, G5s, G5, F5, D5s, G5, F5, D5s, F5, G5s, F5, D5s, D5, F5, D5s, D5, C5, D5s, D5, C5, A4s, D5, C5, A4s, G4s, C5, A4s, G4s, G4, A4s, G4s, G4, G4s, F4, D4s, D4, D4s, D4, C4, A3s, C4, D4, D4s, F4, G4, A4s, G4s, G4, G4s, C5, A4s, G4s, A4s, D5, C5, D5, D5s, F5, D5s, F5, G5
db $00 ; End of the channel

.sub8
db Tie
db $00 ; End

.sub9
db F4s, B4, D5s, B4, F5, B4, F5s, B4, F4s, A4s, D5s, A4s, F5, A4s, F5s, A4s, F4s, A4, D5s, A4, F5, A4, F5s, A4, F4s, A4s, D5s, A4s, F5, A4s, F5s, A4s
db $00 ; End



.Channel2
%SetChannelVolume($A0)
%SetInstrument($09) ; Strings
%SetDurationN($48, $7F) ; 1/4
db Rest
%CallSubroutine(.sub8+!ARAMC, 159)
%CallSubroutine(.sub15+!ARAMC, 3)
%CallSubroutine(.sub16+!ARAMC, 1)
%CallSubroutine(.sub15+!ARAMC, 3)
%CallSubroutine(.sub23+!ARAMC, 1)
db $48, C6, Tie, Tie, Tie, $12, C6, A5s, G5s, A5s, C6, A5s, G5s, A5s, C6, A5s, G5s, A5s, C6, A5s, G5s, A5s,  $24, C6, G5, A5s, F5, G5, D5s, F5, D5, D5s, C5, D5, A4s, C5, G4, A4s, D5, $12, D5s, D5, C5, D5, D5s, D5, C5, D5, D5s, D5, C5, D5, F5, D5s, D5, C5, D5s, D5, C5, D5, D5s, D5, C5, D5, D5s, D5, C5, D5, G5, F5, D5s, D5, D5s, D5, C5, D5, F5, D5s, D5, C5, D5s, D5, C5, D5, G5, F5, D5s, D5, G5s, G5, F5, D5s, A5s, G5s, G5, F5, C6, A5s, G5s, G5, D6, C6, A5s, C6
db $48, Rest
%CallSubroutine(.sub8+!ARAMC, 400)
db $00 ; End of the channel

.sub15
db $48, D5s, Tie, $24, G5s, F5s, F5, D5s
db $00 ; End

.sub16
db D5s, Tie, Tie, D5, Tie, Tie, F5, Tie
db $00 ; End

.sub23
db D5, F5, D5s, F5s, A5s, G5s, F5, G5s
db $00 ; End



.Channel3
%SetChannelVolume($A2)
%SetInstrument($12) ; Horn
%SetDurationN($48, $7F) ; 1/4
db Rest
%CallSubroutine(.sub8+!ARAMC, 31)
%CallSubroutine(.sub10+!ARAMC, 1)
%CallSubroutine(.sub11+!ARAMC, 1)
%CallSubroutine(.sub10+!ARAMC, 1)
%CallSubroutine(.sub12+!ARAMC, 1)
%CallSubroutine(.sub10+!ARAMC, 1)
%CallSubroutine(.sub11+!ARAMC, 1)
%CallSubroutine(.sub10+!ARAMC, 1)
%CallSubroutine(.sub12+!ARAMC, 1)
db $48, Rest
%CallSubroutine(.sub8+!ARAMC, 127)
db A4, Tie, Tie, Tie, $12, G4, F4, E4, D4, F4, E4, D4, C4, E4, D4, C4, B3, D4, C4, B3, G3, $24, C4, A3, B3, G3, A3, E3, G3, D3, E3, C4, B3, C4, F3, D4, A3, G4, E4, Tie, Tie, G3, Tie, Tie, $48, D4, Tie, Tie, $12, D4, C4, B3, A3, G4, F4, E4, D4, $24, E4, G3, D4, E4, Tie, D4, G4, Tie, E4, A4, Tie, E4, B4, E4, C5, A4, $48, Rest
%CallSubroutine(.sub8+!ARAMC, 400)
db $00 ; End of the channel

.sub10
db $24, B3, E4, G4, D5, $48, Tie, Tie, Tie, Tie, Tie, Tie
db $00 ; End

.sub11
db $24, B3, E4, G4, C5s, $48, Tie, Tie, Tie, Tie, Tie, Tie
db $00 ; End

.sub12
db $24, B3, E4, G4, A4s, $48, Tie, Tie, Tie, Tie, Tie, Tie
db $00 ; End



.Channel4
%SetChannelVolume($B0)
%SetInstrument($18) ; Guitar
%SetDurationN($24, $7F) ; 1/8
%CallSubroutine(.sub1+!ARAMC, 8)
%CallSubroutine(.sub19+!ARAMC, 4)
%CallSubroutine(.sub20+!ARAMC, 2)
%CallSubroutine(.sub21+!ARAMC, 2)
%CallSubroutine(.sub22+!ARAMC, 2)
db $48, Rest
%CallSubroutine(.sub8+!ARAMC, 400)
db $00 ; End of the channel

.sub18
db E1, G1, B1, E1, G1, A1, E1, G1, B1, E1, G1, A1, E1, G1, C2, Tie, E1, G1, B1, E1, G1, A1, E1, G1, B1, E1, G1, A1, E1, G1, D2, Tie
db $00 ; End

.sub19
db B1, B2, B1, B2, B1, B2, B1, B2, A1s, A2s, A1s, A2s, A1s, A2s, A1s, A2s, A1, A2, A1, A2, A1, A2, A1, A2, A1s, A2s, A1s, A2s, A1s, A2s, A1s, A2s
db $00 ; End

.sub20
db C2, D2s, G2, C2, D2s, F2, C2, D2s, G2, C2, D2s, F2, C2, D2s, G2s, Tie, C2, D2s, G2, C2, D2s, F2, C2, D2s, G2, C2, D2s, F2, C2, D2s, A2s, Tie
db $00 ; End

.sub21
db A1, C2, E2, A1, C2, D2, A1, C2, E2, A1, C2, D2, A1, C2, F2, Tie, A1, C2, E2, A1, C2, D2, A1, C2, E2, A1, C2, D2, A1, C2, G2, Tie
db $00 ; End

.sub22
db F1, G1s, C2, F1, G1s, A1s, F1, G1s, C2, F1, G1s, A1s, F1, G1s, C2s, Tie, F1, G1s, C2, F1, G1s, A1s, F1, G1s, C2, F1, G1s, A1s, F1, G1s, D2s, Tie
db $00 ; End



.Channel5
%SetChannelVolume($7B)
%SetInstrument($13) ; Snare
%SetDurationN($24, $7F) ; 1/8
db C3s
%CallSubroutine(.sub13+!ARAMC, 31)
db C3s
%CallSubroutine(.sub13+!ARAMC, 24)
db $12
%CallSubroutine(.sub14+!ARAMC, 1)
db $24, C3s
%CallSubroutine(.sub13+!ARAMC, 31)
db C3s
%CallSubroutine(.sub13+!ARAMC, 31)
db C3s
%CallSubroutine(.sub13+!ARAMC, 31)
db C3s
%CallSubroutine(.sub13+!ARAMC, 24)
db $12
%CallSubroutine(.sub14+!ARAMC, 1)
db $24, C3s
%CallSubroutine(.sub13+!ARAMC, 31)
db C3s
%CallSubroutine(.sub13+!ARAMC, 23)
db $12, F4s
%CallSubroutine(.sub17+!ARAMC, 1)
db $24, C3s
%CallSubroutine(.sub13+!ARAMC, 31)
db C3s
%CallSubroutine(.sub13+!ARAMC, 24)
db $12
%CallSubroutine(.sub14+!ARAMC, 1)
db $24, C3s
%CallSubroutine(.sub13+!ARAMC, 31)
db C3s
%CallSubroutine(.sub13+!ARAMC, 24)
db $12
%CallSubroutine(.sub14+!ARAMC, 1)
db $24, C3s
%CallSubroutine(.sub13+!ARAMC, 31)
db C3s
%CallSubroutine(.sub13+!ARAMC, 23)
db $12, F4s
%CallSubroutine(.sub17+!ARAMC, 1)
db $24, C3s
%CallSubroutine(.sub13+!ARAMC, 31)
db C3s
%CallSubroutine(.sub13+!ARAMC, 23)
db $12, F4s
%CallSubroutine(.sub17+!ARAMC, 1)
db $24, C3s
%CallSubroutine(.sub13+!ARAMC, 31)
db C3s
%CallSubroutine(.sub13+!ARAMC, 24)
db $12
%CallSubroutine(.sub14+!ARAMC, 1)
db $00 ; End of the channel

.sub13
db F4s
db $00 ; End

.sub14
db D3, Tie, B3, B3, B3, Tie, A3, A3, A3, Tie, G3, Tie, G3, Tie
db $00 ; End

.sub17
db D3, D3, D3, C3, D3, F3s, D3, D3, F3s, D3, D3, F3s, D3, D3, D3
db $00 ; End



print pc
