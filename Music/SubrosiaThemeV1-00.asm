;=====================================================================================
; The Legend of Zelda: A Link to the Past (Custom Music Track)
; The Legend of Zelda: Oracle of Seasons - Subrosia Theme v1.00
; Original Song by Kyopi, M-Adachi
; Midi by FireMario
; ASM Framework by Zarby89
; Ported by Letterbomb
; Size Small Enough
;=====================================================================================

org $1AA763; Sections?
SubrosiaTheme:
!ARAMAddr = $D86A
dw !ARAMAddr+$08
dw $00FF
dw !ARAMAddr
dw $0000


.Channels
!ARAMC = !ARAMAddr-SubrosiaTheme
dw .Channel0+!ARAMC
dw .Channel1+!ARAMC
dw .Channel2+!ARAMC
dw .Channel3+!ARAMC
dw $0000
dw $0000
dw $0000
dw $0000



.Channel0
%SetMasterVolume($7F)
%SetTempo(70);
%SetInstrument($09) ; Strings
%SetDurationN($24, $7F) ; 1/8
db B2, Tie, F3, F3s, A3, Tie, G3s, G3, F3, Tie, F3s
%CallSubroutine(.sub1+!ARAMC, 5)
db B2, Tie, F3, F3s, A3, A3, G3s, G3, F3, Tie, F3s
%CallSubroutine(.sub1+!ARAMC, 8)
db F3s, E3, Tie, D3, Tie, $48, C3, Tie, B2, Tie, A2s, Tie, A2, Tie, G2s, Tie, F2s, Tie, C3, $24, Tie, $09, B2, A2s, A2, G2s, G2, F2s, Tie, Tie, $24, Tie, $09, F2, F2s, Tie, Tie, $24, Tie
db $00 ; End of the channel

.sub1
db Tie
db $00 ; End



.Channel1
%SetInstrument($18) ; Guitar
%SetDurationN($48, $7F) ; 1/4
db Rest
%CallSubroutine(.sub2+!ARAMC, 2)
%CallSubroutine(.sub1+!ARAMC, 19)
db $00 ; End of the channel

.sub2
db $48, D3, Tie, D3, Tie, D3, $24, D5, D5, $48, D5s, Tie
db $00 ; End



.Channel2
%SetInstrument($09) ; Strings
%SetDurationN($48, $7F) ; 1/4
%CallSubroutine(.sub1+!ARAMC, 16)
db $24, E4, Tie, Tie, D4, C4, Tie, B3, Tie, $48, A3s, Tie, A3, Tie, G3s, Tie, G3, Tie, F3, $12, F3, F3s, F3, F3s, $24, Tie, $12, F4, F4s, F4, F4s, $24, Tie, G4, $12, A4, G4, $48, F4, F4s, Tie
db $00 ; End of the channel



.Channel3
%SetInstrument($09) ; Strings
%SetDurationN($24, $7F) ; 1/8
db B3, Tie, F4, F4s, A4, Tie, G4s, G4, F4, Tie, F4s
%CallSubroutine(.sub1+!ARAMC, 5)
db B3, Tie, F4, F4s, A4, A4, G4s, G4, F4, Tie, F4s
%CallSubroutine(.sub1+!ARAMC, 8)
db F4s, E4, Tie, D4, Tie, $48, C4, Tie, B3, Tie, A3s, Tie, A3, Tie, G3s, Tie, F3s, Tie, C4, $24, Tie, $09, B3, A3s, A3, G3s, G3, F3s, Tie, Tie, $24, Tie, $09, F3, F3s, Tie, Tie, $24, Tie
db $00 ; End of the channel

print pc