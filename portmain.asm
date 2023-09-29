;===============================================
; Sprite Engine
;===============================================

lorom

incsrc engine/sprite_macros.asm
incsrc engine/sprite_functions_hooks.asm

org $298000
incsrc engine/sprite_new_table.asm

org $308000
incsrc engine/sprite_new_functions.asm

;===============================================

; Poltergeist Controller Sprite
; Handles a scripted event of poltergeist sprites
; similar to the flying tiles rooms.
incsrc portset.asm

; Poltergeist Sprites
; Includes the individual subtypes which make up the 
; poltergeist event. Can be used separately.
incsrc poltergeist.asm