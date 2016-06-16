import Foundation
@testable import Enigma

struct MockRotorBox: RotorLoadable {
    func loadRotor(ofType type: RotorType) -> Rotor {
        return createRotorWithName(type.rawValue)
    }

    func loadReflector(ofType type: ReflectorType) -> Rotor {
        return createRotorWithName(type.rawValue)
    }

    private func createRotorWithName(name: String) -> Rotor {
        let mapping = "ZYXWVUTSRQPONMLKJIHGFEDCBA"
        return Rotor(mapping: mapping, name: name)
    }
}
