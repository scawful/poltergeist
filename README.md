# poltergeist

Asar translated recreation of the haunted house poltergeist sprite from the Link to the Past prototype.

More information [Development:The Legend of Zelda: A Link to the Past/Dungeons & Interiors:Haunted House](https://tcrf.net/Development:The_Legend_of_Zelda:_A_Link_to_the_Past/Dungeons_%26_Interiors#Haunted_House)

- portmain.asm: Includes the ZSprite Engine, poltergeist.asm and portset.asm
- portset.asm: Controls a scripted event where multiple poltergeist sprites are summoned in a room.
- poltergeist.asm: Poltergeist object sprite, ordered by subtype ID.

| NAME | ID | DESC |
| ---- | -- | ---- |
| NONE | 00 | Dictates which subtype to use. | 
| ISUU | 01 | chair | 
| NATA | 02 | axe | 
| SARA | 03 | dish | 
| FOOK | 04 | fork | 
| KNIF | 05 | knife | 
| MADO | 06 | window | 
| GAKU | 07 | frame | 
| BADD | 08 | bed | 
| TABL | 09 | table | 
| GOST | 0A | ghost | 

