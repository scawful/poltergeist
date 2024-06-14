; ==============================================================================
; Eye Statue Chest Appear
; Written by Jeimuzu
; 06-13-2024????????????????????????????????????????????????????????????????????
; ==============================================================================

pushpc

org $06C03F ; Sprite 38 EyeStatue Bounce
    JSL NewTargetCheck

org $05E62B ; Sprite 38 EyeStatue
    VanillaTarget:

pullpc

; ==============================================================================

; Subtypes:
; 0x00 Vanilla Arrow Target
; 0x01 Arrow Target Chest Appear

NewTargetCheck:
{
    PHB : PHK : PLB

    LDA.w $0E30, X : CMP.b #$01 : BCS .newTarget

        PLB
    
    JSL VanillaTarget

        RTL

    .newTarget

    ; Check if sprite is active (pause menu, etc...)
    LDA.w $0D80, X : BEQ .run
    LDA.b $11 : BNE .inMenu
    LDA.b $10 : CMP.b #$0E : BEQ .inMenu
    LDA.b $5D : CMP.b #$08 : BEQ .inMenu ; in medallion cut scene
                CMP.b #$09 : BEQ .inMenu ; in medallion cut scene
                CMP.b #$0A : BEQ .inMenu ; in medallion cut scene

        .run

        JSR NewTarget_Main

    .inMenu

    PLB

    RTL
}

; ==============================================================================

NewTarget_Main:
{
    LDA.w $0D80, X
	JSL UseImplicitRegIndexedLocalJumpTable
        dw NewTarget_Prep       ; 0x00
        dw NewTarget_Normal     ; 0x01
}

; ==============================================================================

NewTarget_Prep: ; 0x00
{
    LDA.b #$03 : STA.w $0F60, X ; Presist and hitbox properties

    INC.w $0D80, X ; Jump to NewTarget_Normal

    RTS
}

; ==============================================================================

NewTarget_Normal:
{
    JSL $06E416 ; Sprite_PrepOAMCoord_long
    JSL $05F94E ; Sprite_CheckIfActive_Bank05
    JSL $05F93F ; Sprite_DirectionToFaceLink_Bank05

	LDA.w $0BB0, X : CMP.b #$09 : BNE .exit

        STZ.w $0DD0, X ; Kill the sprite

        DEC.w $0D80, X ; Return to NewTarget_Prep

	.exit

    RTS
}

; ==============================================================================

;.main
;#_05E633: LDA.w $0DA0,X
;#_05E636: BNE .exit

;#_05E638: JSL $06E416 ; Sprite_PrepOAMCoord_long
;#_05E63C: JSL $05F94E ; Sprite_CheckIfActive_Bank05
;#_05E63F: JSL $05F93F ; Sprite_DirectionToFaceLink_Bank05

;#_05E642: CPY.b #$02
;#_05E644: BNE .exit

;#_05E646: LDA.w $0BB0,X
;#_05E649: CMP.b #$09
;#_05E64B: BNE .exit

;#_05E64D: INC.w $0642 ; A flag for indicating a state change in water puzzle rooms. (And hidden wall rooms?)

;#_05E650: LDA.b #$01
;#_05E652: STA.w $0DA0,X ; Determine the palette we are on

;.exit
;#_05E655: RTS

; ==============================================================================
