import XCTest
@testable import Enigma

class PlugboardTests: XCTestCase {
    var plugboard: Plugboard!

    override func setUp() {
        plugboard = Plugboard()
    }

    func test_ShouldPassThroughKeys() {
        let input = 0

        let output = plugboard.passthrough(0)

        XCTAssertEqual(input, output)
    }
}
