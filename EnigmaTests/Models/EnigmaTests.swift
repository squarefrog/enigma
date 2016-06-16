import XCTest
@testable import Enigma

// swiftlint:disable force_try

class EnigmaTests: XCTestCase {
    func test_EnigmaCanEnypherText() {
        var enigma = Enigma()
        enigma.rotorSet = setupRotorSet()
        enigma.plugboard = setupPlugboard()
        let inputText = "NQVLTYQFSEWWGJZGQHVSEIXIMYKCNWIEBMBATPPZTDVCUPKAY"
        let expected = "FLUGZEUGFUEHRERISTOFWYYXFUELLGRAFXFUELLGPAFXPOFOP"

        let encyphered = enigma.encypher(inputText)

        XCTAssertEqual(encyphered, expected)
    }

    func test_EnigmaCanDecypherText() {
        var enigma = Enigma()
        enigma.rotorSet = setupRotorSet()
        enigma.plugboard = setupPlugboard()
        let inputText = "FLUGZEUGFUEHRERISTOFWYYXFUELLGRAFXFUELLGPAFXPOFOP"
        let expected = "NQVLTYQFSEWWGJZGQHVSEIXIMYKCNWIEBMBATPPZTDVCUPKAY"

        let encyphered = enigma.encypher(inputText)

        XCTAssertEqual(encyphered, expected)
    }

    func setupRotorSet() -> RotorSet {
        var rotorSet = RotorSet()
        try! rotorSet.loadRotorType(.V, position: .First)
        try! rotorSet.loadRotorType(.II, position: .Second)
        try! rotorSet.loadRotorType(.IV, position: .Third)
        rotorSet.loadReflectorType(.B)
        rotorSet.firstRotor?.ringSetting(24)
        rotorSet.secondRotor?.ringSetting(12)
        rotorSet.thirdRotor?.ringSetting(6)
        rotorSet.firstRotor?.rotorPosition = 15
        rotorSet.secondRotor?.rotorPosition = 11
        rotorSet.thirdRotor?.rotorPosition = 17
        return rotorSet
    }

    func setupPlugboard() -> Plugboard {
        var plugboard = Plugboard()
        try! plugboard.createConnections(withString: "DNGRISKCQXTMPVHYFWBJ")
        return plugboard
    }
}
