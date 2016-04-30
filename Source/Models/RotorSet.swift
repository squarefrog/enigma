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

    /**
     Load a rotor into a specific position from right to left.

     - parameter type:     The type of rotor to load.
     - parameter position: The position to load the rotor.
     */
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
