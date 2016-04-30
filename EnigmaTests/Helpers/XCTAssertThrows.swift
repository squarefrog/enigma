import XCTest

/*
 * The following assertion was created from a reply on the Apple developer
 * forums: https://forums.developer.apple.com/thread/5824
 */

extension XCTestCase {
    // swiftlint:disable line_length
    func XCTAssertThrowsSpecificError(kind: ErrorType, _ message: String = "", file: StaticString = #file, line: UInt = #line, _ block: () throws -> ()) {
        do {
            try block()
            let msg = (message == "") ? "Tested block did not throw expected \(kind) error." : message
            XCTFail(msg, file: file, line: line)
        } catch let error as NSError {
            let expected = kind as NSError
            if (error.domain != expected.domain) || (error.code != expected.code) {
                let msg = (message == "") ? "Tested block threw \(error), not expected \(kind) error." : message
                XCTFail(msg, file: file, line: line)
            }
        }
    }
}
