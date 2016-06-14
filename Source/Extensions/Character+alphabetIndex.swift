import Foundation

extension Character {
    var alphabetIndex: Int {
        let startValue = Character("A").unicodeScalarValue()
        return self.unicodeScalarValue() - startValue
    }
}
