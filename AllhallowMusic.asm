pushpc
org $28424
JML MyNewMusic
NOP #02
MyReturn:

pullpc
MyNewMusic:
LDA $A0 : CMP #$04 : BNE +
JML $028467 ; room was 04 Play village song   (Link's House)
+
CMP #$03 : BNE +
JML $028467 ; room was 03 Play village song   (Chris Houlihan)
+
CMP #$EC : BNE +
JML $028467 ; room was EC Play village song    (Thief Hideout House)
+
CMP #$0F : BNE +
JML $028467 ; room was 0F Play village song    (Map Shop House)
+
CMP #$F5 : BNE +
JML $028467 ; room was F5 Play village song    (Windmill Cave)
+
CMP #$F0 : BNE +
JML $028467 ; room was F0 Play village song    (Locked Door House)
+
CMP #$0C : BNE +
JML $028467 ; room was 0C Play village song    (Bomb Shop House)
+
LDX #$04 ; Load Song 04 (Rabbit)
CMP #$9C : BNE +
JML $028467 ; room was 9C Play rabbit song       (Manor Part 1)
+
CMP #$5B : BNE +
JML $028467 ; room was 5B Play rabbit song       (Manor Part 2)
+
LDX #$03 ; Load Song 03 (Beginning)
CMP #$24 : BNE +
JML $028467 ; room was 24 Play beginning song       (Beamos Cave)
+
CMP #$15 : BNE +
JML $028467 ; room was 15 Play beginning song        (Fairy Cave)
+
CMP #$DA : BNE +
JML $028467 ; room was DA Play beginning song       (Pumpkin Patch)
+
CMP #$D2 : BNE +
JML $028467 ; room was D2 Play beginning song       (Lonely House)
+
LDX #$02 ; Load Song 02 (World Map)
CMP #$E3 : BNE +
JML $028467 ; room was E3 Play world map song       (Half Magic Cucco)
+
LDX #$05 ; Load Song 05 (Forest)
CMP #$14 : BNE +
JML $028467 ; room was 14 Play forest song         (Flying Guy House)
+
CMP #$12 : BNE +
JML $028467 ; room was 12 Play forest song        (Stalfos Guy House)
+
CMP #$1E : BNE +
JML $028467 ; room was 1E Play forest song         (Anti-Fairy Cave)
+
CMP #$13 : BNE +
JML $028467 ; room was 13 Play forest song        (Pit Cave House)
+
CMP #$D8 : BNE +
JML $028467 ; room was D8 Play forest song         (Flesh Dungeon Exit 1)
+
CMP #$C6 : BNE +
JML $028467 ; room was C6 Play forest song        (Flesh Dungeon Exit 2)
+
CMP #$18 : BNE +
JML $028467 ; room was 18 Play forest song        (Chest Minigame)
+
LDX #$0C ; Load Song 0C (Soldier)
CMP #$E8 : BNE +
JML $028467 ; room was E8 Play soldier song         (Pirate Ship 1)
+
CMP #$F7 : BNE +
JML $028467 ; room was F7 Play soldier song        (Pirate Ship 2)
+
CMP #$ED : BNE +
JML $028467 ; room was ED Play soldier song        (Pirate Ship 3)
+
; Room was not any of the rooms above
JML MyReturn ; return to normal code!


; LDX #$05   for any time that you want to change what song loads