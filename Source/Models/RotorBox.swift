import Foundation

/**
 *  The equivalent a box of rotors.
 */
struct RotorBox: RotorLoadable {

    // swiftlint:disable function_body_length
    func loadRotorOfType(type: RotorType) -> Rotor {
        switch type {
        case .I:
            return Rotor(mapping: "EKMFLGDQVZNTOWYHXUSPAIBRCJ",
                         name: type.rawValue,
                         turnoverNotches: ["Q"])
        case .II:
            return Rotor(mapping: "AJDKSIRUXBLHWTMCQGZNPYFVOE",
                         name: type.rawValue,
                         turnoverNotches: ["E"])
        case .III:
            return Rotor(mapping: "BDFHJLCPRTXVZNYEIWGAKMUSQO",
                         name: type.rawValue,
                         turnoverNotches: ["V"])
        case .IV:
            return Rotor(mapping: "ESOVPZJAYQUIRHXLNFTGKDCMWB",
                         name: type.rawValue,
                         turnoverNotches: ["J"])
        case .V:
            return Rotor(mapping: "VZBRGITYUPSDNHLXAWMJQOFECK",
                         name: type.rawValue,
                         turnoverNotches: ["Z"])
        case .VI:
            return Rotor(mapping: "JPGVOUMFYQBENHZRDKASXLICTW",
                         name: type.rawValue,
                         turnoverNotches: ["Z", "M"])
        case .VII:
            return Rotor(mapping: "NZJHGRCXMYSWBOUFAIVLPEKQDT",
                         name: type.rawValue,
                         turnoverNotches: ["Z", "M"])
        case .VIII:
            return Rotor(mapping: "FKQHTLXOCBJSPDZRAMEWNIUYGV",
                         name: type.rawValue,
                         turnoverNotches: ["Z", "M"])
        case .Beta:
            return Rotor(mapping: "LEYJVCNIXWPBQMDRTAKZGFUHOS",
                         name: type.rawValue,
                         turnoverNotches: [])
        case .Gamma:
            return Rotor(mapping: "FSOKANUERHMBTIYCWLQPZXVGJD",
                         name: type.rawValue,
                         turnoverNotches: [])
        }
    }

    func loadReflectorOfType(type: ReflectorType) -> Rotor {
        switch type {
        case .B:
            return Rotor(mapping: "YRUHQSLDPXNGOKMIEBFZCWVJAT",
                         name: type.rawValue,
                         turnoverNotches: [])
        case .C:
            return Rotor(mapping: "FVPJIAOYEDRZXWGCTKUQSBNMHL",
                         name: type.rawValue,
                         turnoverNotches: [])
        case .ThinB:
            return Rotor(mapping: "ENKQAUYWJICOPBLMDXZVFTHRGS",
                         name: type.rawValue,
                         turnoverNotches: [])
        case .ThinC:
            return Rotor(mapping: "RDOBJNTKVEHMLFCWZAXGYIPSUQ",
                         name: type.rawValue,
                         turnoverNotches: [])
        }
    }
}
