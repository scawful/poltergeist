; ==============================================================================

lorom

incsrc BookRoom.asm
incsrc BugNetKid.asm
incsrc Collision.asm
incsrc DrawChanges.asm
incsrc FixPumpkinDoor.asm
incsrc SparkleTitlescreen.asm

incsrc engine/Macros.asm
incsrc engine/sprite_functions_hooks.asm

; ==============================================================================

org $388000; Might need to change that position.
incsrc engine/sprite_new_table.asm

org $398000; Might need to change that position.
incsrc engine/sprite_new_functions.asm

; ==============================================================================

incsrc 0x31CustomObject.asm
incsrc 0x32CustomObject.asm
incsrc 4thAmulet.asm
incsrc BigWhirlPool.asm
incsrc BowTablet.asm
incsrc BumperASM.asm
incsrc Clown.asm
incsrc Doll.asm
incsrc DWSpawn.asm
incsrc EntranceAnimation.asm
incsrc FacadeCB.asm
incsrc FallingTiles.asm
incsrc FlyingTiles.asm ; Not final version.
incsrc GhostBusterUNF.asm ; Unfinished (must limit ghost and give prize on certain amount).
incsrc GlowingPalette.asm
incsrc GoriyaSubtype.asm
incsrc LongSwitch.asm
incsrc Mantle.asm
incsrc MetroidCC.asm
incsrc PotNotAlive.asm
incsrc PumpkinHeadCD.asm
incsrc SpikeSubtypes.asm
incsrc SpookyInventory.asm
incsrc TitleScreen.asm
incsrc UncleFlicker.asm
incsrc IntroZelda.asm
incsrc DamageHole.asm

; incsrc PortMain.asm ; This will need to be fixed before it can be put in.

print "Build Successful!"
warnpc $39FFFF ; If it reaches the warning move some code in next bank.

; ==============================================================================