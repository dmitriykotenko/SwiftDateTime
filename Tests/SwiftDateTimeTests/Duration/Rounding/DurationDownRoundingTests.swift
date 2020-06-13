//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import XCTest
@testable import SwiftDateTime


class DurationDownRoundingTests: DurationRoundingTester {

  func testRoundingToOneMillisecond() {
    check(numberOfTimes: 10000) {
      let a = randomDivisible()
      let b = a.rounded(downTo: 1.milliseconds)
      
      return check(
        condition: { a == b },
        errorMessage: "\(a) rounded down to 1 millisecond is \(b)."
      )
    }
  }
  
  func testRemainderOfRoundedValue() {
    check(numberOfTimes: 10000) {
      let a = randomDivisible()
      let divider = randomDivider()
      let b = a.rounded(downTo: divider)
      let remainder = b.positiveRemainder(divider: divider)
      
      return check(
        condition: { remainder == .zero },
        errorMessage:
        "\(a) rounded down to \(divider) = \(b), " +
        "but \(b) modulo \(divider) = \(remainder)"
      )
    }
  }
  
  func testAbsoluteDifference() {
    check(numberOfTimes: 10000) {
      let a = randomDivisible()
      let divider = randomDivider()
      
      let b = a.rounded(downTo: divider)
      
      return check(
        condition: { abs(a - b) < divider },
        errorMessage:
        "Too large difference between rounded and unrounded values: " +
        "\(a) rounded down to \(divider) = \(b)."
      )
    }
  }
  
  func testDirectionOfRounding() {
    check(numberOfTimes: 100_000) {
      let a = randomDivisible()
      let divider = randomDivider()
      let b = a.rounded(downTo: divider)
      
      return check(
        condition: { a >= b },
        errorMessage: "Invalid direction of rounding. \(a) rounded down to \(divider) is \(b)."
      )
    }
  }
  
  func testIdempotency() {
    check(numberOfTimes: 10000) {
      let a = randomDivisible()
      let divider = randomDivider()
      
      let b = a.rounded(downTo: divider)
      let c = b.rounded(downTo: divider)
      
      return check(
        condition: { c == b },
        errorMessage:
          "Idempotency violated: " +
          "\(a) rounded down to \(divider) = \(b), " +
          "but \(b) rounded down to \(divider) = \(c)"
      )
    }
  }
}
