import Foundation

struct Enigma {
    var plugboard: Plugboard!
    var rotorSet: RotorSet!

    mutating func encypher(string: String) -> String {
        return String(string.characters.map { char -> Character in
            var c = plugboard.passthrough(char)
            c = rotorSet.encypher(c)
            return plugboard.passthrough(c)
        })
    }
}
