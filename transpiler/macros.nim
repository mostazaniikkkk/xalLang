import instruction

# Abstraccion de una macro en XAL
type Macros* = object
    name*: string               # Nombre de la macro en XAL
    instructions*: seq[Instruction]  # Instrucciones ensamblador que componen la macro