import XCTest
@testable import Enigma

class RotorBoxTests: XCTestCase {

    var dataLoader: RotorBox!

    override func setUp() {
        super.setUp()
        dataLoader = RotorBox()
    }

    override func tearDown() {
        dataLoader = nil
        super.tearDown()
    }

    func test_ShouldCreateRotorOfTypeI() {
        let rotor = dataLoader.loadRotorOfType(.I)
        XCTAssertEqual(rotor.mapping, "EKMFLGDQVZNTOWYHXUSPAIBRCJ")

        let notches = [Character("Q").alphabetIndex]
        XCTAssertEqual(rotor.turnoverNotches, notches)
    }

    func test_ShouldCreateRotorOfTypeII() {
        let rotor = dataLoader.loadRotorOfType(.II)
        XCTAssertEqual(rotor.mapping, "AJDKSIRUXBLHWTMCQGZNPYFVOE")

        let notches = [Character("E").alphabetIndex]
        XCTAssertEqual(rotor.turnoverNotches, notches)
    }

    func test_ShouldCreateRotorOfTypeIII() {
        let rotor = dataLoader.loadRotorOfType(.III)
        XCTAssertEqual(rotor.mapping, "BDFHJLCPRTXVZNYEIWGAKMUSQO")

        let notches = [Character("V").alphabetIndex]
        XCTAssertEqual(rotor.turnoverNotches, notches)
    }

    func test_ShouldCreateRotorOfTypeIV() {
        let rotor = dataLoader.loadRotorOfType(.IV)
        XCTAssertEqual(rotor.mapping, "ESOVPZJAYQUIRHXLNFTGKDCMWB")

        let notches = [Character("J").alphabetIndex]
        XCTAssertEqual(rotor.turnoverNotches, notches)
    }

    func test_ShouldCreateRotorOfTypeV() {
        let rotor = dataLoader.loadRotorOfType(.V)
        XCTAssertEqual(rotor.mapping, "VZBRGITYUPSDNHLXAWMJQOFECK")

        let notches = [Character("Z").alphabetIndex]
        XCTAssertEqual(rotor.turnoverNotches, notches)
    }

    func test_ShouldCreateRotorOfTypeVI() {
        let rotor = dataLoader.loadRotorOfType(.VI)
        XCTAssertEqual(rotor.mapping, "JPGVOUMFYQBENHZRDKASXLICTW")

        let notches = [Character("Z").alphabetIndex, Character("M").alphabetIndex]
        XCTAssertEqual(rotor.turnoverNotches, notches)
    }

    func test_ShouldCreateRotorOfTypeVII() {
        let rotor = dataLoader.loadRotorOfType(.VII)
        XCTAssertEqual(rotor.mapping, "NZJHGRCXMYSWBOUFAIVLPEKQDT")

        let notches = [Character("Z").alphabetIndex, Character("M").alphabetIndex]
        XCTAssertEqual(rotor.turnoverNotches, notches)
    }

    func test_ShouldCreateRotorOfTypeVIII() {
        let rotor = dataLoader.loadRotorOfType(.VIII)
        XCTAssertEqual(rotor.mapping, "FKQHTLXOCBJSPDZRAMEWNIUYGV")

        let notches = [Character("Z").alphabetIndex, Character("M").alphabetIndex]
        XCTAssertEqual(rotor.turnoverNotches, notches)
    }

    func test_ShouldCreateRotorOfTypeBeta() {
        let rotor = dataLoader.loadRotorOfType(.Beta)

        XCTAssertEqual(rotor.mapping, "LEYJVCNIXWPBQMDRTAKZGFUHOS")
        XCTAssertEqual(rotor.turnoverNotches, [])
    }

    func test_ShouldCreateRotorOfTypeGamma() {
        let rotor = dataLoader.loadRotorOfType(.Gamma)

        XCTAssertEqual(rotor.mapping, "FSOKANUERHMBTIYCWLQPZXVGJD")
        XCTAssertEqual(rotor.turnoverNotches, [])
    }

    func test_ShouldCreateReflectorOfTypeB() {
        let rotor = dataLoader.loadReflectorOfType(.B)

        XCTAssertEqual(rotor.mapping, "YRUHQSLDPXNGOKMIEBFZCWVJAT")
        XCTAssertEqual(rotor.turnoverNotches, [])
    }

    func test_ShouldCreateReflectorOfTypeC() {
        let rotor = dataLoader.loadReflectorOfType(.C)

        XCTAssertEqual(rotor.mapping, "FVPJIAOYEDRZXWGCTKUQSBNMHL")
        XCTAssertEqual(rotor.turnoverNotches, [])
    }

    func test_ShouldCreateReflectorOfTypeBThin() {
        let rotor = dataLoader.loadReflectorOfType(.ThinB)

        XCTAssertEqual(rotor.mapping, "ENKQAUYWJICOPBLMDXZVFTHRGS")
        XCTAssertEqual(rotor.turnoverNotches, [])
    }

    func test_ShouldCreateReflectorOfTypeCThin() {
        let rotor = dataLoader.loadReflectorOfType(.ThinC)

        XCTAssertEqual(rotor.mapping, "RDOBJNTKVEHMLFCWZAXGYIPSUQ")
        XCTAssertEqual(rotor.turnoverNotches, [])
    }
}
