import XCTest
@testable import Enigma

class RotorTests: XCTestCase {

    var rotor: Rotor!

    override func setUp() {
        super.setUp()
        var mapping: [Int] = []
        for i in (0...25).reverse() {
            mapping.append(i)
        }
        rotor = Rotor(mapping: mapping)
    }

    override func tearDown() {
        rotor = nil
        super.tearDown()
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
        rotor.setOffset(2)

        let character = rotor.transformCharacter("A")
        XCTAssertEqual(character, "X")
    }

    func test_ShouldWrapAroundRingSetting() {
        rotor.setOffset(25)

        rotor.turnRotor()

        let character = rotor.transformCharacter("A")
        XCTAssertEqual(character, "Z")
    }
}
