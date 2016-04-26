import XCTest

extension XCTestCase {
    func XCTAssertThrows<T: ErrorType where T: Equatable>(error: T, block: () throws -> ()) {
        do {
            try block()
        }
        catch let e as T {
            XCTAssertEqual(e, error)
        }
        catch {
            XCTFail("Incorrect error thrown")
        }
    }
}
