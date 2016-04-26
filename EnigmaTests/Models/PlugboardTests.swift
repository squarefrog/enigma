import XCTest
@testable import Enigma

class PlugboardTests: XCTestCase {
    var plugboard: Plugboard!

    override func setUp() {
        plugboard = Plugboard()
    }

    func test_ShouldPassThroughKeys() {
        let input: Character = "A"

        let output = plugboard.passthrough(input)

        XCTAssertEqual(input, output)
    }
}
