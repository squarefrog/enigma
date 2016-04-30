import Foundation

/**
 *  A managing class of a set of rotors.
 */
struct RotorSet {

    lazy var dataLoader: RotorLoadable = RotorDataLoader()
    var firstRotor: Rotor?

    mutating func loadRotorType(type: RotorType, position: RotorPosition) {
        guard let rotor = dataLoader.loadRotorOfType(type) else { return }

        switch position {
        case .First: firstRotor = rotor
        default: return
        }
    }
}
