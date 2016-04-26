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

    func test_ShouldUseAConnection() {
        let connection = Connection(startPoint: "A", endPoint: "U")
        plugboard.createConnection(connection)

        let output = plugboard.passthrough("A")

        XCTAssertEqual(output, "U")
    }

    func test_ShouldUseConnectionInReverse() {
        let connection = Connection(startPoint: "A", endPoint: "U")
        plugboard.createConnection(connection)

        let output = plugboard.passthrough("U")

        XCTAssertEqual(output, "A")
    }
}
