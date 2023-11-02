; ==============================================================================

lorom

; No expanded space:
incsrc musicengine.asm
incsrc BookRoom.asm
incsrc BugNetKid.asm
incsrc CollisionTables.asm
incsrc CustomSprProperties.asm
incsrc DrawChanges.asm
incsrc FixPumpkinDoor.asm
incsrc SparkleTitlescreen.asm
incsrc SpookyCredits.asm
incsrc RainMusic.asm
incsrc Tavern.asm
incsrc HammerDamage.asm
incsrc OverworldMap.asm




; ==============================================================================

; Music:
incsrc PalaceThemeV1-01.asm ; castle song 0x10
;incsrc CallingThatDetestableNameV1-00.asm
incsrc MysteriousForestV1-00.asm ; Light World overworld song 0x02
incsrc GnarledRootThemeV1-00.asm ; sanctuary song 0x14
incsrc GraveyardThemeV1-00.asm ; Dark World overworld song 0x09
incsrc JabuJabuBellyThemeV1-00.asm ; zelda rescue song 0x19
incsrc SwordTrainingThemeV1-00.asm ; shop ; song 0x17
incsrc engine/Macros.asm
incsrc engine/sprite_functions_hooks.asm

; ==============================================================================

; ZS sprite library stuff
org $388000; Might need to change that position.
incsrc engine/sprite_new_table.asm

org $398000; Might need to change that position.
incsrc engine/sprite_new_functions.asm

; ==============================================================================

; Expanded space:
incsrc 0x31CustomObject.asm
incsrc 0x32CustomObject.asm
incsrc 4thAmulet.asm
incsrc AgahnimTower.asm
incsrc BigWhirlPool.asm
incsrc BowTablet.asm
incsrc BottleFix.asm
incsrc BumperASM.asm
incsrc Clown.asm
incsrc DamageHole.asm
incsrc DarkLinkBoss.asm
incsrc Doll.asm
incsrc DWSpawn.asm
incsrc EntranceAnimation.asm
incsrc FacadeCB.asm
incsrc FallingTiles.asm
incsrc FlyingTiles.asm ; Not final version.
incsrc GhostBusterUNF.asm ; Unfinished (must limit ghost and give prize on certain amount).
incsrc GlowingPalette.asm
incsrc GoriyaSubtype.asm
incsrc IntroZelda.asm
incsrc LongSwitch.asm
incsrc MagicMirror.asm
incsrc Mantle.asm
incsrc MetroidCC.asm
incsrc PoltergeistNew.asm
incsrc PotNotAlive.asm
incsrc PumpkinHeadCD.asm
incsrc SahasralalalalaFlippers.asm
incsrc SpikeSubtypes.asm
incsrc SpookyInventory.asm
incsrc StalfosLayeredOam.asm
incsrc TitleScreen.asm
incsrc UncleFlicker.asm
incsrc masks/MaskRoutines.asm
incsrc masks/AllMasks.asm
incsrc PoltergeistNew.asm
incsrc DarkLinkBoss.asm
incsrc SahasralalalalaFlippers.asm
incsrc MagicMirror.asm
incsrc LockedDoorsRainstate.asm

pushpc
incsrc ZSCustomOverworld.asm ; stripped of most functionality
pullpc

; ==============================================================================

; Currently unused:
; incsrc CastleBGGFX.asm ; Was going to be used with the pyramid BG but that's currently broken.
; incsrc PortMain.asm ; This will need to be fixed before it can be put in.

; ==============================================================================

print "Build Successful!"
warnpc $39FFFF ; If it reaches the warning move some code in next bank.

; ==============================================================================