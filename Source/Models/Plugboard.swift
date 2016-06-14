import Foundation

/**
 Thrown when the `Plugboard` was unable to create a connection.

 - OutOfConnections:  Creating the connection exceeded the maximum of 10
     connections.
 - InvalidConnection: One or more of the pairs is already in use.
 - UnevenConnections: String-based connections must be supplied in pairs.
 */
enum PlugboardError: ErrorType {
    case OutOfConnections
    case InvalidConnection
    case UnevenConnections
}

/**
 * A representation of the plugboard or *Steckerbrett*.
 */
struct Plugboard {

    /// An array of connection mappings
    var connections: [Connection] = []

    /**
     Pass a key through the plugboard.
     - parameter input: The character to passthrough.
     - returns: The transformed character.
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

        guard
            connectionForCharacter(connection.startPoint) == nil &&
            connectionForCharacter(connection.endPoint) == nil
            else {
                throw PlugboardError.InvalidConnection
        }

        connections.append(connection)
    }

    /**
     Remove a connection.
     - parameter connection: The connection to be removed.
     */
    mutating func destroyConnection(connection: Connection) {
        if let index = connections.indexOf({ $0 == connection }) {
            connections.removeAtIndex(index)
        }
    }

    /**
     Create a series of connections from a string of character pairs.
     - parameter connections: A string of character pairs.
     - throws: If connection cannot be created, or if the input string is
         uneven.
     */
    mutating func createConnectionsWithString(connections: String) throws {
        guard connections.characters.count % 2 == 0 else {
            throw PlugboardError.UnevenConnections
        }

        let characters = connections.characters
        let count = characters.count
        try 0.stride(to: count, by: 2).forEach {
            let a = connections[connections.startIndex.advancedBy($0)]
            let b = connections[connections.startIndex.advancedBy($0 + 1)]
            try self.createConnection(Connection(startPoint: a, endPoint: b))
        }
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

        return filteredConnections.first
    }
}
