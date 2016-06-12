import Foundation
@testable import Enigma

struct MockRotorBox: RotorLoadable {
    func loadRotorOfType(type: RotorType) -> Rotor {
        return createRotorWithName(type.rawValue)
    }

    func loadReflectorOfType(type: ReflectorType) -> Rotor {
        return createRotorWithName(type.rawValue)
    }

    private func createRotorWithName(name: String) -> Rotor {
        let mapping = "ZYXWVUTSRQPONMLKJIHGFEDCBA"
        return Rotor(mapping: mapping, name: name)
    }
}
