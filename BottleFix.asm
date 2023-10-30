pushpc

org $098960
    JSL BottleFix

pullpc

BottleFix:
{
    STA $7EF35C, X 

    LDA.b #$01 : STA $7EF34F

    RTL
}