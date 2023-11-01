; Prevent Agahnim from starting the Ganon bat sequence
; by skipping the timer and initiating a dungeon boss death
; This may need a dedicated jump table routine for handling 
; his death, and we can use the space from the original cutscene
; routines for it if necessary.

pushpc

org $1ED376
Agahnim_SpinToPyramid:
{
    PHX
    LDA.b #$04 : STA $0DD0, X ; Kil Agahnim as a boss
    PLX
    RTS
}

pullpc