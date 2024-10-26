; ==============================================================================

pushpc

org $0296C0
    NOP #$07
    JSL WarpRoomCheck

org $2A8000 ; Expanded Region Code

pullpc

WarpRoomCheck:
{
    LDA.b $A0
    CMP.w #$005B : BNE + ; room 5B
        LDX.b #01 : STX $A4
    + 

    CMP.w #$0021 : BNE + ; room 21
        LDX.b #05 : STX $A4
    + 

    RTL
}

; Anytime you want to add another room, add this before the RTL. (Without ; or other extra parts)
; CMP.w #$00XX : BNE + ; roomXX    > (XX is just example numbers, replace them with whatever room you want)
; LDX.b #0X : STX $A4              > (X is once again an example number, replace them with any floor number value)
; +

; ==============================================================================

; Floor Number Values:
; #-8 = B8
; #-7 = B7
; #-6 = B6
; #-5 = B5
; #-4 = B4
; #-3 = B3
; #-2 = B2
; #-1 = B1
; #00 = 1F
; #01 = 2F
; #02 = 3F
; #03 = 4F
; #04 = 5F
; #05 = 6F
; #06 = 7F
; #07 = 8F

; ==============================================================================