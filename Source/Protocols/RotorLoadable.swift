import Foundation

/**
 *  Declared as a protocol to allow injecting of mock objects within unit tests.
 */
protocol RotorLoadable {
    func loadRotor(ofType type: RotorType) -> Rotor
    func loadReflector(ofType type: ReflectorType) -> Rotor
}
