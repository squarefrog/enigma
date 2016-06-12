import Foundation

protocol RotorLoadable {
    func loadRotorOfType(type: RotorType) -> Rotor
    func loadReflectorOfType(type: ReflectorType) -> Rotor
}
