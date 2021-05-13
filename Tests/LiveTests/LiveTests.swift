import XCTest
@testable import Live

final class LiveTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Live().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
