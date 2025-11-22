import abstract_instruction
import instruction_list/inst_like
import re, strutils

# Abstraccion de todas las instrucciones de ASM que cumplen con la interfaz de funciones
# ("instruccion param1, param2", como sum, mov, etc)
type FunctionLikeInstruction* = ref object of Instruction

# Metodo abstracto para obtener el ensamblador
method convertToAsm*(self: FunctionLikeInstruction): string =
    result = self.name & " " & self.args.join(", ")

# Constructor de instrucciones
proc createInstruction*(instruction: string, architecture: string): FunctionLikeInstruction =
    # Limpiar el dato de entrada
    let regex = re"^([a-zA-Z_][a-zA-Z0-9_]*)\s*\((.*?)\)$"

    if not (instruction =~ regex):
        raise newException(ValueError, "Invalid function-like instruction: " & instruction)

    let name = matches[0]
    let rawArgs = matches[1]

    # El name del constructor es el nombre que tiene la instruccion en XAL, siempre es diferente al de ASM.
    var alias: string
    if instIsa[architecture].hasKey(name):
        alias = instIsa[architecture][name]
    else:
        raise newException(ValueError, "Instruction not supported by select architecture " & architecture & ": " & name)

    result = FunctionLikeInstruction()
    result.name = alias                                     # El alias es la instruccion de ASM
    result.args = rawArgs.split(",").mapIt(it.strip())      # Separar los argumentos por comas y limpiar espacios.
