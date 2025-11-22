import instruction

# Abstraccion de todas las instrucciones de ASM que cumplen con la interfaz de funciones
# ("instruccion param1, param2", como sum, mov, etc)
type FunctionLikeInstruction* = ref object of Instruction

# Metodo abstracto para obtener el ensamblador
method convertToAsm*(self: FunctionLikeInstruction): string =
    result = self.name & " " & self.args.join(", ")

# Constructor de instrucciones
proc createInstruction*(name: string, args: seq[string]): FunctionLikeInstruction =
    # El name del constructor es el nombre que tiene la instruccion en XAL, siempre es diferente al de ASM.
    result.name = name      # Se debe llamar a la tabla de instrucciones para determinar cual es la instruccion de ASM correspondiente.
    result.args = args