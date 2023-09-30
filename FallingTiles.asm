org $09BBB2
JSL Overlord_CrumbleTilePath
RTS

pullpc
Overlord_CrumbleTilePath:

PHB : PHK : PLB
    LDA $0B00, X : CMP #$0A : BNE +
        ; Special Crumble
        JSR Overlord_SpecialCrumbleTilePath
        PLB
        RTL

    +
    LDA $0B30, X : BEQ .timer_expired
    
    LDA $0B38, X : BEQ .check_on_screen
    
    DEC $0B30, X
    
    PLB
    RTL


.check_on_screen

    LDA $0B08, X : CMP $E2
    LDA $0B10, X : SBC $E3 : BNE .off_screen
    
    LDA $0B18, X : CMP $E8
    LDA $0B20, X : SBC $E9 : BNE .off_screen
    
    ; If on screen even once in this logic, the overlord will continue
    ; crumbling tiles.
    INC $0B38, X

.off_screen
    PLB
    RTL

.timer_expired

    LDA.b #$10 : STA $0B30, X
    
    JSR CrumbleTilePath_SpawnCrumbleTileGarnish
    
    INC $0B28, X
    
    LDA $0B00, X : SEC : SBC.b #$0A : TAY
    
    LDA .pointers_low, Y  : STA $00
    LDA .pointers_high, Y : STA $01
    
    LDA .crumble_tile_limit, Y : CMP $0B28, X : BNE .crumble_tiles_not_maxed
    
    STZ $0B00, X

.crumble_tiles_not_maxed

    LDY $0B28, X : DEY
    
    LDA ($00), Y : TAY
    
    LDA $0B08, X : CLC : ADC .x_adjustments_low,  Y : STA $0B08, X
    LDA $0B10, X : ADC .x_adjustments_high, Y : STA $0B10, X
    
    LDA $0B18, X : CLC : ADC .y_adjustments_low,  Y : STA $0B18, X
    LDA $0B20, X : ADC .y_adjustments_high, Y : STA $0B20, X

    PLB
    RTL




        ; Defines to make it easier to tell what the path looks like.
        !right = 0
        !left  = 1
        !down  = 2
        !up    = 3
        
    ; $bb24
    .rectangle
        db !down, !down,  !down,  !down,  !down,  !down
        db !left, !left,  !left,  !left,  !left,  !left, !left
        db !up, !up, !up, !up, !up, !up
        db !right, !right, !right, !right, !right, !right
    
    .snake_upward
        db !right, !up, !left, !up
        db !right, !up, !left, !up
        db !right, !up, !left, !up
        db !right, !up, !left, !up
        db !right, !up, !left, !up
        db !right, !up, !left, !up
        db !right, !up, !left, !up
        db !right, !up, !left, !up
        db !right, !up, !left, !up
        db !right, !up, !left, !up
        db !right
    
    .line_rightward
        db !right, !right, !right, !right, !right, !right, !right, !right
        db !right, !right, !right
    
    .line_downward
        db !down, !down, !down, !down, !down, !down, !down, !down
        db !down, !down
    
    .line_leftward
        db !left, !left, !left, !left, !left, !left, !left, !left
        db !left, !left, !left
    
    .line_upward
        db !up, !up, !up, !up, !up, !up, !up, !up
        db !up, !up
    
    .x_adjustments_low
        db 16, -16,   0,   0
    
    .x_adjustments_high
        db  0,  -1,   0,   0
    
    .y_adjustments_low
        db  0,   0,  16, -16
    
    .y_adjustments_high
        db  0,   0,   0,  -1 
    
    .crumble_tile_limit
        db 26, 42, 12, 11, 12, 11
    
    ; \task perhaps express these pointers flat, then interlave them when we get
    ; the assembler features for it?
    .pointers_low
        db .rectangle
        db .snake_upward
        db .line_rightward
        db .line_downward
        db .line_leftward
        db .line_upward
    
    .pointers_high
        db .rectangle>>8
        db .snake_upward>>8
        db .line_rightward>>8
        db .line_downward>>8
        db .line_leftward>>8
        db .line_upward>>8





    CrumbleTilePath_SpawnCrumbleTileGarnish:
    {
        TXY
        
        PHX
        
        LDX.b #$1D
    
    .next_slot
    
        LDA $7FF800, X : BNE .non_empty_slot
        
        LDA.b #$03 : STA $7FF800, X
        
        LDA $0B08, Y : STA $7FF83C, X
        
        JSL $0DBBD0 ; Sound_GetFineSfxPan
        ORA.b #$1F : STA $012E
        
        LDA $0B10, Y : STA $7FF878, X
        
        LDA $0B18, Y : CLC : ADC.b #$10 : STA $7FF81E, X
        LDA $0B20, Y : ADC.b #$00 : STA $7FF85A, X
        
        LDA.b #$1F : STA $7FF90E, X
                     STA $0FB4
        
        BRA .return
    
    .non_empty_slot
    
        DEX : BPL .next_slot
    
    .return
    
        PLX
        
        RTS
    }


    ; $0B38, X is the step of the tilepath
    ; $0B48. X = current delay
    Overlord_SpecialCrumbleTilePath:

    
    REP #$20 ; set A on 16 bit
    LDY.b $A0 ; Load room index in Y
    LDA.w RoomsTilePath, Y : AND #$00FF : ASL ; load pointers of data based on room
    TAY
    LDA.w TilePathPtrs, Y
    STA.b $00 ; store pointer in $00
    SEP #$20 ; set it back on 8 bit

    LDA.w $0B38, X : BNE .initialized

    LDA.w $0B10, X : CMP.b $23 : BNE .return
    LDA.w $0B20, X : CMP.b $21 : BNE .return

        TAY ; set the step in Y
        LDA ($00), Y : STA.w $0B30, X ; set the initial timer
        INC $0B38, X ; increase current step
        LDA #$10 : STA.w $0B48, X ; set default delay on 0x10
    .initialized
    LDA $0B30, X : BEQ .timer_expired
    DEC $0B30, X
    .return
    RTS

.timer_expired
LDY $0B38, X
LDA ($00), Y : CMP #$FF : BNE .continue
STZ $0B00, X ; kill the sprite
RTS
; we reached the end 
.continue
AND #$FC : BEQ .Direction
LSR #2
STA $0B48, X ; set new delay
INC $0B38, X ; increase position

.Direction
    LDA.w $0B48, X : STA $0B30, X ; set new delay
    
    JSR CrumbleTilePath_SpawnCrumbleTileGarnish

    LDY.w $0B38, X
    LDA ($00), Y : AND #$03 : TAY

    LDA $0B08, X : CLC : ADC .x_adjustments_low,  Y : STA $0B08, X
    LDA $0B10, X : ADC .x_adjustments_high, Y : STA $0B10, X
    
    LDA $0B18, X : CLC : ADC .y_adjustments_low,  Y : STA $0B18, X
    LDA $0B20, X : ADC .y_adjustments_high, Y : STA $0B20, X

    INC $0B38, X ; increase position for the next frame
    RTS

.x_adjustments_low
    db 16, -16,   0,   0

.x_adjustments_high
    db  0,  -1,   0,   0

.y_adjustments_low
    db  0,   0,  16, -16

.y_adjustments_high
    db  0,   0,   0,  -1 

RoomsTilePath: ; By default all rooms use rectangle pattern $00
db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

TilePathPtrs:
dw TilePath00
dw TilePath01
dw TilePath02

;================================================
; Commands can be
; !up, !left, !right, !down
; to change the falling delay (by default $10) :
; $10<<2 to set normal speed
; $20<<2 to set it twice slower
; $3F<<2 to set it almost 4 time slower than normal (this is max value)
; $01<<2 ; is the fasted possible values which will make all the tiles fall almost instantly
; delay $00<<2 will be considered as value 00 which is !up so this is an invalid value
; DO NOT PUT 2 delay next to each other it might cause issues


; Format of the tile path : 
; Initial Delay
; <Commands>
; FF ; End the path


; Normal Rectangle Pattern
TilePath00:
db $00 ; Initial Delay
db !down, !down,  !down,  !down,  !down,  !down
db !left, !left,  !left,  !left,  !left,  !left, !left
db !up, !up, !up, !up, !up, !up
db !right, !right, !right, !right, !right, !right, !right
db $FF ; End of the path


; Z Pattern
TilePath01:
db $10
db !right, !right, !right, !right, !right, $04<<2
db !down, !left, !down, !left, !down, !left, !down, !left, !down, !left
db $1F<<2
db !right, !right, !right, !right, !right, !right
db $FF


; Normal Rectangle Pattern
TilePath02:
db $10 ; Initial Delay
db $3F<<2, !down, $3D<<2, !down, $3B<<2,  !down, $39<<2,  !down, $37<<2,  !down, $35<<2,  !down, $33<<2
db !left, $30<<2, !left, $2E<<2, !left, $2C<<2, !left, $29<<2, !left, $26<<2, !left, $23<<2, !left
db $20<<2, !up, $1D<<2, !up, $1A<<2, !up, $18<<2, !up, $15<<2, !up, $12<<2, !up
db $10<<2, !right, $0D<<2, !right, $0A<<2, !right, $08<<2, !right, $06<<2, !right, $04<<2, !right, $02<<2, !right
db $FF ; End of the path


pushpc