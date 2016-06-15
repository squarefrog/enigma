import XCTest
@testable import Enigma

// swiftlint:disable force_try

class PlugboardTests: XCTestCase {
    var plugboard: Plugboard!

    override func setUp() {
        super.setUp()
        plugboard = Plugboard()
    }

    override func tearDown() {
        plugboard = nil
        super.tearDown()
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

        XCTAssertThrowsSpecificError(PlugboardError.OutOfConnections) {
            [unowned self] in
            try self.plugboard.createConnection(connection)
        }
    }

    func test_ShouldNotAllowConnectionToExistingConnection() {
        let connection = Connection(startPoint: "A", endPoint: "B")
        try! plugboard.createConnection(connection)

        let newConnection = Connection(startPoint: "A", endPoint: "Z")

        XCTAssertThrowsSpecificError(PlugboardError.InvalidConnection) {
            [unowned self]  in
            try self.plugboard.createConnection(newConnection)
        }
    }

    func test_ShouldAllowDestroyingConnection() {
        let connection = Connection(startPoint: "A", endPoint: "B")
        try! plugboard.createConnection(connection)
        XCTAssertEqual(plugboard.passthrough("A"), "B")

        plugboard.destroyConnection(connection)

        XCTAssertEqual("A", "A")
    }

    func test_ShouldCreateConnectionsFromString() {
        let string = "AZBY"

        try! plugboard.createConnectionsWithString(string)

        let expected = [
            Connection(startPoint: "A", endPoint: "Z"),
            Connection(startPoint: "B", endPoint: "Y")
        ]
        XCTAssertEqual(plugboard.connections, expected)
    }

    func test_ShouldRaiseWhenGivenUnevenPairString() {
        let pairs = "AZB"

        XCTAssertThrowsSpecificError(PlugboardError.UnevenConnections) {
            [unowned self]  in
            try self.plugboard.createConnectionsWithString(pairs)
        }
    }

    func test_ShouldCreateConnectionsFromACleansedString() {
        let string = ".A z=-34"

        try! plugboard.createConnectionsWithString(string)

        let expected = [
            Connection(startPoint: "A", endPoint: "Z")
        ]
        XCTAssertEqual(plugboard.connections, expected)
    }
}
