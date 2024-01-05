; ==============================================================================

pushpc

org $018264 ;object id 0x32
    dw ExpandedObject

org $01B53C
    ExpandedObject:
    JSL NewObjectsCode
    RTS

pullpc

; ==============================================================================

NewObjectsCode:
{
    PHB : PHK : PLB
    PHX
    LDA $00 : PHA ;store $00 value Not sure if needed
    LDA $02 : PHA ;store $00 value Not sure if needed
    ;$00 Will be used for tilecount and tiletoskip!!
    LDA $B2 : ASL #2 : ORA $B4

    ;get the offset for the object data based on the object height 
    ASL : TAX
    LDA .ObjOffset, X
    TAX

    .lineLoop
        LDA .ObjData, X : BNE .continue
            ;break
            BRA .Done
        .continue
        PHY ; Keep current position in the buffer

        STA $00 ; we save the tilecount + tiletoskip

        -- ;Tiles Loop
            INX : INX

            LDA .ObjData, X : BEQ +
                STA [$BF], Y
            +

            INY : INY
            LDA $00 : DEC : STA $00 : AND #$001F : BNE +
                LDA $00 : XBA : AND #$00FF : STA $00
                PLA ;Pull back position
                CLC : ADC $00 : TAY
                INX : INX
                BRA .lineLoop
            +

        BRA --

    .Done

    PLA : STA $02
    PLA : STA $00 ;Not sure if needed

    PLX
    PLB
    RTL
    
    ;Format = 
    ;[xoffset][uuuc cccc] ;32 tiles max width
    ;u = unused
    ;c = tiles count on the line
    ;0x0000 for end the copy
    ;xoffset (0x0080) = one full line
    ;[vhop ppcc][cccc cccc]

    .ObjOffset
    dw .bookshelf-.ObjData			;0x00
    dw .BookshelfRear-.ObjData			;0x01
    dw .casket-.ObjData				;0x02
    dw .ChairNorth-.ObjData			;0x03
    dw .ChairSouth-.ObjData			;0x04
    dw .fountain-.ObjData			;0x05
    dw .jarshelf-.ObjData			;0x06
    dw .oven-.ObjData				;0x07
    dw .pentagram-.ObjData			;0x08
    dw .SlimeEast-.ObjData			;0x09
    dw .SlimeNorth-.ObjData			;0x0A
    dw .SlimeSouth-.ObjData			;0x0B
    dw .SlimeWest-.ObjData			;0x0C
    dw .TableLarge-.ObjData			;0x0D
    dw .TableSmall-.ObjData			;0x0E
    dw .StairMask-.ObjData			;0x0F

    .ObjData
        .bookshelf
        incbin objects/bookshelf.bin
        .BookshelfRear
        incbin objects/BookshelfRear.bin
        .casket
        incbin objects/casket.bin
        .ChairNorth
        incbin objects/ChairNorth.bin
        .ChairSouth
        incbin objects/ChairSouth.bin
        .fountain
        incbin objects/fountain.bin
        .jarshelf
        incbin objects/jarshelf.bin
        .oven
        incbin objects/oven.bin
        .pentagram
        incbin objects/pentagram.bin
        .SlimeEast
        incbin objects/SlimeEast.bin
        .SlimeNorth
        incbin objects/SlimeNorth.bin
        .SlimeSouth
        incbin objects/SlimeSouth.bin
        .SlimeWest
        incbin objects/SlimeWest.bin
        .TableLarge
        incbin objects/TableLarge.bin
        .TableSmall
        incbin objects/TableSmall.bin
        .StairMask
        incbin objects/StairMask.bin
}

; ==============================================================================
