import Foundation

/**
 *  A managing class of a set of rotors.
 */
struct RotorSet {

    lazy var dataLoader: RotorLoadable = RotorDataLoader()
    var firstRotor: Rotor?
    var secondRotor: Rotor?
    var thirdRotor: Rotor?
    var fourthRotor: Rotor?

    mutating func loadRotorType(type: RotorType, position: RotorPosition) {
        guard let rotor = dataLoader.loadRotorOfType(type) else { return }

        switch position {
        case .First: firstRotor = rotor
        case .Second: secondRotor = rotor
        case .Third: thirdRotor = rotor
        case .Fourth: fourthRotor = rotor
        default: return
        }
    }
}
