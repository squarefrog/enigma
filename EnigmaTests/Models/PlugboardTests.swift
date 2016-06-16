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
        let connection = Connection("A", "U")
        try! plugboard.createConnection(connection)

        let output = plugboard.passthrough("A")

        XCTAssertEqual(output, "U")
    }

    func test_ShouldUseConnectionInReverse() {
        let connection = Connection("A", "U")
        try! plugboard.createConnection(connection)

        let output = plugboard.passthrough("U")

        XCTAssertEqual(output, "A")
    }

    func test_ShouldHaveMaximumOfTenConnections() {
        let connections = [
            Connection("A", "B"),
            Connection("C", "D"),
            Connection("E", "F"),
            Connection("G", "H"),
            Connection("I", "J"),
            Connection("K", "L"),
            Connection("M", "N"),
            Connection("O", "P"),
            Connection("Q", "R"),
            Connection("S", "T")
        ]

        for connection in connections {
            try! plugboard.createConnection(connection)
        }

        let connection = Connection("U", "V")

        XCTAssertThrowsSpecificError(PlugboardError.OutOfConnections) {
            [unowned self] in
            try self.plugboard.createConnection(connection)
        }
    }

    func test_ShouldNotAllowConnectionToExistingConnection() {
        let connection = Connection("A", "B")
        try! plugboard.createConnection(connection)

        let newConnection = Connection("A", "Z")

        XCTAssertThrowsSpecificError(PlugboardError.InvalidConnection) {
            [unowned self]  in
            try self.plugboard.createConnection(newConnection)
        }
    }

    func test_ShouldAllowDestroyingConnection() {
        let connection = Connection("A", "B")
        try! plugboard.createConnection(connection)
        XCTAssertEqual(plugboard.passthrough("A"), "B")

        plugboard.removeConnection(connection)

        XCTAssertEqual("A", "A")
    }

    func test_ShouldCreateConnectionsFromString() {
        let string = "AZBY"

        try! plugboard.createConnectionsWithString(string)

        let expected: [Connection] = [ Connection("A", "Z"), Connection("B", "Y") ]
        AssertEqualConnections(plugboard.connections, expected)
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

        AssertEqualConnections(plugboard.connections, [Connection("A", "Z")])
    }

    // MARK: - Private Test Helpers

    private func AssertEqualConnections(expression1: [Connection],
                                _ expression2: [Connection],
                                  file: StaticString = #file,
                                  line: UInt = #line) {
        let isEqual = expression1.elementsEqual(expression2, isEquivalent: ==)
        XCTAssertTrue(isEqual, "connections are not equal", file: file, line: line)
    }
}
