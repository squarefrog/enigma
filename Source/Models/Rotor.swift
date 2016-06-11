import Foundation

/**
 *  A representation of an Enigma rotor.
 */
struct Rotor {

    var mapping: String
    let name: String
    let turnoverNotches: [Character]
    var rotorPosition = 0

    /**
     Initialise a new Rotor object
     - parameter mapping: The alphabetic mapping of the rotor.
     - parameter name: The name of the rotor.
     - parameter turnoverNotches: An array of turnover notch points,
         where passing this point will advance the next rotor.
     */
    init(mapping: String, name: String, turnoverNotches: [Character] = []) {
        self.mapping = mapping
        self.name = name
        self.turnoverNotches = turnoverNotches
    }

    /**
     Encypher a character through the rotors mapping. E.g. A -> X.
     - parameter character: Input character.
     - returns: Encyphered character.
     */
    func encypher(character: Character) -> Character? {
        let offset = Character("A").unicodeScalarValue()
        let amount = character.unicodeScalarValue() - offset
        let index = mapping.startIndex.advancedBy(amount)
        return mapping[index]
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

        let startIndex = mapping.startIndex
        let char = mapping.removeAtIndex(startIndex)
        mapping.append(char)
    }

    /**
     Apply an offset to the rotor. This is the equivalent to the ring
     setting, or *Ringstellung* in Enigma mapping documents.
     - parameter offset: The ring setting for the rotor.
     */
    mutating func ringSetting(offset: Int) {
        assert(offset < 26 && offset > 0, "Ring offset should be between 0-25")

        for _ in 0...offset {
            let index = mapping.endIndex.predecessor()
            let char = mapping.removeAtIndex(index)
            mapping.insert(char, atIndex: mapping.startIndex)
        }
    }
}

// MARK: - Equatable

extension Rotor: Equatable { }

func == (lhs: Rotor, rhs: Rotor) -> Bool {
    return lhs.mapping == rhs.mapping &&
        lhs.name == rhs.name &&
        lhs.turnoverNotches == rhs.turnoverNotches
}
