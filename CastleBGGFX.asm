; ==============================================================================

;org $02ABB8 ; After most of the transition gfx changes take place.
    ;JML CheckForChangeGraphicsTransitionLoad

;org $0AB917 ; After most of the area loading after calling the bird takes place.
    ;JSL CheckForChangeGraphicsNormalLoad

;org $0ABC5A ; After the overworld map is closed.
    ;JSL CheckForChangeGraphicsNormalLoad

;org $028492 ; After leaving a dungeon.
    ;JSL CheckForChangeGraphicsNormalLoad

; ==============================================================================

;org $2C8000
CheckForChangeGraphicsTransitionLoadCastle:
{
    LDA $8A : CMP.b #$40 : BEQ .castleArea
        LDA.b #$09
            
        ;JML $02ABBE ; goes back to normal Overworld_FinishTransGfx_firstHalf
        JML CheckForChangeGraphicsTransitionLoadRetrun

    .castleArea

    JSR ApplyCastleGFX

    SEP #$30

    ;INC $11 ;increases which modual we are currently set at, so that the next modual will not go to Overworld_FinishTransGfx like it would normally

    JML SkipOverworld_FinishTransGfx_firstHalf
}

; ==============================================================================

CheckForChangeGraphicsNormalLoadCastle:
{
    ; No longer needed as this was left over from the FG hooks.
    ; JSL $00E19B ;calls InitTilesets that was replaced

    LDA $8A : CMP.b #$40 : BEQ .castleArea
        RTL ;goes back to normal

    .castleArea

    JSR ApplyCastleGFX

    RTL
}

; ==============================================================================

ApplyCastleGFX_LONG:
{
    JSL $00E19B ;calls InitTilesets that was replaced

    JSR ApplyCastleGFX
    
    RTL
}

ApplyCastleGFX:
{
    REP #$20 ; A = 16, XY = 8
    ;LDX #$80 : STX $2100 ;turn the screen off (required)
    LDX #$80 : STX $2115 ;Set the video port register every time we write it increase by 1
    LDA #$2C00 : STA $2116 ; Destination of the DMA $5800 in vram <- this need to be divided by 2
    LDA #$1801 : STA $4300 ; DMA Transfer Mode and destination register "001 => 2 registers write once            (2 bytes: p, p+1          )"
    LDA.w #YourBitmap1 : STA $4302 ;This is the source address where you want gfx from ROM
    LDX.b #YourBitmap1>>16 : STX $4304
    LDA #$1000 : STA $4305 ; size of the transfer 2 sheet of $800
    LDX #$01 : STX $420B ;Do the DMA 
    ;LDX #$0F : STX $2100 ;turn the screen back on

    SEP #$30

    RTS

    YourBitmap1:
    incbin CastleBGGFX.bin
}

; ==============================================================================