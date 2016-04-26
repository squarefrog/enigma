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
        try! plugboard.createConnection(connection)

        let output = plugboard.passthrough("A")

        XCTAssertEqual(output, "U")
    }

    func test_ShouldUseConnectionInReverse() {
        let connection = Connection(startPoint: "A", endPoint: "U")
        try! plugboard.createConnection(connection)

        let output = plugboard.passthrough("U")

        XCTAssertEqual(output, "A")
    }

    func test_ShouldHaveMaximumOfTenConnections() {
        let connections = [
            Connection(startPoint: "A", endPoint: "B"),
            Connection(startPoint: "C", endPoint: "D"),
            Connection(startPoint: "E", endPoint: "F"),
            Connection(startPoint: "G", endPoint: "H"),
            Connection(startPoint: "I", endPoint: "J"),
            Connection(startPoint: "K", endPoint: "L"),
            Connection(startPoint: "M", endPoint: "N"),
            Connection(startPoint: "O", endPoint: "P"),
            Connection(startPoint: "Q", endPoint: "R"),
            Connection(startPoint: "S", endPoint: "T")
        ]

        for connection in connections {
            try! plugboard.createConnection(connection)
        }

        let connection = Connection(startPoint: "U", endPoint: "V")

        XCTAssertThrowsError(try plugboard.createConnection(connection))
    }
}
