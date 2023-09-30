org $01CC08 ; Replace hole(3) and hole(4) tag DO NOT USE hole(4) use hole(3)
JSL GlowingCode
RTS


!TimeStep = $1E0E ; MIGHT NEED TO CHANGE [Free RAM][0x02]
!Mode = $1E0B ; MIGHT NEED TO CHANGE [Free RAM][0x01]
!Timer = $1CDB ; MIGHT NEED TO CHANGE [Free RAM][0x01]


macro hexcolor(color)

!R = ((<color>&$FF0000)>>16)
!G = ((<color>&$00FF00)>>8)
!B = ((<color>&$0000FF))
dw ((!B/8)<<10|(!G/8)<<5|(!R/8))

endmacro

pullpc
 ; Green color
GlowingPalette:
%hexcolor($204A08) : %hexcolor($347F09) : %hexcolor($46B009) : %hexcolor($5EFF00) ; 00
%hexcolor($1D4207) : %hexcolor($307209) : %hexcolor($419E0A) : %hexcolor($5AE705) ; 01
%hexcolor($1B3A07) : %hexcolor($2C6509) : %hexcolor($3C8C0B) : %hexcolor($55D009) ; 02
%hexcolor($183206) : %hexcolor($285809) : %hexcolor($377A0C) : %hexcolor($51B80E) ; 03
%hexcolor($152B06) : %hexcolor($244A09) : %hexcolor($32690C) : %hexcolor($4DA113) ; 04
%hexcolor($122305) : %hexcolor($203D09) : %hexcolor($2D570D) : %hexcolor($498918) ; 05
%hexcolor($101B05) : %hexcolor($1C3009) : %hexcolor($28450E) : %hexcolor($44721C) ; 06
%hexcolor($0D1304) : %hexcolor($182309) : %hexcolor($23330F) : %hexcolor($405A21) ; 07

; orange red color (unused)
%hexcolor($711436) : %hexcolor($B01717) : %hexcolor($FA1303) : %hexcolor($AE6D0D) ; 00
%hexcolor($6A1435) : %hexcolor($A8171C) : %hexcolor($FB2D07) : %hexcolor($AB740E) ; 01
%hexcolor($641333) : %hexcolor($A11721) : %hexcolor($FB480C) : %hexcolor($A97B10) ; 02
%hexcolor($5D1332) : %hexcolor($991726) : %hexcolor($FC6210) : %hexcolor($A68211) ; 03
%hexcolor($561230) : %hexcolor($91162C) : %hexcolor($FD7C15) : %hexcolor($A48A13) ; 04
%hexcolor($4F122F) : %hexcolor($891631) : %hexcolor($FE9619) : %hexcolor($A19114) ; 05
%hexcolor($49112D) : %hexcolor($821636) : %hexcolor($FEB11E) : %hexcolor($9F9816) ; 06
%hexcolor($42112C) : %hexcolor($7A163B) : %hexcolor($FFCB22) : %hexcolor($9C9F17) ; 07


PaletteGlowCode:
;E8 = 4th color of water palette
LDA.w !TimeStep : ASL #3 : CLC : ADC #$07 : TAY
LDX.b #$07
REP #$20
--
LDA.w GlowingPalette, Y
STA.l $7EC5E8, X
DEY : DEY
DEX : DEX : BPL --
SEP #$20
RTS


; 0 = Decrease
; 1 = Increase
; If bit7 is set (0x80) init code has run

GlowingCode:
PHB : PHK : PLB
LDA.w !Mode : BMI .initDone
LDA.b #$20 : STA.w !Timer
LDA.b #$81 : STA.w !Mode ; set mode on increasing
LDA #$00 : STA.w !TimeStep

.initDone

LDA.w !Timer : DEC : STA.w !Timer : BNE ++

LDA.b #$04 : STA.w !Timer ; add small delay
LDA !Mode : AND #$01 : BNE .Increase
LDA.w !TimeStep : DEC : STA.w !TimeStep : BNE +
; change mode
INC.w !Mode
LDA.b #$10 : STA.w !Timer ; add a bigger delay if 0
+

JSR PaletteGlowCode
INC.b $15 ; update palette

PLB
RTL ; not reached yet so return

.Increase

LDA.w !TimeStep : INC : STA.w !TimeStep : CMP #$07 : BNE +
; change mode
INC.w !Mode
LDA.b #$10 : STA.w !Timer ; add a bigger delay if 0
+

JSR PaletteGlowCode
INC.b $15 ; update palette

++
PLB
RTL ; not reached yet so return
pushpc