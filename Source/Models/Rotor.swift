import Foundation

/**
 *  A representation of an Enigma rotor.
 */
struct Rotor {

    // MARK: - Properties

    var mapping: String
    let name: String
    let turnoverNotches: [Character]
    var rotorPosition = 0 {
        didSet {
            let diff = rotorPosition - oldValue
            if diff < 1 {
                decrementMapping(byAmount: abs(diff))
            } else {
                incrementMapping(byAmount: diff)
            }
        }
    }
    var shouldTurnover: Bool {
        return turnoverNotches.contains(currentCharacter)
    }
    var currentCharacter: Character {
        let offset = Character("A").unicodeScalarValue()
        let char = offset + rotorPosition
        return Character(UnicodeScalar(char))
    }
    private var currentRingSetting: Int = 0 {
        didSet {
            incrementMapping(byAmount: oldValue)
            decrementMapping(byAmount: currentRingSetting)
        }
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
     Decypher a character through the rotors mapping. E.g. X -> A.

     - parameter character: Input character.
     - returns: Decyphered character.
     */
    func decypher(character: Character) -> Character {
        let index = mapping.characters.indexOf(character)
        let distance = mapping.startIndex.distanceTo(index!)
        let offset = Character("A").unicodeScalarValue()
        return Character(UnicodeScalar(offset + distance))
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

    mutating func resetMapping() {
        decrementMapping(byAmount: rotorPosition)
        currentRingSetting = 0
    }

    // MARK: - Private API

    private mutating func decrementMapping(byAmount offsetAmount: Int) {
        for _ in 0..<offsetAmount {
            let endIndex = mapping.endIndex.predecessor()
            let char = mapping.removeAtIndex(endIndex)
            mapping.insert(char, atIndex: mapping.startIndex)
        }
    }

    private mutating func incrementMapping(byAmount offsetAmount: Int) {
        for _ in 0..<offsetAmount {
            let startIndex = mapping.startIndex
            let char = mapping.removeAtIndex(startIndex)
            mapping.append(char)
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
