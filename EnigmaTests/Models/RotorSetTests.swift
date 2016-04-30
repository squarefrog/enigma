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

        let firstRotor = rotorSet.firstRotor
        XCTAssertNotNil(firstRotor)
        XCTAssertEqual(firstRotor?.name, "I")
    }

    func test_ShouldSetSecondRotor() {
        rotorSet.dataLoader = MockDataLoader()

        rotorSet.loadRotorType(.II, position: .Second)

        let firstRotor = rotorSet.secondRotor
        XCTAssertNotNil(firstRotor)
        XCTAssertEqual(firstRotor?.name, "II")
    }
}
