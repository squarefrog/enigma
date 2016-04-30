import Foundation
@testable import Enigma

struct MockDataLoader: RotorLoadable {
    func loadRotorOfType(type: RotorType) -> Rotor? {
        return createRotorWithName(type.rawValue)
    }

    func loadReflectorOfType(type: ReflectorType) -> Rotor? {
        return createRotorWithName(type.rawValue)
    }

    private func createRotorWithName(name: String) -> Rotor {
        var mapping: [Int] = []

        for i in (0...25).reverse() {
            mapping.append(i)
        }

        return Rotor(mapping: mapping, name: name)
    }
}
