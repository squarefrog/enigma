import Foundation

/**
 *  A representation of two characters connected together.
 */
struct Connection {
    let startPoint: Character
    let endPoint: Character
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
        let filteredConnections = connections.filter { (c) -> Bool in
            return c.startPoint == input || c.endPoint == input
        }

        if let connection = filteredConnections.first {
            return transformCharacter(input, connection: connection)
        }

        return input
    }

    /**
     Create a connection between a pair of letters.
     - parameter connection: The connection to create.
     */
    mutating func createConnection(connection: Connection) {
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
}
