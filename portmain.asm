;===============================================
; Sprite Engine
;===============================================

lorom

incsrc engine/sprite_macros.asm
incsrc engine/sprite_functions_hooks.asm

org $298000
incsrc engine/sprite_new_table.asm

org $308000
pushpc
incsrc engine/sprite_new_functions.asm
incsrc FallingTiles.asm
incsrc PaletteGlowTagHole1.asm
incsrc SparkleTitlescreen.asm
pullpc

;===============================================

; Poltergeist Controller Sprite
; Handles a scripted event of poltergeist sprites
; similar to the flying tiles rooms.
incsrc PortSet.asm

; Poltergeist Sprites
; Includes the individual subtypes which make up the 
; poltergeist event. Can be used separately.
incsrc Poltergeist.asm