import Foundation

/**
 *  A representation of an Enigma rotor.
 */
struct Rotor {

    let mapping: [Int]
    let turnoverNotches: [Int]
    private var rotorPosition = 0

    /**
     Initialise a new Rotor object
     - parameter mapping: The alphabetic mapping of the rotor.
     - parameter turnoverNotches: An array of turnover notch points,
         where passing this point will advance the next rotor.
     */
    init(mapping: [Int], turnoverNotches: [Int] = []) {
        self.mapping = mapping
        self.turnoverNotches = turnoverNotches
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
