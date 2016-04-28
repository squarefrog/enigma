import Foundation

/**
 *  A representation of an Enigma rotor.
 */
struct Rotor {
    /**
     * The hardwired rotor mapping.
     */
    let mapping: [Int]

    /**
     Run the passed in Character through the rotors mapping.
     - parameter character: Input character.
     - returns: Output character after being run through the rotors mapping.
     */
    func transformCharacter(character: Character) -> Character? {
        let offset = Character("A").unicodeScalarValue()
        let scalar = String(character).unicodeScalars
        let value = Int(scalar[scalar.startIndex].value) - offset
        let newValue = mapping[value]
        return Character(UnicodeScalar(newValue + offset))
    }
}
