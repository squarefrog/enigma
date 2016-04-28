import Foundation

extension Character {
    func unicodeScalarValue() -> Int {
        let string = String(self)
        let scalars = string.unicodeScalars
        return Int(scalars[scalars.startIndex].value)
    }
}
