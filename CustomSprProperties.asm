org $0DB44C+$38 ; Eye statue sprite properties
db $43 ; set it unalive with hitbox3 (default property)

org $0DB44C+$EE ; castle mantle
db $48 ; set it unalive with hitbox8 (default property)

org $0DB266+$8F ; Blob bump damage
db $01 ; Original: 05

org $0DB266+$C7 ; Pokey bump damage
db $01 ; Original: 06

org $0DB266+$C7 ; Snap Dragon bump damage
db $01 ; Original: 06

org $6B44C+$3B ; Book is dead
db $40 ; original: 00

org $0DB173+$6A ; Ball and chain soldier health
db $08 ; original: 10

org $6B44C+$3B ; Book is dead yo
db $40 ; original: 00

org $0DB266+$8B ; Gibdo (1 Heart)
db $03

org $0DB266+$91 ; Stalfos Knight (1 Heart)
db $03

org $0DB266+$9B ; Wizzrobe (2 Hearts)
db $05

org $0DB266+$0E ; Snapdragon (1 Heart)
db $03

org $0DB266+$19 ; Poe (1 Heart)
db $03

org $0DB266+$11 ; Hinox (2 Hearts)
db $05

org $0DB266+$CF ; Swamola (2 Hearts)
db $05

org $0DB725+$D5 ; Digging guy 
db $10 ; original: 00

org $0DB266+$95 ; Left eye lasers set to 2 hearts instead of 4
db $05

org $0DB266+$96 ; Right eye lasers set to 2 hearts instead of 4
db $05

org $0DB266+$97 ; Top eye lasers set to 2 hearts instead of 4
db $05

org $0DB266+$98 ; Down eye lasers set to 2 hearts instead of 4
db $05
