import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
  [
    testCase(SwiftDateTimeTests.allTests),
  ]
}
#endif
