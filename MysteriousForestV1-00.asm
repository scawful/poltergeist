;=====================================================================================
; The Legend of Zelda: A Link to the Past (Custom Music Track)
; The Legend of Zelda: Link's Awakening - Mysterious Forest v1.00
; Original Song by Koji Kondo
; Midi by MrData
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
MysteriousForestTheme:
!ARAMAddr = $D0FF
dw !ARAMAddr+$0A ; Intro
dw !ARAMAddr+$1A ; Looping
dw $00FF
dw !ARAMAddr+$02 ; Looping Section
dw $0000

.ChannelsIntro
!ARAMC = !ARAMAddr-MysteriousForestTheme
dw .Channel0Intro+!ARAMC
dw $0000
dw $0000
dw $0000
dw .Channel4Intro+!ARAMC
dw $0000
dw $0000
dw $0000

.Channels
!ARAMC = !ARAMAddr-MysteriousForestTheme
dw .Channel0+!ARAMC
dw .Channel1+!ARAMC
dw .Channel2+!ARAMC
dw .Channel3+!ARAMC
dw .Channel4+!ARAMC
dw .Channel5+!ARAMC
dw $0000
dw $0000


.Channel0Intro
%SetMasterVolume($AF)
%SetTempo(116);
%SetInstrument($18) ; Guitar
%SetDurationN($24, $7F) ; 1/4
%CallSubroutine(.sub1+!ARAMC, 1)
db $00 ; End of the channel

.sub1
db $48, G2, D3, $24, F3, F3s, Tie, G3, $48, Tie, Tie, Tie, $24, F2, F2s, $48, G2, $24, D3, $48, F3, F3s, G3, Tie, Tie, $24, Tie, F2, F2s
db $00 ; End

.Channel4Intro
%SetInstrument($09) ; Strings
%SetDurationN($24, $7F) ; 1/4
%CallSubroutine(.sub1+!ARAMC, 1)
db $00 ; End of the channel



.Channel0
%CallSubroutine(.sub1+!ARAMC, 1)
%CallSubroutine(.sub2+!ARAMC, 1)
%CallSubroutine(.sub1+!ARAMC, 1)
%CallSubroutine(.sub2+!ARAMC, 1)
%CallSubroutine(.sub1+!ARAMC, 1)
%CallSubroutine(.sub2+!ARAMC, 1)
%CallSubroutine(.sub1+!ARAMC, 1)
%CallSubroutine(.sub2+!ARAMC, 1)
db $00 ; End of the channel

.sub2
db $48, G2s, D3s, $24, F3s, G3, Tie, G3s, $48, Tie, Tie, Tie, $24, F2s, G2, $48, G2s, $24, D3s, $48, F3s, G3, G3s, Tie, Tie, $24, Tie, F2s, G2
db $00 ; End



.Channel1
%SetInstrument($09) ; Strings
%SetDurationN($48, $7F) ; 1/4
%CallSubroutine(.sub4+!ARAMC, 2)
%CallSubroutine(.sub3+!ARAMC, 64)
db $00 ; End of the channel

.sub3
db Tie
db $00 ; End

.sub4
db G4, Tie, Tie, Tie, D4, Tie, Tie, Tie, Tie, Tie, Tie, Tie, Tie, Tie, $12, G4, F4s, G4, A4, A4s, A4, A4s, C5, $24, D5, Tie, Tie, D5s, Tie, Tie, F5, Tie, $48, G5, Tie, Tie, Tie, Tie, Tie, Tie, F5, D5s, $24, Tie, C5, $48, Tie, G4s
db $00 ; End



.Channel2
%SetChannelVolume($9A)
%SetInstrument($18) ; Guitar
%SetDurationN($12, $7F) ; 1/16
%CallSubroutine(.sub5+!ARAMC, 32)
%CallSubroutine(.sub6+!ARAMC, 32)
%CallSubroutine(.sub5+!ARAMC, 32)
%CallSubroutine(.sub6+!ARAMC, 32)
%CallSubroutine(.sub7+!ARAMC, 32)
%CallSubroutine(.sub8+!ARAMC, 32)
%CallSubroutine(.sub9+!ARAMC, 32)
%CallSubroutine(.sub10+!ARAMC, 32)
db $00 ; End of the channel

.sub5
db A4s, C5
db $00 ; End

.sub6
db C5, D5
db $00 ; End

.sub7
db A4s, G4
db $00 ; End

.sub8
db A4, F4
db $00 ; End

.sub9
db A4s, D4s
db $00 ; End

.sub10
db A4, E4
db $00 ; End


.Channel3
%SetInstrument($18) ; Guitar
%SetDurationN($48, $7F) ; 1/4
db Rest
%CallSubroutine(.sub3+!ARAMC, 63)
%CallSubroutine(.sub11+!ARAMC, 1)
db $00 ; End of the channel

.sub11
db G5, Tie, Tie, Tie, Tie, Tie, Tie, Tie, D5, Tie, Tie, Tie, Tie, Tie, Tie, Tie, D5s, Tie, Tie, Tie, Tie, Tie, Tie, Tie, E5, Tie, Tie, Tie, Tie, Tie, Tie, Tie, F5, Tie, Tie, Tie, Tie, Tie, Tie, Tie, Tie, Tie, Tie, Tie, Tie, Tie, Tie, Tie, F5s, Tie, Tie, Tie, Tie, Tie, Tie, Tie, Tie, Tie, Tie, Tie, Tie, Tie, Tie, Tie
db $00 ; End



.Channel4
%CallSubroutine(.sub1+!ARAMC, 1)
%CallSubroutine(.sub2+!ARAMC, 1)
%CallSubroutine(.sub1+!ARAMC, 1)
%CallSubroutine(.sub2+!ARAMC, 1)
%CallSubroutine(.sub1+!ARAMC, 1)
%CallSubroutine(.sub2+!ARAMC, 1)
%CallSubroutine(.sub1+!ARAMC, 1)
%CallSubroutine(.sub2+!ARAMC, 1)
db $00 ; End of the channel



.Channel5
%SetInstrument($18) ; Guitar
%SetDurationN($48, $7F) ; 1/4
%CallSubroutine(.sub4+!ARAMC, 2)
%CallSubroutine(.sub3+!ARAMC, 64)
db $00 ; End of the channel



print pc