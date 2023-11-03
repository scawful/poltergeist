;=====================================================================================
; The Legend of Zelda: A Link to the Past (Custom Music Track)
; The Legend of Zelda: Oracle of Ages - Jabu Jabu's Belly Theme v1.00
; Original Song by Kyopi, M-Adachi
; Midi by FireMario
; ASM Framework by Zarby89
; Ported by Letterbomb
; Size 0xE9
;=====================================================================================

org $1BA308; Sections?
JabuJabuBellyTheme:
!ARAMAddr = $F304
dw !ARAMAddr+$08
dw $00FF
dw !ARAMAddr
dw $0000


.Channels
!ARAMC = !ARAMAddr-JabuJabuBellyTheme
dw .Channel0+!ARAMC
dw .Channel1+!ARAMC
dw .Channel2+!ARAMC
dw .Channel3+!ARAMC
dw $0000
dw $0000
dw $0000
dw $0000



.Channel0
%SetMasterVolume($AF)
%SetChannelVolume($AE)
%SetTempo(88);
%SetInstrument($18) ; Guitar
%SetDurationN($48, $7F) ; 1/4
%CallSubroutine(.sub1+!ARAMC, 3)
%CallSubroutine(.sub2+!ARAMC, 1)
db $00 ; End of the channel

.sub1
db A4, A4s, E5, A4, A4s, E5, A4, A4s, G4, G4s, D5, G4, G4s, D5, G4, G4s
db $00 ; End

.sub2
db B4, C5, F5s, B4, C5, F5s, B4, C5, C5s, D5, G5s, C5s, D5, G5s, C5s, D5
db $00 ; End

.sub3
db B4, C5, F5s, B4, C5, F5s, B4, C5, C5s, D5, G5s, C5s, D5, G5s, C5s, Tie
db $00 ; End


.Channel1
%SetChannelVolume($AE)
%SetInstrument($18) ; Guitar
%SetDurationN($24, $7F) ; 1/8
db Rest, $48, Rest
%CallSubroutine(.sub1+!ARAMC, 3)
%CallSubroutine(.sub3+!ARAMC, 1)
db $00 ; End of the channel



.Channel2
%SetInstrument($18) ; Guitar
%SetDurationN($48, $7F) ; 1/4
%CallSubroutine(.sub4+!ARAMC, 3)
%CallSubroutine(.sub5+!ARAMC, 1)
db $00 ; End of the channel

.sub4
db A2, A2, Tie, Tie, A2, A2, Tie, Tie, G2, G2, Tie, Tie, G2, G2, Tie, Tie

.sub5
db A2s, A2s, Tie, Tie, A2s, A2s, Tie, Tie, B2, B2, Tie, Tie, B2, B2, Tie, Tie


.Channel3
%SetChannelVolume($AA)
%SetInstrument($09) ; Strings
%SetDurationN($48, $7F) ; 1/4
db E4, Tie, D4s, Tie, F4, Tie, E4, Tie, D4, Tie, Tie, $24, C4s, C4, $48, A3s, Tie, G3, Tie, Tie, Tie, A3, Tie, E4, Tie, A4, Tie, A4s, Tie, Tie, Tie, D4s, Tie, E4, Tie
%CallSubroutine(.sub6+!ARAMC, 2)
db C4s, Tie, Tie, Tie, E3, Tie, Tie, Tie
%CallSubroutine(.sub7+!ARAMC, 2)
db D4, Tie, Tie, Tie, F3, Tie, Tie, Tie
db $00 ; End of the channel

.sub6
db A3, E3, F3, C3s
db $00 ; End

.sub7
db B3, F3s, G3, D3s
db $00 ; End



print pc