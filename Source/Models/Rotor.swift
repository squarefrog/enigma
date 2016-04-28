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
        guard rotorPosition < 25 else {
            rotorPosition = 0
            return
        }
        rotorPosition += 1
    }

    /**
     Apply an offset to the rotor. This is the equivalent to the ring
     setting, or *Ringstellung* in Enigma mapping documents.
     - parameter offset: The ring setting for the rotor.
     */
    mutating func ringSetting(offset: Int) {
        assert(offset < 26, "Ring offset should be between 0-25")
        rotorPosition = offset
    }
}
