import Foundation

/**
 *  A representation of two characters connected together.
 */
struct Connection {
    let startPoint: Character
    let endPoint: Character
}

enum PlugboardError: ErrorType {
    /**
     *  The plugboard has a maximum of 10 connections.
     */
    case OutOfConnections
    case InvalidConnection
}

/**
 * A representation of the plugboard or *Steckerbrett*.
 */
struct Plugboard {

    var connections: [Connection] = []

    /**
     Pass a key through the plugboard.
     - parameter input: The input alpha code to passthrough.
     - returns: The output alpha code, transformed if necessary.
     */
    func passthrough(input: Character) -> Character {
        if let connection = connectionForCharacter(input) {
            return transformCharacter(input, connection: connection)
        }

        return input
    }

    /**
     Create a connection between a pair of letters.
     - parameter connection: The connection to create.
     - throws: A PlugboardError if connection cannot be made
     */
    mutating func createConnection(connection: Connection) throws {
        guard connections.count < 10 else {
            throw PlugboardError.OutOfConnections
        }

        guard connectionForCharacter(connection.startPoint) == nil &&
            connectionForCharacter(connection.endPoint) == nil else {
                throw PlugboardError.InvalidConnection
        }

        connections.append(connection)
    }

    // MARK: - Private API

    private func transformCharacter(character: Character,
                                    connection: Connection) -> Character {
        if connection.startPoint == character {
            return connection.endPoint
        }

        if connection.endPoint == character {
            return connection.startPoint
        }

        return character
    }

    private func connectionForCharacter(character: Character) -> Connection? {
        let filteredConnections = connections.filter { (c) -> Bool in
            return c.startPoint == character || c.endPoint == character
        }

        if let connection = filteredConnections.first {
            return connection
        }

        return nil
    }
}
