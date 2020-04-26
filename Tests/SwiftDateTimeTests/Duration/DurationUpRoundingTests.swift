//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import XCTest
@testable import SwiftDateTime


class DurationUpRoundingTests: XCTestCase, DurationGenerator {

  func testThatThousandthsAreZero() {
    for _ in 1..<10000 {
      let a = randomDuration()
      let b = a.roundedUpToSeconds
      
      if b.thousandths != 0 {
        XCTFail("Invalid rounding: \(a).roundedUpToSeconds = \(b).")
        break
      }
    }
  }
  
  func testThatRoundedValueIsGreaterThanOriginal() {
    for _ in 1..<10000 {
      let a = randomDuration()
      let b = a.roundedUpToSeconds
      
      if b < a {
        XCTFail("Invalid rounding: \(a).roundedUpToSeconds = \(b).")
        break
      }
    }
  }

  func testThatCorrectionIsLessThanSecond() {
    for _ in 1..<10000 {
      let a = randomDuration()
      let b = a.roundedUpToSeconds
      
      if abs(a.milliseconds - b.milliseconds) >= 1000 {
        XCTFail("Invalid rounding: \(a).roundedUpToSeconds = \(b).")
        break
      }
    }
  }

  func testIdempotency() {
    for _ in 1..<10000 {
      let a = randomDuration()
      let b = a.roundedUpToSeconds
      let c = b.roundedUpToSeconds
      
      if c != b {
        XCTFail(
          "Idempotency violated: " +
          "\(a).roundedUpToSeconds = \(b), " +
          "but \(b).roundedUpToSeconds = \(c)"
        )
        break
      }
    }
  }
}
