; =================================================================================
; The Legend of Zelda: A Link to the Past (Custom Music Track)
; Earthbound Beginnings
; Original Song by Keiichi Suzuki and Hirokazu Tanaka
; ASM Framework by Zarby89
; Ported by Jeimuzu (4/30/2025)
; Size 0x011E (286 Decimal)
; =================================================================================

; 00 Unknown
; 01 Rain
; 02 Tympani
; 03 Square wave
; 04 Saw wave
; 05 Sine wave
; 06 Double saw wave 1
; 07 Double save wave 2
; 08 Tweet
; 09 Strings
; 0A Same as 9
; 0B Trombone
; 0C Cymbal
; 0D Ocarina
; 0E Chime
; 0F harp
; 10 Splash
; 11 Trumpet
; 12 Horn
; 13 Snare
; 14 Same as 13
; 15 Choir
; 16 Flute
; 17 Oof
; 18 Piano

; =================================================================================

;Test code to play the song as the game start (Only for Testing)
;!n = $7F
;org $00FFD7; Set rom on 16mb
;db #$0B
;org $3FFFFF; write at the last position to expand on 2mb
;db #$00
;org $0CC120
;LDA #$02 : STA $012C
;STA $2140 : STA $0133 : STA $0130
;RTL

; =================================================================================

pushpc

org $1B913E ; Overwrite Light World Theme - Size 0x0704
MotherUndergroundTheme:

!ARAMAddr = $E13A
dw !ARAMAddr+$0A ; Intro
dw !ARAMAddr+$1A ; Looping
dw $00FF
dw !ARAMAddr+$02 ; Looping Section
dw $0000

; ------------------------------------------------------------------------------

.Song13_ChannelsIntro
!ARAMC = !ARAMAddr-MotherUndergroundTheme
dw Song13_Channel0Intro+!ARAMC ; Choir
dw Song13_Channel1Intro+!ARAMC ; Choir
dw Song13_Channel2Intro+!ARAMC ; Choir
dw $0000 ; Song13_Channel3Intro+!ARAMC ; Snare
dw $0000 ; Song13_Channel4Intro+!ARAMC
dw $0000 ; Song13_Channel5Intro+!ARAMC
dw $0000 ; Song13_Channel6Intro+!ARAMC
dw $0000 ; Song13_Channel7Intro+!ARAMC

; ------------------------------------------------------------------------------

.Song13_Segment1_Channels
!ARAMC = !ARAMAddr-MotherUndergroundTheme
dw Song13_Segment1_Channel0+!ARAMC ; Piano
dw Song13_Segment1_Channel1+!ARAMC ; Choir
dw Song13_Segment1_Channel2+!ARAMC ; Timpani
dw $0000 ; Song13_Segment1_Channel3+!ARAMC ; Snare
dw Song13_Segment1_Channel4+!ARAMC ; Harp
dw Song13_Segment1_Channel5+!ARAMC ; Harp
dw Song13_Segment1_Channel6+!ARAMC ; Harp
dw Song13_Segment1_Channel7+!ARAMC ; Harp

; ==============================================================================

Song13_Channel0Intro:
%PercussionPatchBass($19)
%EchoVBits($FF, $00, $00)
%EchoParams($02, $3C, $02)
%EchoVolumeFade($28, $28, $28)
%SetTempo($1A)
%SetMasterVolume($A0)

%SetChannelVolume($C8)
%SetInstrument($15) ; Choir
%VibratoOn($14, $1A, $46)

db $30, $7F, Rest
db $18, D3, D3

db $60, D3
db End

; ==============================================================================

Song13_Channel1Intro:
%SetChannelVolume($C8)
%SetInstrument($15) ; Choir
%VibratoOn($14, $1A, $46)

db $18, $7F, Rest, G2, G2, G2

db $60, C4s
db End

; ==============================================================================

Song13_Channel2Intro:
%SetChannelVolume($C8)
%SetInstrument($15) ; Choir
%VibratoOn($14, $1A, $46)

db $60, $7F, C2, A2
db End

; ==============================================================================

Song13_Channel3Intro:
%SetChannelVolume($8C)
%SetPan($02) ; Leaning Right
%SetInstrument($13) ; Snare

%CallSubroutine(.sub031+!ARAMC, 4)
db End

; ------------------------------------------------------------------------------

.sub031
db $06, $2F, D4
db $2A, Rest
db End

; ==============================================================================

Song13_Segment1_Channel0: ; Piano
%SetChannelVolume($FA)
%SetInstrument($18) ; Piano

%CallSubroutine(.sub101+!ARAMC, 20)
%CallSubroutine(.sub102+!ARAMC, 8)
%CallSubroutine(.sub101+!ARAMC, 8)
%CallSubroutine(.sub103+!ARAMC, 4)
db End

; ------------------------------------------------------------------------------

.sub101
db $30, $4F, C2
db End

.sub102
db $30, F2
db End

.sub103
db $60, Rest
db End

; ==============================================================================

Song13_Segment1_Channel1: ; Choir
db $60, Rest

%CallSubroutine(.sub111+!ARAMC, 4)
%CallSubroutine(.sub112+!ARAMC, 6)
db End

.sub111
db $60, Rest

db $0C, C3, D3s, A3s, A3
db $60, Tie

db $30, Rest

db $0C, C3, D3s, E3, A2s
db $30, Rest

db End

.sub112
db $60, Rest
db End

; ==============================================================================

Song13_Segment1_Channel2: ; Timpani
%SetChannelVolume($B4)
%SetInstrument($02) ; Timpani

%CallSubroutine(.sub121+!ARAMC, 36)
%CallSubroutine(.sub122+!ARAMC, 4)
db End

; ------------------------------------------------------------------------------

.sub121
db $30, $7F, C1s
db End

.sub122
db $60, Rest
db End

; ==============================================================================

Song13_Segment1_Channel3: ; Snare
%CallSubroutine(.sub131+!ARAMC, 36)
%CallSubroutine(.sub132+!ARAMC, 4)
db End

; ------------------------------------------------------------------------------

.sub131
db $06, $2F, D4
db $2A, Rest
db End

.sub132
db $60, Rest
db End

; ==============================================================================

Song13_Segment1_Channel4: ; Harp
%SetChannelVolume($8C)
%SetPan($02) ; Leaning Right
%SetInstrument($0F) ; Harp

%CallSubroutine(.sub141+!ARAMC, 44)
db End

; ------------------------------------------------------------------------------

.sub141
db $0C, $3F, F5, Tie, F5s, Tie, G5, Tie, G5s, Tie

db End

; ==============================================================================

Song13_Segment1_Channel5: ; Harp
%SetChannelVolume($8C)
%SetPan($02) ; Leaning Right
%SetInstrument($0F) ; Harp

%CallSubroutine(.sub151+!ARAMC, 44)
db End

; ------------------------------------------------------------------------------

.sub151
db $0C, $3F, Tie, G5s, Tie, A5, Tie, A5s, Tie, B5

db End

; ==============================================================================

Song13_Segment1_Channel6: ; Harp
%SetChannelVolume($78)
%SetPan($02) ; Leaning Right
%SetInstrument($0F) ; Harp
%VibratoOn($00, $14, $64)

%CallSubroutine(.sub161+!ARAMC, 20)

db $0C, $3F, Rest, E5, Tie, F5, Tie, F5s, Tie, G5
db Tie, E5, Tie, F5, Tie, F5s, Tie, G5
db End

; ------------------------------------------------------------------------------

.sub161
db $60, Rest
db End

; ==============================================================================

Song13_Segment1_Channel7: ; Harp
%SetChannelVolume($78)
%SetPan($02) ; Leaning Right
%SetInstrument($0F) ; Harp
%VibratoOn($00, $14, $64)

%CallSubroutine(.sub171+!ARAMC, 20)

db $0C, $3F, Rest, Tie, G5, Tie, G5s, Tie, A5, Tie
db A5s, Tie, G5, Tie, G5s, Tie, A5, Tie
db End

; ------------------------------------------------------------------------------

.sub171
db $60, Rest
db End

; ==============================================================================

print "Mother Underground Track          $", pc
print " "

warnpc $1B9435

pullpc

; =================================================================================
