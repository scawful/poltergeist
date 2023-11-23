; ==============================================================================

pushpc

org $018262 ;object id 0x31
    dw ExpandedObject31

org $01B541
    ExpandedObject31:
    JSL NewObjectsCode31
    RTS

pullpc

; ==============================================================================

NewObjectsCode31:
{
    PHB : PHK : PLB
    PHX

    ; $00 Will be used for tilecount and tiletoskip!!
    LDA $00 : PHA ; Store $00 value Not sure if needed.
    LDA $02 : PHA ; Store $00 value Not sure if needed.
    
    LDA $B2 : ASL #2 : ORA $B4

    ; Get the offset for the object data based on the object height.
    ASL : TAX
    LDA .objOffset, X
    TAX

    .lineLoop
        LDA .objData, X : BEQ .done
            PHY ; Keep current position in the buffer.

            STA $00 ; We save the tilecount + tiletoskip.

            .tileLoop
                INX : INX

                LDA .objData, X : BEQ +
                    STA [$BF], Y
                +

                ; If it is one of the slime objects, set the collision to 0x00.
                ; Doesn't currently work because it gets replaced by something else later.
                ;CPX.w .slimeStart : BCC .noCollision
                    ;PHX

                    ;TYA : LSR : TAX

                    ;SEP #$20 ; Set A in 8bit mode.

                    ;LDA.b #$00 : STA.l $7F2000, X

                    ;REP #$20 ; Set A in 16bit mode.

                    ;PLX

                ;.noCollision

                INY : INY
                LDA $00 : DEC : STA $00 : AND #$001F : BNE +
                    LDA $00 : XBA : AND #$00FF : STA $00

                    PLA ; Pull back position.
                    CLC : ADC $00 : TAY

                    INX : INX
                    BRA .lineLoop
                +

            BRA .tileLoop

    .done

    PLA : STA $02
    PLA : STA $00 ; Not sure if needed.

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

    .objOffset
    dw .north-.objData  ; 0x00
    dw .south-.objData  ; 0x01
    dw .east-.objData   ; 0x02
    dw .west-.objData   ; 0x03

    .slimeStart
    dw .slime1-.objData ; 0x04
    dw .slime2-.objData ; 0x05
    dw .slime3-.objData ; 0x06
    dw .slime4-.objData ; 0x07
    dw .slime5-.objData ; 0x08
    dw .slime6-.objData ; 0x09
    dw .slime7-.objData ; 0x0A
    dw .slime8-.objData ; 0x0B

    .objData
        .north
        incbin objects/northPillar.bin

        .south
        incbin objects/southPillar.bin

        .east
        incbin objects/eastPillar.bin

        .west
        incbin objects/westPillar.bin


        .slime1
        incbin objects/slime1.bin

        .slime2
        incbin objects/slime2.bin

        .slime3
        incbin objects/slime3.bin

        .slime4
        incbin objects/slime4.bin
        
        .slime5
        incbin objects/slime5.bin

        .slime6
        incbin objects/slime6.bin
        
        .slime7
        incbin objects/slime7.bin

        .slime8
        incbin objects/slime8.bin
}

; ==============================================================================