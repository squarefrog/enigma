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

/// A tuple representation of a plugboard connection.
typealias Connection = (Character, Character)

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
        if let connection = findConnection(forCharacter: input) {
            return transform(input, connection: connection)
        }

        return input
    }

    /**
     Create a connection between a pair of letters.
     - parameter connection: The connection to create.
     - throws: A PlugboardError if connection cannot be made
     */
    mutating func create(connection: Connection) throws {
        guard connections.count < 10 else {
            throw PlugboardError.OutOfConnections
        }

        guard
            findConnection(forCharacter: connection.0) == nil &&
            findConnection(forCharacter: connection.1) == nil
            else {
                throw PlugboardError.InvalidConnection
        }

        connections.append(connection)
    }

    /**
     Remove a connection.
     - parameter connection: The connection to be removed.
     */
    mutating func remove(connection: Connection) {
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
    mutating func createConnections(withString connections: String) throws {
        let connections = connections.stripUnwantedCharacters()
        guard connections.characters.count % 2 == 0 else {
            throw PlugboardError.UnevenConnections
        }

        let characters = connections.characters
        let count = characters.count
        try 0.stride(to: count, by: 2).forEach {
            let a = connections[connections.startIndex.advancedBy($0)]
            let b = connections[connections.startIndex.advancedBy($0 + 1)]
            try self.create(Connection(startPoint: a, endPoint: b))
        }
    }

    // MARK: - Private API

    private func transform(character: Character, connection: Connection) -> Character {
        switch connection {
        case let (a, b) where a == character:
            return b
        case let (a, b) where b == character:
            return a
        default:
            return character
        }
    }

    private func findConnection(forCharacter character: Character) -> Connection? {
        let filteredConnections = connections.filter { (c) -> Bool in
            return c.0 == character || c.1 == character
        }

        return filteredConnections.first
    }
}
