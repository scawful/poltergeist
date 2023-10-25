lorom

optimize dp always
optimize address mirrors

print " "
print "=============================================================================="
print " "

print "Applying All of the ASM for the Spooky Hack."
print " "

incsrc SpritesLib/Debug.asm
print "End of Debug.asm:                           ", pc
;incsrc SpritesLib/Sprite_Hooks.asm
;print "End of Sprite_Hooks.asm:                    ", pc

org $2D8000

;incsrc SpritesLib/Sprite_Functions.asm
;print "End of Sprite_Functions.asm:                ", pc
;print "End of General Sprite Library:              ", pc

print " "
print "=============================================================================="
print " "

pushpc

incsrc BlobDraw.asm
print "End of Custom blob draw:                    ", pc

incsrc BugNetKid.asm
print "End of lamp from bug net kid:               ", pc

incsrc FixPumpkinDoor.asm
print "End of pumpkin door fix:                    ", pc

incsrc customObjects/0x31CustomObjectHooks.asm
print "End of Custom Object 0x31 Hooks:            ", pc

pullpc

incsrc customObjects/0x31CustomObject.asm
print "End of Custom Object 0x31:                  ", pc

incsrc BigWhirlPool.asm
print "End of the big whrilpool draw:              ", pc

incsrc portmain.asm

print " "
print "=============================================================================="
print " "