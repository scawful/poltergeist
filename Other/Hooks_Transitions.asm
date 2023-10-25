;LIGHT WORLD/DARK WORLD TRANSITION
;=================================
 
    lorom

    ; EXIT door
    org $02E551
    jsl exit ;pc 07/7F00!
    nop

    org $82D9A6
    JSL entrance
    NOP

    org $0EFF20 ; pc $07/7F20!
    exit:
    STZ $8B ; repeat overwritten code
    STZ $040B
    PHP
    LDA $A2 ; load exit you've taken
    CMP #$A4 ; Compare Dark World Exit 1	- Exit from Ice Cave Exit A4
    BNE $03
    JMP dflag
    CMP #$10 ; Compare Dark World Exit 2	- Exit to DW Death Mountain Exit 10
    BNE $03
    JMP dflag
    CMP #$0F ; Compare Dark World Exit 3	- Exit from Hyrule Castle Exit 0F
    BNE $03
    JMP dflag
    CMP #$1F ; Compare Dark World Exit 4	- Exit from Hyrule Castle Tower Exit 1F
    BNE $03
    JMP dflag
    CMP #$18 ; Compare Light World Exit 5	- Exit from Blind's Hideout Exit 18
    BNE $03
    JMP oflag
    PLP
    RTL

    entrance:
    STA $A0
    STA $048E ;native code
    PHP
    CMP #$00A4 ; Compare Dark World Entrance 1		- Entrance to Ice Cave
    BNE $05
    Sep #$20
    JMP oflag
    CMP #$0010 ; Compare Dark World Entrance 2		- Entrance back to LW Death Mountain
    BNE $05
    Sep #$20
    JMP oflag
    CMP #$000F ; Compare Dark World Entrance 3		- Entrance to Hyrule Castle
    BNE $05
    Sep #$20
    JMP oflag
    CMP #$001F ; Compare Dark World Entrance 4		- Entrance to Hyrule Castle Tower
    BNE $05
    Sep #$20
    JMP oflag
    CMP #$0018 ; Compare Light World Entrance 5		- Entrance to Blind's Hideout
    BNE $05
    Sep #$20
    JMP oflag
    PLP
    RTL

    oflag:
    LDA #$00
    STA $7EF3CA ; set overworld flag
    STZ $02E0 ; erase bunny mode
    PLP
    RTL

    dflag:
    LDA #$40 ; set dark world flag
    STA $7EF3CA
    PLP
    RTL
