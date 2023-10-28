pushpc

org $0DC25C
JSL StalfosCheckLayered
NOP
pullpc


StalfosCheckLayered:
AND #$8F : PHA ; keep that


LDA $0FB3 : BEQ +
PLA : ORA.l .head_properties_layered, X
RTL
+
PLA : ORA.l .head_properties, X
RTL


.head_properties_layered
    db $50, $10, $10, $10

.head_properties
    db $70, $30, $30, $30