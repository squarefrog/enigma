import XCTest
@testable import Enigma

class RotorTests: XCTestCase {

    var rotor: Rotor!
    let mapping = "ZYXWVUTSRQPONMLKJIHGFEDCBA"
    let rotorName = "IV"

    // MARK: - Setup

    override func setUp() {
        super.setUp()
        rotor = Rotor(mapping: mapping, name: rotorName)
    }

    override func tearDown() {
        rotor = nil
        super.tearDown()
    }

    // MARK: - Setting Variables

    func test_ShouldSetNameVariable() {
        XCTAssertEqual(rotor.name, rotorName)
    }

    func test_ShouldSetMapping() {
        XCTAssertEqual(rotor.mapping, mapping)
    }

    // MARK: - Encypher/Decypher

    func test_ShouldEncypherACharacter() {
        let character = rotor.encypher("A")
        XCTAssertEqual(character, "Z")
    }

    func test_ShouldDecypherACharacter() {
        let character = rotor.decypher("Z")
        XCTAssertEqual(character, "A")
    }

    // MARK: - Turning Rotor

    func test_ShouldIncrementMappingWhenTurned() {
        rotor.turnRotor()

        let character = rotor.encypher("A")
        XCTAssertEqual(character, "Y")
    }

    // MARK: - Rotor Position

    func test_ShouldAllowSettingRotorOffset() {
        rotor.rotorPosition = 2

        let mapping = rotor.mapping

        XCTAssertEqual(mapping, "XWVUTSRQPONMLKJIHGFEDCBAZY")
    }

    func test_ShouldWrapAroundRotorPosition() {
        rotor.rotorPosition = 25
        rotor.turnRotor()

        let mapping = rotor.mapping

        XCTAssertEqual(mapping, "ZYXWVUTSRQPONMLKJIHGFEDCBA")
    }

    func test_ShouldBehaveWhenSettingRotorPositionTwice() {
        rotor.rotorPosition = 6
        rotor.rotorPosition = 2

        let mapping = rotor.mapping

        XCTAssertEqual(mapping, "XWVUTSRQPONMLKJIHGFEDCBAZY")
    }

    func test_ShouldAllowResettingAMappingAfterUsingRotorPosition() {
        rotor.rotorPosition = 4
        XCTAssertEqual(rotor.mapping, "VUTSRQPONMLKJIHGFEDCBAZYXW")

        rotor.resetMapping()

        XCTAssertEqual(rotor.mapping, "ZYXWVUTSRQPONMLKJIHGFEDCBA")
    }

    // MARK: - Ring Setting

    func test_ShouldAllowRingOffset() {
        rotor.ringSetting(2)

        let character = rotor.encypher("A")
        XCTAssertEqual(character, "B")
    }

    func test_ShouldAllowResettingAMappingAfterUsingRingSetting() {
        rotor.ringSetting(4)
        XCTAssertEqual(rotor.mapping, "DCBAZYXWVUTSRQPONMLKJIHGFE")

        rotor.resetMapping()

        XCTAssertEqual(rotor.mapping, "ZYXWVUTSRQPONMLKJIHGFEDCBA")
    }

    func test_ShouldAllowResettingAMappingAfterUsingRotorPositionAndRingSetting() {
        rotor.rotorPosition = 3
        rotor.ringSetting(4)
        XCTAssertEqual(rotor.mapping, "AZYXWVUTSRQPONMLKJIHGFEDCB")

        rotor.resetMapping()

        XCTAssertEqual(rotor.mapping, "ZYXWVUTSRQPONMLKJIHGFEDCBA")
    }

    func test_ShouldShouldResetBeforeChangingRingSetting() {
        rotor.ringSetting(4)

        rotor.ringSetting(1)

        XCTAssertEqual(rotor.mapping, "AZYXWVUTSRQPONMLKJIHGFEDCB")
    }

    func test_ShouldNotCrashWhenRingSettingIsNegative() {
        rotor.ringSetting(-1)
        XCTAssertEqual(rotor.mapping, "ZYXWVUTSRQPONMLKJIHGFEDCBA")
    }

    func test_ShouldNotCrashWhenRingSettingIsTooHigh() {
        rotor.ringSetting(26)
        XCTAssertEqual(rotor.mapping, "AZYXWVUTSRQPONMLKJIHGFEDCB")
    }

    // MARK: - Turnover Setting

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
