import XCTest
@testable import Enigma

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

    func test_ShouldLazyLoadRotorDataLoader() {
        XCTAssertNotNil(rotorSet.dataLoader)
    }

    func test_ShouldSetFirstRotor() {
        rotorSet.dataLoader = MockDataLoader()

        rotorSet.loadRotorType(.I, position: .First)

        let rotor = rotorSet.firstRotor
        XCTAssertNotNil(rotor)
        XCTAssertEqual(rotor?.name, "I")
    }

    func test_ShouldSetSecondRotor() {
        rotorSet.dataLoader = MockDataLoader()

        rotorSet.loadRotorType(.II, position: .Second)

        let rotor = rotorSet.secondRotor
        XCTAssertNotNil(rotor)
        XCTAssertEqual(rotor?.name, "II")
    }

    func test_ShouldSetThirdRotor() {
        rotorSet.dataLoader = MockDataLoader()

        rotorSet.loadRotorType(.III, position: .Third)

        let rotor = rotorSet.thirdRotor
        XCTAssertNotNil(rotor)
        XCTAssertEqual(rotor?.name, "III")
    }

    func test_ShouldSetFourthRotor() {
        rotorSet.dataLoader = MockDataLoader()

        rotorSet.loadRotorType(.IV, position: .Fourth)

        let rotor = rotorSet.fourthRotor
        XCTAssertNotNil(rotor)
        XCTAssertEqual(rotor?.name, "IV")
    }

    func test_ShouldSetReflector() {
        rotorSet.dataLoader = MockDataLoader()

        rotorSet.loadReflectorType(.B)

        let rotor = rotorSet.reflector
        XCTAssertNotNil(rotor)
        XCTAssertEqual(rotor?.name, "UKW-B")
    }
}
