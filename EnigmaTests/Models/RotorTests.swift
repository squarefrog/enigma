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

    func test_ShouldEncypherWithRotorPosition() {
        rotor.rotorPosition = 2

        let character = rotor.encypher("A")
        XCTAssertEqual(character, "X")
    }

    func test_ShouldDecypherWithRotorPosition() {
        rotor.rotorPosition = 2

        let character = rotor.decypher("X")
        XCTAssertEqual(character, "A")
    }

    func test_ShouldDecypherWithHigherRotorPosition() {
        rotor.rotorPosition = 3

        let character = rotor.decypher("X")
        XCTAssertEqual(character, "Z")
    }

    func test_ShouldWrapAroundRotorPosition() {
        rotor.rotorPosition = 25
        XCTAssertEqual(rotor.encypher("A"), "A")

        rotor.turnRotor()

        XCTAssertEqual(rotor.encypher("A"), "Z")
    }

    // MARK: - Ring Setting

    func test_ShouldEncypherWithRingSetting() {
        rotor.ringSetting(2)

        let character = rotor.encypher("A")
        XCTAssertEqual(character, "B")
    }

    func test_ShouldDecypherWithRingSetting() {
        rotor.ringSetting(2)

        let character = rotor.encypher("B")
        XCTAssertEqual(character, "A")
    }

    func test_EqualRingAndRotorPositionsShouldCancelOut() {
        rotor.ringSetting(2)
        rotor.rotorPosition = 2

        let character = rotor.encypher("A")

        XCTAssertEqual(character, "Z")
    }

    // MARK: - Turnover Setting

    func test_ShouldStateWhenReadyToTurnover() {
        rotor = Rotor(mapping: mapping,
                      name: rotorName,
                      turnoverNotches: ["A"])

        XCTAssertTrue(rotor.shouldTurnover)
    }

    func test_ShouldTurnoverWhenUsingRotorPosition() {
        rotor = Rotor(mapping: mapping,
                      name: rotorName,
                      turnoverNotches: ["B"])
        rotor.rotorPosition = 1

        XCTAssertTrue(rotor.shouldTurnover)
    }

    func test_ShouldTurnoverWhenUsingRingSetting() {
        rotor = Rotor(mapping: mapping,
                      name: rotorName,
                      turnoverNotches: ["Z"])
        rotor.ringSetting(1)

        XCTAssertTrue(rotor.shouldTurnover)
    }
}
