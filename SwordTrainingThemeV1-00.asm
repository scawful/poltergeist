;=====================================================================================
; The Legend of Zelda: A Link to the Past (Custom Music Track)
; The Legend of Zelda: Majora's Mask - Sword School Theme v1.00
; Original Song by Koji Kondo
; Midi by Dehadin
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
SwordSchoolTheme:
!ARAMAddr = $D0FF
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
%SetMasterVolume($AF)
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