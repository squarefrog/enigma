import Foundation

extension String {
    func stripUnwantedCharacters() -> String {
        let allowed: Set<Character> = Set("ABCDEFGHIJKLMNOPQRSTUVWXYZ".characters)
        return String(self.uppercaseString.characters.filter { allowed.contains($0) })
    }
}
