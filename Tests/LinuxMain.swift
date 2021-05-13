import XCTest

import LiveTests

var tests = [XCTestCaseEntry]()
tests += LiveTests.allTests()
XCTMain(tests)
