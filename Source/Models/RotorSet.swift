import Foundation

enum RotorSetError: ErrorType {
    case RotorAlreadyUsed
}

extension Character {
    func offsetBy(amount: Int) -> Character {
        let offset = Character("A").unicodeScalarValue()
        let value = self.unicodeScalarValue()
        var normalised = value - offset - amount
        if normalised < 0 {
            normalised += 26
        }

        return Character(UnicodeScalar(normalised % 26 + offset))
    }
}

/**
 *  A managing class of a set of rotors.
 */
struct RotorSet {

    lazy var rotorBox: RotorLoadable = RotorBox()
    var firstRotor: Rotor?
    var secondRotor: Rotor?
    var thirdRotor: Rotor?
    var fourthRotor: Rotor?
    var reflector: Rotor?

    /**
     Load a rotor into a specific position from right to left.

     - parameter type:     The type of rotor to load.
     - parameter position: The position to load the rotor.
     - throws: RotorSetError if unable to load rotor.
     */
    mutating func loadRotorType(type: RotorType, position: RotorPosition) throws {
        let rotor = rotorBox.loadRotorOfType(type)

        for loadedRotor in [ firstRotor, secondRotor, thirdRotor, fourthRotor ] {
            if rotor == loadedRotor {
                throw RotorSetError.RotorAlreadyUsed
            }
        }

        switch position {
        case .First: firstRotor = rotor
        case .Second: secondRotor = rotor
        case .Third: thirdRotor = rotor
        case .Fourth: fourthRotor = rotor
        }
    }

    /**
     Load a reflector rotor into the reflector position.

     - parameter type: The reflector type to load.
     */
    mutating func loadReflectorType(type: ReflectorType) {
        reflector = rotorBox.loadReflectorOfType(type)
    }

    /**
     Encypher a single character.

     - parameter character: The input character.
     - returns: The encyphered character, after running through the set
     */
    mutating func encypher(character: Character) -> Character {
        var char = character

        turnRotors()

        for rotor in allRotors() {
            if let encyphered = rotor.encypher(char) {
                char = encyphered.offsetBy(rotor.rotorPosition)
            }
        }

        if let reflector = reflector?.encypher(char) {
            char = reflector
        }

        for rotor in allRotors().reverse() {
            let offsetChar = char.offsetBy(-rotor.rotorPosition)
            char = rotor.decypher(offsetChar)
        }

        return char
    }

    /**
     Each time a letter key is pressed, the first rotor turns over. Cycle
     through each rotor to see if it needs to turn over the next rotor. This has
     to be done in reverse, so it doesn't interfere with the turnover state of
     the rotor to the right.
     */
    private mutating func turnRotors() {
        if thirdRotor?.shouldTurnover == true {
            fourthRotor?.turnRotor()
        }

        if secondRotor?.shouldTurnover == true {
            thirdRotor?.turnRotor()
        }

        if firstRotor?.shouldTurnover == true {
            secondRotor?.turnRotor()
        }

        firstRotor?.turnRotor()
    }

    /**
     Encypher a string.

     - parameter string: The string to be encyphered.
     - returns: The encyphered output.
     */
    mutating func encypherString(string: String) -> String {
        var encyphered = ""

        for char in string.characters {
            encyphered.append(encypher(char))
        }

        return encyphered
    }

    private func allRotors() -> [Rotor] {
        var rotors: [Rotor] = []

        if let firstRotor = firstRotor {
            rotors.append(firstRotor)
        }

        if let secondRotor = secondRotor {
            rotors.append(secondRotor)
        }

        if let thirdRotor = thirdRotor {
            rotors.append(thirdRotor)
        }

        if let fourthRotor = fourthRotor {
            rotors.append(fourthRotor)
        }

        return rotors
    }
}
