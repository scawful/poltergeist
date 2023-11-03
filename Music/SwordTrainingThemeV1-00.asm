;=====================================================================================
; The Legend of Zelda: A Link to the Past (Custom Music Track)
; The Legend of Zelda: Majora's Mask - Sword School Theme v1.00
; Original Song by Koji Kondo
; Midi by Dehadin
; ASM Framework by Zarby89
; Ported by Letterbomb
; Size 0xDF
;=====================================================================================


org $1BA1D5; Sections?
SwordSchoolTheme:
!ARAMAddr = $F1D1
dw !ARAMAddr+$08
dw $00FF
dw !ARAMAddr
dw $0000


.Channels
!ARAMC = !ARAMAddr-SwordSchoolTheme
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
%SetTempo(90);
%SetInstrument($02) ; Tympani
%SetDurationN($48, $7F) ; 1/4
%CallSubroutine(.sub2+!ARAMC, 1)
db $00 ; End of the channel

.sub2
db E1, C1s, Tie, $24, C1s, E1, $48, C1s, Tie, $24, E1, E1, Tie, E1, E1, Tie, $48, C1s, Tie, C1s, E1, Tie, C1s, $24, C1s, C1s, $48, E1, C1s, Tie, $24, C1s, E1, $48, C1s, Tie, $24, E1, E1, E1, E1, $48, E1, C1s, Tie, C1s, C1s, Tie, Tie, C1s, E1, Tie, Tie, E1, E1, C1s, Tie, Tie, E1, Tie, Tie, $24, C1s, E1, $48, E1, C1s, Tie, Tie, E1, C1s, Tie, C1s, C1s, Tie, $24, Tie, $48, C1s, E1, E1, C1s, $24, Tie, C1s, E1, $48, C1s, C1s, Tie, C1s, E1, Tie, Tie, E1, E1, Tie, $24, C1s, C1s, C1s, C1s, $48, E1, C1s, C1s, $24, C1s, E1, $48, C1s, Tie, Tie, C1s, E1, Tie, C1s, $24, C1s, E1, C1s, C1s, $48, Tie, Tie, C1s, C1s, Tie, C1s, $24, C1s, E1, $48, E1, Tie, Tie, Tie
db $00 ; End



.Channel1
%SetInstrument($0C) ; Cymbal
%SetDurationN($48, $7F) ; 1/4
db Rest
%CallSubroutine(.sub1+!ARAMC, 13)
db F3
%CallSubroutine(.sub1+!ARAMC, 15)
db F3
%CallSubroutine(.sub1+!ARAMC, 15)
db F3
%CallSubroutine(.sub1+!ARAMC, 15)
db F3
%CallSubroutine(.sub1+!ARAMC, 15)
db F3
%CallSubroutine(.sub1+!ARAMC, 17)
db $00 ; End of the channel

.sub1
db Tie
db $00 ; End



.Channel2
%SetInstrument($02) ; Tympani
%SetDurationN($04, $7F) ; 1/64
db Rest, $48
%CallSubroutine(.sub2+!ARAMC, 1)
db $00 ; End of the channel



print pc