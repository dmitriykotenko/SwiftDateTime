//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import XCTest
@testable import SwiftDateTime


class DurationRoundingTester: XCTestCase, DurationGenerator {
  
  func check(numberOfTimes: Int,
             test: () -> Bool) {
    _ = (1...numberOfTimes).drop { _ in test() }
  }
  
  func check(condition: () -> Bool,
             errorMessage: String) -> Bool {
    if condition() {
      return true
    } else {
      XCTFail(errorMessage)
      return false
    }
  }
  
  func randomDivisible() -> Duration {
    .random(in: (-Duration.approximatelyFiveYears)...Duration.approximatelyFiveYears)
  }
  
  func randomDivider() -> Duration {
    .random(in: 1.milliseconds...10.hours)
  }
}


private extension Duration {
  
  static var approximatelyFiveYears = Duration(seconds: 3600 * 24 * 365 * 5)
}
