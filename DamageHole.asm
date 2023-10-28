
pushpc
org $0794D9
JML HoleDamage
NOP #$02
RTLPitDamageOW:
skip 5
RTLPitWarpOW:

pullpc

HoleDamage:
LDA $8A : CMP.b #$35 : BNE .notmap35

; are we in top right corner?
REP #$20
LDA.b $22 : CMP.w #$0CA0 : BCC .tooleft
    LDA.b $20 : CMP.w #$0DC0 : BCS .toolow
        SEP #$20
        JML RTLPitWarpOW
    .toolow
.tooleft
SEP #$20
JML RTLPitDamageOW
.notmap35
JML RTLPitWarpOW