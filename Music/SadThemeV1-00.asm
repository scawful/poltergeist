;=====================================================================================
; The Legend of Zelda: A Link to the Past (Custom Music Track)
; The Legend of Zelda: Oracle of Ages - Sad Theme v1.00
; Original Song by Yoko Shimomura
; Midi by Bubu
; ASM Framework by Zarby89
; Ported by Letterbomb
; Size 0xD7=====================================================================================


org $1AB7D5; Sections?
SadTheme:
!ARAMAddr = $E8DC
dw !ARAMAddr+$08
dw $00FF
dw !ARAMAddr
dw $0000   ;ends at 44


.Channels
!ARAMC = !ARAMAddr-SadTheme
dw .Channel0+!ARAMC
dw .Channel1+!ARAMC
dw .Channel2+!ARAMC
dw $0000
dw $0000
dw $0000
dw $0000
dw $0000



.Channel0
%SetMasterVolume($7F)
%SetTempo(60);
%SetInstrument($18) ; Guitar
%SetDurationN($48, $7F) ; 1/4
db A1s, C2s, G2s, C2s
%CallSubroutine(.sub1+!ARAMC, 1)
db Tie, C2s, G2s, C2s, C2, G2, F2, Tie, $24, A1s, C2, C2s, G2s, $48, G2, D2s, G2s, G2, F2, D2s, C2s, Tie, Tie, Tie, $24, C2, C2s, C2, C2s, $48, C2, C3
%CallSubroutine(.sub2+!ARAMC, 1)
%CallSubroutine(.sub1+!ARAMC, 1)
%CallSubroutine(.sub2+!ARAMC, 1)
db C2, A2s, G2, Tie, A1s, C2, C2s
%CallSubroutine(.sub3+!ARAMC, 2)
db C3, C3s, D3s, $48, Rest, Rest
db $00 ; End of the channel

.sub1
db C2, G2, A2s, C2
db $00 ; End

.sub2
db C2s, G2s, C3, C2s
db $00 ; End

.sub3
db D2s, F2, G2, G2s, A2s
db $00 ; End



.Channel1
%SetInstrument($09) ; Strings
%SetDurationN($48, $7F) ; 1/4
%CallSubroutine(.sub4+!ARAMC, 1)
db Tie
db $00 ; End of the channel

.sub4
db Rest, F3, C4, F3, D3s, A3s, A3s, Tie, Tie, F3, C4, F4, D4s, G3, G3s, D4s, D4s, Tie, C4s, $24, D4s, C4s, $48, C4, A3s, G3s, C4, C4, A3s, G4, F4, E4, Tie, Tie, Tie, Tie, F4, C4, G3s, A3s, D4s, D4s, Tie, Tie, $24, A4s, G4s, G4, F4, D4s, C4s, $48, C4, F4, F4, F4, D4s, Tie, C4s, Tie, Tie, Tie, $24, Tie, D4s, C4s, $48, C4, Tie, A3s, Tie, Tie, Tie, Tie, Tie
db $00 ; End



.Channel2
%SetInstrument($09) ; Strings
%SetDurationN($12, $7F) ; 1/16
db Rest, $48
%CallSubroutine(.sub4+!ARAMC, 1)
db $00 ; End of the channel
