import abstract_instruction
import function/var_name

# Abstraccion para las regiones de memoria de una variable
type RegionType* = enum
    heap, stack, global

# Abstraccion para los tipos de memoria
type Memtype* = enum 
    tiny, short, mid, long

# Abstraccion para los tipos de datos
type Datatype* = enum
    natural, entire,           # Numericos
    decimal                    # Flotantes, no deberia usarse aun hasta ver el limite de i8086
    character

# Abstraccion de todas las instrucciones de ASM que cumplen con la interfaz de variables
# ("declaracion tipo var", como db, dw, etc)
type VarLikeInstruction* = ref object of Instruction
    typing*: string         # Tipo de la variable (byte, short, etc)
    region*: RegionType     # Ubicacion en RAM de la variable

# Metodo abstracto para obtener el ensamblador
# De momento se usa args[0] debido a que no se soportan listas.
method convertToAsm*(self: VarLikeInstruction): string =
    var response = ""

    case self.region
    of heap:
        response &= "mov cx, 1\n"
        response &= "call malloc\n"
        response &= "mov [ax], " & self.args[0] & "\n"

    of stack:
        response &= "sub sp, 1\n"
        response &= "mov [bp-1], " & self.args[0] & "\n"

    of global:
        response &= self.name & " " & self.typing & " " & self.args[0] & "\n"

    let instruction_asm = response
    result = instruction_asm

# Constructor de instrucciones, espera una cadena tipo "heap byte var_name = value;"
proc createVarInstruction*(id: int, name: string, args: seq[string], typing: string, region: RegionType): VarLikeInstruction =
    result = VarLikeInstruction()
    result.name = pick2WithId(name, $id)
    result.args = args
    result.typing = typing
    result.region = region