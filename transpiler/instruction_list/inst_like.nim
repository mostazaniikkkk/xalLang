# En esta hoja van las funciones que se declaran de tipo "function param1, param2"
# Osea, son instrucciones que parecen mas una funcion y caen bajo el comportamiento estandar del class instruction

import tables

# Instrucciones Isa, formato funcion-like, voy a agregar mas cuando termine con i8086
const instIsa* = {
    "i8086": {
        "copyByte": "mov",
        "addByte": "add",
        "subByte": "sub",
        "mulByte": "imul",
        "divByte": "idiv"
    }
}