# Clase abstracta para representar una instrucción ensamblador
type Instruction* = ref object of RootObj
    name*: string               # Nombre de la instrucción en ensamblador
    args*: seq[string]          # Argumentos de la instrucción

method convertToAsm*(self: AbstractAnimal) {.base.} =
    raise newException(ValueError, "Abstract method called")