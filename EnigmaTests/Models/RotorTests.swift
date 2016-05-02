import XCTest
@testable import Enigma

class RotorTests: XCTestCase {

    var rotor: Rotor!
    let mapping = "ZYXWVUTSRQPONMLKJIHGFEDCBA"
    let rotorName = "IV"

    override func setUp() {
        super.setUp()
        rotor = Rotor(mapping: mapping, name: rotorName)
    }

    override func tearDown() {
        rotor = nil
        super.tearDown()
    }

    func test_ShouldSetNameVariable() {
        XCTAssertEqual(rotor.name, rotorName)
    }

    func test_ShouldTransformALetterThroughTheRotorsMapping() {
        let character = rotor.transformCharacter("A")
        XCTAssertEqual(character, "Z")
    }

    func test_ShouldIncrementMapping() {
        rotor.turnRotor()

        let character = rotor.transformCharacter("A")
        XCTAssertEqual(character, "Y")
    }

    func test_ShouldAllowRingOffset() {
        rotor.ringSetting(2)

        let character = rotor.transformCharacter("A")
        XCTAssertEqual(character, "C")
    }

    func test_TurnoverNotchesShouldBeOptional() {
        XCTAssertEqual(rotor.turnoverNotches, [])
    }

    func test_TurnoverNotchesShouldBeReturned() {
        let notches: [Character] = [ "Z", "M" ]
        rotor = Rotor(mapping: mapping,
                      name: rotorName,
                      turnoverNotches: notches)

        XCTAssertEqual(rotor.turnoverNotches, notches)
    }
}
