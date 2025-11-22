import strutils
import random

proc pick2WithId(inputString: string, idValue: string): string =
    if inputString.len == 1:
        raise newException(ValueError, "inputString too short")

    if inputString.len == 0:
        raise newException(ValueError, "inputString empty")

    let firstChar = inputString[0]
    let lastChar = inputString[inputString.len - 1]

    return $firstChar & $lastChar & idValue

# Modulo de pruebas
when isMainModule:
    echo pick2WithId("mantequilla", "145")
    echo pick2WithId("hola", "33")
    echo pick2WithId("yo", "77")

    # Esto debe fallar
    # echo pick2WithId("a", "999")