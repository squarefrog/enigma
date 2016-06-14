import Foundation

/**
 *  Declared as a protocol to allow injecting of mock objects within unit tests.
 */
protocol RotorLoadable {
    func loadRotorOfType(type: RotorType) -> Rotor
    func loadReflectorOfType(type: ReflectorType) -> Rotor
}
