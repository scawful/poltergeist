pushpc


org $0DC246
db $80 ; BRA

pullpc
; org $0DC25C
; JSL StalfosCheckLayered
; NOP
; pullpc


; StalfosCheckLayered:
; AND #$8F : PHA ; keep that


; LDA $0FB3 : BEQ +
; PLA : ORA.l .head_properties_layered, X
; RTL
; +
; PLA : ORA.l .head_properties, X
; RTL


; .head_properties_layered
;     db $40, $00, $00, $00

; .head_properties
;     db $70, $30, $30, $30