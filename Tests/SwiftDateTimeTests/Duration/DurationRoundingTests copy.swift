//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import XCTest
@testable import SwiftDateTime


class DurationRoundingTests: XCTestCase, DurationGenerator {

  func testThatThousandthsAreZero() {
    for _ in 1..<10000 {
      let a = randomDuration()
      let b = a.roundedToSeconds
      
      if b.thousandths != 0 {
        XCTFail("Invalid rounding: \(a).roundedToSeconds = \(b).")
        break
      }
    }
  }
  
  func testSmallThousandths() {
    for _ in 1..<10000 {
      let a = randomDuration(thousandths: .random(in: 0...499))
      let b = a.roundedToSeconds
      
      if a < b {
        XCTFail("Invalid rounding: \(a).roundedToSeconds = \(b).")
        break
      }
    }
  }
  
  func testLargeThousandths() {
    for _ in 1..<10000 {
      let a = randomDuration(thousandths: .random(in: 500...999))
      let b = a.roundedToSeconds
      
      if a >= b {
        XCTFail("Invalid rounding: \(a).roundedToSeconds = \(b).")
        break
      }
    }
  }

  func testThatCorrectionIsLessThanHalfSecond() {
    for _ in 1..<10000 {
      let a = randomDuration()
      let b = a.roundedToSeconds
      
      if abs(a.milliseconds - b.milliseconds) > 500 {
        XCTFail("Invalid rounding: \(a).roundedToSeconds = \(b).")
        break
      }
    }
  }

  func testIdempotency() {
    for _ in 1..<10000 {
      let a = randomDuration()
      let b = a.roundedToSeconds
      let c = b.roundedToSeconds
      
      if c != b {
        XCTFail(
          "Idempotency violated: " +
          "\(a).roundedToSeconds = \(b), " +
          "but \(b).roundedToSeconds = \(c)"
        )
        break
      }
    }
  }
}
