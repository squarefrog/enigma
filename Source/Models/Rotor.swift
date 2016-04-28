import Foundation

/**
 *  A representation of an Enigma rotor.
 */
struct Rotor {
    /**
     * The hardwired rotor mapping.
     */
    let mapping: [Int]

    private var rotorPosition = 0

    /**
     Initialise a new Rotor object
     - parameter mapping: The alphabetic mapping of the rotor.
     - returns: A new Rotor instance
     */
    init(mapping: [Int]) {
        self.mapping = mapping
    }

    /**
     Run the passed in Character through the rotors mapping.
     - parameter character: Input character.
     - returns: Output character after being run through the rotors mapping.
     */
    func transformCharacter(character: Character) -> Character? {
        let offset = Character("A").unicodeScalarValue()
        let value = character.unicodeScalarValue()
        let offsetValue = value - offset + rotorPosition
        let newValue = mapping[offsetValue]
        return Character(UnicodeScalar(newValue + offset))
    }

    /**
     Advance the rotor.
     */
    mutating func turnRotor() {
        rotorPosition += 1
    }
}
