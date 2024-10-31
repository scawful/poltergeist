    org $0CC341 ;initialize some gfx settings at the beginning so that it displays correctly after the 
        JSL Main1 ;history cut scene plays And inserts the gfx to the vram and inserts a custom palette
    
    org $0CC27E ; disables BG 3 during the opening sequence as it is not used
        db #$11
    
    org $0CC51D ; disables BG 3 during the opening sequence as it is not used
        db #$01
    
    org $0CC2AE ; applies the tilemap after the original is placed in 
        JSL Main2
    
    org $0CEE39 ; at the beginning of the history cut scene reset the bg address
        JSL Reset1 
    
    org $0CCDE2 ; once the select screen appears, reset the bg address
        JSL Reset2
    
    org $218000
    
    ; ==============================================================================
    
    Main1:
    {
        JSL $00E384 ;replaces the Graphics_LoadCommonSprLong that was replaced
    
        LDX #$52 : STX $210B ; Changes where BG 1 pulls its graphics from
    
        LDA.b #$11 : STA $1C ;disables BG3
        LDA.b #$01 : STA $1D
        LDA.b #$11 : STA $212C
        LDA.b #$01 : STA $212D
    
        JSR ApplyGraphics ; inserts the new gfx into the vram
        JSR ApplyNewColors ; inserts the new colors into the cram
    
        SEP #$30
    
        RTL
    }
    
    ; ==============================================================================
    
    Main2:
    {
        JSL $0CC404 ; $64404* that was replaced 
    
        LDA $35 : CMP.b #$01 : BEQ .notfirst ;$35 is free ram that I am using to see whether this is the first time this is being run or not
    
        LDA.b #$01 : STA $35 ; if it is set $35 to 1 so we don't apply the tilemap again. otherwise, this causes part of the triforce to flicker
    
        JSR ApplyTileMap ; inserts the new tilemap into the vram
    
        .notfirst
    
        SEP #$30
    
        RTL
    }
    
    ; ==============================================================================
    
    Reset1:
    {
        JSL $1BEDF9 ;replaces the bit that was replaced Palette_ArmorAndGloves
    
        LDA.b #$1F : STA $1C ;re-enables BG3
        LDA.b #$1F : STA $1D
        LDA.b #$1F : STA $212C
        LDA.b #$1F : STA $212D
    
        LDX #$22 : STX $210B ;resets tile address
    
        RTL
    }
    
    ; ==============================================================================
    
    Reset2:
    {
        JSL $00E19B ;replaces the InitTileSets that was replaced
    
        LDA.b #$1F : STA $1C ;re-enables BG3
        LDA.b #$1F : STA $1D
        LDA.b #$1F : STA $212C
        LDA.b #$1F : STA $212D
    
        LDX #$22 : STX $210B ;resets tile address
    
        RTL
    }
    ; ==============================================================================
    
ApplyNewColors:
{
    PHX
    REP #$20 ;Set A in 16bit mode

    LDX #$1E

    --
        ;LDA.l TitlePalette, X : STA.l $7EC540, X
        LDA.l TitlePalette, X : STA.l $7EC340, X
    DEX : DEX : BNE --

    INC $15 ;Refresh Palettes
    SEP #$20 ;Set A in 8bit mode

    PLX
    RTS
}

TitlePalette:
    dw #$0000, #$0C43, #$0421, #$14A4, #$10C7, #$1CA6, #$14E9, #$110B, #$196E, #$21B1, #$318C, $1CE7, $294A, #$000A, #$0C77, #$0C77

    
    ; ==============================================================================
    
    ApplyGraphics:
    {
        REP #$20 ; A = 16, XY = 8
        LDX #$80 : STX $2100 ;turn the screen off (required)
        LDX #$80 : STX $2115 ;Set the video port register every time we write it increase by 1
        LDA #$5C00 : STA $2116 ; Destination of the DMA $A000 in vram <- this need to be divided by 2
        LDA #$1801 : STA $4300 ; DMA Transfer Mode and destination register "001 => 2 registers write once (2 bytes: p, p+1          )"
        LDA.w #YourBitmap : STA $4302 ;This is the source address where you want gfx from ROM
        LDX.b #YourBitmap>>16 : STX $4304
        LDA #$4600 : STA $4305 ; size of the transfer 3 sheets of $800 each
        LDX #$01 : STX $420B ;Do the DMA 
        LDX #$0F : STX $2100 ;turn the screen back on
    
        RTS
    
        YourBitmap:
        incbin Tileset.bin
    }
    
    ; ==============================================================================
    
    ApplyTileMap:
    {
        REP #$20 ; A = 16, XY = 8
        LDX #$80 : STX $2100 ;turn the screen off (required)
        LDX #$52 : STX $210B ;52
    
        LDX #$80 : STX $2115 ; Set the video port register every time we write it, increase by 1
        LDA #$0000 : STA $2116 ; Destination of the DMA $0000 in vram <- this need to be divided by 2 
        LDA #$1801 : STA $4300 ; DMA Transfer Mode and destination register "001 => 2 registers write once (2 bytes: p, p+1          )"
        LDA.w #YourTileMap : STA $4302 ; This is the source address where you want gfx from ROM
        LDX.b #YourTileMap>>16 : STX $4304
        LDA #$0800 : STA $4305 ; size of the transfer 3 sheets of $800 each
        LDX #$01 : STX $420B ;Do the DMA 
        LDX #$0F : STX $2100 ;turn the screen back on
    
        RTS
    
        YourTileMap:
        incbin Tilemap.bin
    }
    
    ; ==============================================================================