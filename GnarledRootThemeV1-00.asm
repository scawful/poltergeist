;=====================================================================================
; The Legend of Zelda: A Link to the Past (Custom Music Track)
; The Legend of Zelda: Oracle of Seasons - Gnarled Root Theme v1.00
; Original Song by Kyopi, M-Adachi
; Midi by FireMario
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
GnarledRootTheme:
!ARAMAddr = $D0FF
dw !ARAMAddr+$08
dw $00FF
dw !ARAMAddr
dw $0000


.Channels
!ARAMC = !ARAMAddr-GnarledRootTheme
dw .Channel0+!ARAMC
dw .Channel1+!ARAMC
dw .Channel2+!ARAMC
dw .Channel3+!ARAMC
dw .Channel4+!ARAMC
dw .Channel5+!ARAMC
dw $0000
dw $0000



.Channel0
%SetMasterVolume($A5)
%SetTempo(65);
%SetInstrument($09) ; Strings
%SetDurationN($24, $7F) ; 1/8
%CallSubroutine(.sub1+!ARAMC, 1)
db Tie, $48, Tie, Tie, $24
%CallSubroutine(.sub2+!ARAMC, 1)
db Tie, $48, Tie, Tie, $24
%CallSubroutine(.sub1+!ARAMC, 1)
db F4s, $48, Tie, Tie, $24
%CallSubroutine(.sub2+!ARAMC, 1)
db Tie, $48
%CallSubroutine(.sub3+!ARAMC, 33)
db $00 ; End of the channel

.sub1
db F4, F4s, G4, Tie, Tie, F4s, G4, F4s, B3, B3, Tie
db $00 ; End

.sub2
db E4, F4, F4s, Tie, Tie, F4, F4s, F4, A3s, A3s, Tie
db $00 ; End

.sub3
db Tie
db $00 ; End



.Channel1
%SetInstrument($09) ; Strings
%SetDurationN($24, $7F) ; 1/8
%CallSubroutine(.sub4+!ARAMC, 1)
db Tie, $48, Tie, Tie, $24
%CallSubroutine(.sub5+!ARAMC, 1)
db Tie, $48, Tie, Tie, $24
%CallSubroutine(.sub4+!ARAMC, 1)
db F4s, $48, Tie, Tie, $24
%CallSubroutine(.sub5+!ARAMC, 1)
db Tie, $48
%CallSubroutine(.sub3+!ARAMC, 29)
db $12, Tie, C5s, C5, C5s, C5, C5s, C5, Tie, $48, Tie, Tie
db $00 ; End of the channel

.sub4
db B4, C5, C5s, Tie, Tie, C5, C5s, C5, F4, F4, Tie
db $00 ; End

.sub5
db A4, A4s, B4, Tie, Tie, A4s, B4, A4s, E4, E4, Tie
db $00 ; End



.Channel2
%SetInstrument($18) ; Guitar
%SetDurationN($48, $7F) ; 1/4
db Rest
%CallSubroutine(.sub3+!ARAMC, 31)
db $12, B3, A3s, G3s, F3s, $48, F3, Tie, Tie, $09, A3s, B3, $12, A3s, G3s, F3s, $48, F3, Tie, Tie, $12, A3, G3s, F3s, F3, $48, D3s, Tie, Tie, $12, A3, G3s, F3s, F3, $24, D3s, F3, Tie, D3s, F3, Tie, $12, B3, A3s, G3s, F3s, $48, F3, Tie, Tie, $12, B3, A3s, G3s, F3s, $48, F3, Tie, $12, F3, G3, A3, B3, $24, C4, C4, $48, F4s
%CallSubroutine(.sub3+!ARAMC, 5)
db $00 ; End of the channel



.Channel3
%SetInstrument($09) ; Strings
%SetDurationN($48, $7F) ; 1/4
db Rest
%CallSubroutine(.sub3+!ARAMC, 36)
db E3
%CallSubroutine(.sub3+!ARAMC, 6)
db E3
%CallSubroutine(.sub3+!ARAMC, 6)
db E3
%CallSubroutine(.sub3+!ARAMC, 6)
db $12, C5, C5s, C5, C5s, C5, Tie, Tie, Tie, $48
%CallSubroutine(.sub3+!ARAMC, 3)
db $00 ; End of the channel



.Channel4
%SetInstrument($09) ; Strings
%SetDurationN($24, $7F) ; 1/8
%CallSubroutine(.sub6+!ARAMC, 2)
%CallSubroutine(.sub7+!ARAMC, 2)
%CallSubroutine(.sub6+!ARAMC, 2)
%CallSubroutine(.sub7+!ARAMC, 2)
%CallSubroutine(.sub8+!ARAMC, 4)
db A2, A2, Tie, D2s, A2, A2, Tie, D2s, A2, A2, D2, F2, Tie, D2, F2, Tie
%CallSubroutine(.sub8+!ARAMC, 4)
db F2s, F2s, $48, D2
%CallSubroutine(.sub3+!ARAMC, 5)
db $00 ; End of the channel

.sub6
db $24, B2, B2, $48, Tie, Tie, Tie
db $00 ; End

.sub7
db $24, A2s, A2s, $48, Tie, Tie, Tie
db $00 ; End

.sub8
db $24, B2, B2, Tie, F2
db $00 ; End



.Channel5
%SetInstrument($18) ; Guitar
%SetDurationN($24, $7F) ; 1/8
%CallSubroutine(.sub6+!ARAMC, 2)
%CallSubroutine(.sub7+!ARAMC, 2)
%CallSubroutine(.sub6+!ARAMC, 2)
%CallSubroutine(.sub7+!ARAMC, 2)
%CallSubroutine(.sub8+!ARAMC, 4)
db A2, A2, Tie, D2s, A2, A2, Tie, D2s, A2, A2, D2, F2, Tie, D2, F2, Tie
%CallSubroutine(.sub8+!ARAMC, 4)
db F2s, F2s, $48, D2
%CallSubroutine(.sub3+!ARAMC, 5)
db $00 ; End of the channel



print pc