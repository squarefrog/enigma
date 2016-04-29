import XCTest
@testable import Enigma

class RotorDataLoaderTests: XCTestCase {

    var dataLoader: RotorDataLoader!

    override func setUp() {
        super.setUp()
        dataLoader = RotorDataLoader()
    }

    override func tearDown() {
        dataLoader = nil
        super.tearDown()
    }

    func test_ShouldInitialiseWithJSONData() {
        XCTAssertNotNil(dataLoader.rotorDataSource)
    }

    func test_ShouldCreateRotorOfTypeI() {
        let rotor = dataLoader.loadRotorOfType(.I)

        let expectedMapping = "EKMFLGDQVZNTOWYHXUSPAIBRCJ"
        let actualMapping = createAlphaFromMapping(rotor!.mapping)
        XCTAssertEqual(actualMapping, expectedMapping)

        XCTAssertEqual(rotor!.turnoverNotches, [16])
    }

    func test_ShouldCreateRotorOfTypeII() {
        let rotor = dataLoader.loadRotorOfType(.II)

        let expectedMapping = "AJDKSIRUXBLHWTMCQGZNPYFVOE"
        let actualMapping = createAlphaFromMapping(rotor!.mapping)
        XCTAssertEqual(actualMapping, expectedMapping)

        XCTAssertEqual(rotor!.turnoverNotches, [4])
    }

    func test_ShouldCreateRotorOfTypeIII() {
        let rotor = dataLoader.loadRotorOfType(.III)

        let expectedMapping = "BDFHJLCPRTXVZNYEIWGAKMUSQO"
        let actualMapping = createAlphaFromMapping(rotor!.mapping)
        XCTAssertEqual(actualMapping, expectedMapping)

        XCTAssertEqual(rotor!.turnoverNotches, [21])
    }

    func test_ShouldCreateRotorOfTypeIV() {
        let rotor = dataLoader.loadRotorOfType(.IV)

        let expectedMapping = "ESOVPZJAYQUIRHXLNFTGKDCMWB"
        let actualMapping = createAlphaFromMapping(rotor!.mapping)
        XCTAssertEqual(actualMapping, expectedMapping)

        XCTAssertEqual(rotor!.turnoverNotches, [9])
    }

    func test_ShouldCreateRotorOfTypeV() {
        let rotor = dataLoader.loadRotorOfType(.V)

        let expectedMapping = "VZBRGITYUPSDNHLXAWMJQOFECK"
        let actualMapping = createAlphaFromMapping(rotor!.mapping)
        XCTAssertEqual(actualMapping, expectedMapping)

        XCTAssertEqual(rotor!.turnoverNotches, [25])
    }

    func test_ShouldCreateRotorOfTypeVI() {
        let rotor = dataLoader.loadRotorOfType(.VI)

        let expectedMapping = "JPGVOUMFYQBENHZRDKASXLICTW"
        let actualMapping = createAlphaFromMapping(rotor!.mapping)
        XCTAssertEqual(actualMapping, expectedMapping)

        XCTAssertEqual(rotor!.turnoverNotches, [12, 25])
    }

    func test_ShouldCreateRotorOfTypeVII() {
        let rotor = dataLoader.loadRotorOfType(.VII)

        let expectedMapping = "NZJHGRCXMYSWBOUFAIVLPEKQDT"
        let actualMapping = createAlphaFromMapping(rotor!.mapping)
        XCTAssertEqual(actualMapping, expectedMapping)

        XCTAssertEqual(rotor!.turnoverNotches, [12, 25])
    }

    func test_ShouldCreateRotorOfTypeVIII() {
        let rotor = dataLoader.loadRotorOfType(.VIII)

        let expectedMapping = "FKQHTLXOCBJSPDZRAMEWNIUYGV"
        let actualMapping = createAlphaFromMapping(rotor!.mapping)
        XCTAssertEqual(actualMapping, expectedMapping)

        XCTAssertEqual(rotor!.turnoverNotches, [12, 25])
    }

    func test_ShouldCreateRotorOfTypeBeta() {
        let rotor = dataLoader.loadRotorOfType(.Beta)

        let expectedMapping = "LEYJVCNIXWPBQMDRTAKZGFUHOS"
        let actualMapping = createAlphaFromMapping(rotor!.mapping)
        XCTAssertEqual(actualMapping, expectedMapping)

        XCTAssertEqual(rotor!.turnoverNotches, [])
    }

    func test_ShouldCreateRotorOfTypeGamma() {
        let rotor = dataLoader.loadRotorOfType(.Gamma)

        let expectedMapping = "FSOKANUERHMBTIYCWLQPZXVGJD"
        let actualMapping = createAlphaFromMapping(rotor!.mapping)
        XCTAssertEqual(actualMapping, expectedMapping)

        XCTAssertEqual(rotor!.turnoverNotches, [])
    }

    func test_ShouldCreateReflectorOfTypeB() {
        let rotor = dataLoader.loadReflectorOfType(.B)

        let expectedMapping = "YRUHQSLDPXNGOKMIEBFZCWVJAT"
        let actualMapping = createAlphaFromMapping(rotor!.mapping)
        XCTAssertEqual(actualMapping, expectedMapping)

        XCTAssertEqual(rotor!.turnoverNotches, [])
    }

    func test_ShouldCreateReflectorOfTypeC() {
        let rotor = dataLoader.loadReflectorOfType(.C)

        let expectedMapping = "FVPJIAOYEDRZXWGCTKUQSBNMHL"
        let actualMapping = createAlphaFromMapping(rotor!.mapping)
        XCTAssertEqual(actualMapping, expectedMapping)

        XCTAssertEqual(rotor!.turnoverNotches, [])
    }

    func test_ShouldCreateReflectorOfTypeBThin() {
        let rotor = dataLoader.loadReflectorOfType(.ThinB)

        let expectedMapping = "ENKQAUYWJICOPBLMDXZVFTHRGS"
        let actualMapping = createAlphaFromMapping(rotor!.mapping)
        XCTAssertEqual(actualMapping, expectedMapping)

        XCTAssertEqual(rotor!.turnoverNotches, [])
    }

    func test_ShouldCreateReflectorOfTypeCThin() {
        let rotor = dataLoader.loadReflectorOfType(.ThinC)

        let expectedMapping = "RDOBJNTKVEHMLFCWZAXGYIPSUQ"
        let actualMapping = createAlphaFromMapping(rotor!.mapping)
        XCTAssertEqual(actualMapping, expectedMapping)

        XCTAssertEqual(rotor!.turnoverNotches, [])
    }

    // MARK: - Test Helpers

    private func createAlphaFromMapping(mapping: [Int]) -> String {
        var mappingString = ""
        let offset = Character("A").unicodeScalarValue()
        for code in mapping {
            let letter = String(format: "%c", code + offset)
            mappingString = mappingString + letter
        }

        return mappingString
    }
}
