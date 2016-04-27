import XCTest
@testable import Enigma

class RotorTests: XCTestCase {

    var rotor: Rotor!

    override func setUp() {
        super.setUp()
        rotor = Rotor()
    }

    override func tearDown() {
        rotor = nil
        super.tearDown()
    }
}
