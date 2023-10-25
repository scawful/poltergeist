pushpc
org $05DE2C
JSL NewUncleDraw
pullpc



NewUncleDraw:
LDA $1A : AND #$03 : BEQ + ; Change 03 to 01 if too slow
JSL $0DD391 ; Draw Uncle Sprite
+
RTL