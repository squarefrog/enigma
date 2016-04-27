import Foundation

/**
 *  A representation of two characters connected together on a Plugboard.
 */
struct Connection {
    let startPoint: Character
    let endPoint: Character
}

extension Connection: Equatable { }

func == (lhs: Connection, rhs: Connection) -> Bool {
    return lhs.startPoint == rhs.startPoint && lhs.endPoint == rhs.endPoint
}
