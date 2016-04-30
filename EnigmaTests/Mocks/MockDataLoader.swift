import Foundation
@testable import Enigma

struct MockDataLoader: RotorLoadable {
    func loadRotorOfType(type: RotorType) -> Rotor? {
        return createRotor()
    }

    func loadReflectorOfType(type: ReflectorType) -> Rotor? {
        return createRotor()
    }

    private func createRotor() -> Rotor {
        var mapping: [Int] = []

        for i in (0...25).reverse() {
            mapping.append(i)
        }

        return Rotor(mapping: mapping)
    }
}
