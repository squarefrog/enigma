import XCTest
@testable import Enigma

// swiftlint:disable force_try
class RotorSetTests: XCTestCase {

    var rotorSet: RotorSet!

    override func setUp() {
        super.setUp()
        rotorSet = RotorSet()
    }

    override func tearDown() {
        rotorSet = nil
        super.tearDown()
    }

    func test_ShouldLazyLoadRotorBox() {
        XCTAssertNotNil(rotorSet.rotorBox)
    }

    func test_ShouldSetFirstRotor() {
        rotorSet.rotorBox = MockRotorBox()

        try! rotorSet.loadRotorType(.I, position: .First)

        let rotor = rotorSet.firstRotor
        XCTAssertNotNil(rotor)
        XCTAssertEqual(rotor?.name, "I")
    }

    func test_ShouldSetSecondRotor() {
        rotorSet.rotorBox = MockRotorBox()

        try! rotorSet.loadRotorType(.II, position: .Second)

        let rotor = rotorSet.secondRotor
        XCTAssertNotNil(rotor)
        XCTAssertEqual(rotor?.name, "II")
    }

    func test_ShouldSetThirdRotor() {
        rotorSet.rotorBox = MockRotorBox()

        try! rotorSet.loadRotorType(.III, position: .Third)

        let rotor = rotorSet.thirdRotor
        XCTAssertNotNil(rotor)
        XCTAssertEqual(rotor?.name, "III")
    }

    func test_ShouldSetFourthRotor() {
        rotorSet.rotorBox = MockRotorBox()

        try! rotorSet.loadRotorType(.IV, position: .Fourth)

        let rotor = rotorSet.fourthRotor
        XCTAssertNotNil(rotor)
        XCTAssertEqual(rotor?.name, "IV")
    }

    func test_ShouldSetReflector() {
        rotorSet.rotorBox = MockRotorBox()

        rotorSet.loadReflectorType(.B)

        let rotor = rotorSet.reflector
        XCTAssertNotNil(rotor)
        XCTAssertEqual(rotor?.name, "UKW-B")
    }

    func test_ShouldNotAllowSettingTheSameRotorTwice() {
        try! rotorSet.loadRotorType(.I, position: .First)
        XCTAssertThrowsSpecificError(RotorSetError.RotorAlreadyUsed) {
            [unowned self] in
            try self.rotorSet.loadRotorType(.I, position: .Second)
        }
    }

    func test_ShouldEncypherLetterThroughRotors() {
        loadRotors()

        let encyphered = rotorSet.encypher(Character("A"))

        XCTAssertEqual(encyphered, Character("B"))
    }

    func test_ShouldEncypherLetterThroughRotorsWithSettings() {
        loadRotors()
        rotorSet.firstRotor?.rotorPosition = 1
        rotorSet.firstRotor?.ringSetting(2)
        rotorSet.secondRotor?.rotorPosition = 1
        rotorSet.secondRotor?.ringSetting(2)
        rotorSet.thirdRotor?.rotorPosition = 1
        rotorSet.thirdRotor?.ringSetting(2)

        let encyphered = rotorSet.encypher(Character("A"))

        XCTAssertEqual(encyphered, Character("E"))
    }

    func test_ShouldEncypherAString() {
        loadRotors()

        let encyphered = rotorSet.encypherString("AAAAA")

        XCTAssertEqual(encyphered, "BDZGO")
    }

    func test_ShouldRotateRotorsWhenRequired() {
        loadRotors()
        // Rotor III turnover = V
        rotorSet.firstRotor?.rotorPosition = 21
        // Rotor II turnover = E
        rotorSet.secondRotor?.rotorPosition = 4
        // Rotor I turnover = Q
        rotorSet.thirdRotor?.rotorPosition = 16

        let encyphered = rotorSet.encypherString("AB")

        XCTAssertEqual(encyphered, "LO")
    }

    private func loadRotors() {
        try! rotorSet.loadRotorType(.I, position: .Third)
        try! rotorSet.loadRotorType(.II, position: .Second)
        try! rotorSet.loadRotorType(.III, position: .First)
        rotorSet.loadReflectorType(.B)
    }
}
