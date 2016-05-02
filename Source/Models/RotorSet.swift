import Foundation

enum RotorSetError: ErrorType {
    case RotorAlreadyUsed
}

/**
 *  A managing class of a set of rotors.
 */
struct RotorSet {

    lazy var dataLoader: RotorLoadable = RotorDataLoader()
    var firstRotor: Rotor?
    var secondRotor: Rotor?
    var thirdRotor: Rotor?
    var fourthRotor: Rotor?
    var reflector: Rotor?

    /**
     Load a rotor into a specific position from right to left.

     - parameter type:     The type of rotor to load.
     - parameter position: The position to load the rotor.
     - throws: RotorSetError if unable to load rotor.
     */
    mutating func loadRotorType(type: RotorType, position: RotorPosition) throws {
        let rotor = dataLoader.loadRotorOfType(type)

        for loadedRotor in [ firstRotor, secondRotor, thirdRotor, fourthRotor ] {
            if rotor == loadedRotor {
                throw RotorSetError.RotorAlreadyUsed
            }
        }

        switch position {
        case .First: firstRotor = rotor
        case .Second: secondRotor = rotor
        case .Third: thirdRotor = rotor
        case .Fourth: fourthRotor = rotor
        }
    }

    /**
     Load a reflector rotor into the reflector position.

     - parameter type: The reflector type to load.
     */
    mutating func loadReflectorType(type: ReflectorType) {
        reflector = dataLoader.loadReflectorOfType(type)
    }
}
