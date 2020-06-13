//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import XCTest
@testable import SwiftDateTime


class DurationUpRoundingTests: DurationRoundingTester {

  func testRoundingToOneMillisecond() {
    check(numberOfTimes: 10000) {
      let a = randomDivisible()
      let b = a.rounded(upTo: 1.milliseconds)
      
      return check(
        condition: { a == b },
        errorMessage: "\(a) rounded up to 1 millisecond is \(b)."
      )
    }
  }
  
  func testRemainderOfRoundedValue() {
    check(numberOfTimes: 10000) {
      let a = randomDivisible()
      let divider = randomDivider()
      let b = a.rounded(upTo: divider)
      let remainder = b.positiveRemainder(divider: divider)
      
      return check(
        condition: { remainder == .zero },
        errorMessage:
          "\(a) rounded up to \(divider) = \(b), " +
          "but \(b) modulo \(divider) = \(remainder)"
      )
    }
  }
  
  func testAbsoluteDifference() {
    check(numberOfTimes: 10000) {
      let a = randomDivisible()
      let divider = randomDivider()
      
      let b = a.rounded(upTo: divider)
      
      return check(
        condition: { abs(a - b) < divider },
        errorMessage:
          "Too large difference between rounded and unrounded values: " +
          "\(a) rounded up to \(divider) = \(b)."
      )
    }
  }
  
  func testDirectionOfRounding() {
    check(numberOfTimes: 100_000) {
      let a = randomDivisible()
      let divider = randomDivider()
      let b = a.rounded(upTo: divider)
      
      return check(
        condition: { a <= b },
        errorMessage: "Invalid direction of rounding. \(a) rounded up to \(divider) is \(b)."
      )
    }
  }
  
  func testIdempotency() {
    check(numberOfTimes: 10000) {
      let a = randomDivisible()
      let divider = randomDivider()
      
      let b = a.rounded(upTo: divider)
      let c = b.rounded(upTo: divider)
      
      return check(
        condition: { c == b },
        errorMessage:
          "Idempotency violated: " +
          "\(a) rounded up to \(divider) = \(b), " +
          "but \(b) rounded up to \(divider) = \(c)"
      )
    }
  }
}
