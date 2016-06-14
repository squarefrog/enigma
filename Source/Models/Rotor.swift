import Foundation

/**
 *  A representation of an Enigma rotor.
 */
struct Rotor {

    // MARK: - Properties

    let turnoverNotches: [Int]
    var mapping: String
    let name: String
    var rotorPosition = 0
    var shouldTurnover: Bool {
        return turnoverNotches.contains(mappingOffset)
    }
    private var currentRingSetting: Int = 0
    private var mappingOffset: Int {
        return (rotorPosition + (26 - currentRingSetting)) % 26
    }

    // MARK: - Public API

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
        self.turnoverNotches = turnoverNotches.map { $0.alphabetIndex }
    }

    /**
     Encypher a character through the rotors mapping. E.g. A -> X.
     - parameter character: Input character.
     - returns: Encyphered character.
     */
    func encypher(character: Character) -> Character? {
        let charValue = character.alphabetIndex
        let encypheredIndex = Int((charValue + mappingOffset) % 26)
        let mappingIndex = mapping.startIndex.advancedBy(encypheredIndex)
        return mapping[mappingIndex]
    }

    /**
     Decypher a character through the rotors mapping. E.g. X -> A.

     - parameter character: Input character.
     - returns: Decyphered character.
     */
    func decypher(character: Character) -> Character {
        let index = mapping.characters.indexOf(character)
        let distance = mapping.startIndex.distanceTo(index!)
        var offset = distance - (mappingOffset % 26)
        if offset < 0 {
            offset += 26
        }
        let alphabetStartValue = Character("A").unicodeScalarValue()
        return Character(UnicodeScalar(alphabetStartValue + offset))
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
        currentRingSetting = max(offset % 25, 0)
    }

    /**
     Reset the rotor position and ring setting to zero.
     */
    mutating func resetMapping() {
        rotorPosition = 0
        currentRingSetting = 0
    }
}

// MARK: - Equatable

extension Rotor: Equatable { }

func == (lhs: Rotor, rhs: Rotor) -> Bool {
    return lhs.mapping == rhs.mapping &&
        lhs.name == rhs.name &&
        lhs.turnoverNotches == rhs.turnoverNotches
}
