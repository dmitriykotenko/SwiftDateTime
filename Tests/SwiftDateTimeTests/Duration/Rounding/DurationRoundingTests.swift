//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import XCTest
@testable import SwiftDateTime


class DurationRoundingTests: DurationRoundingTester {

  func testRoundingToOneMillisecond() {
    check(numberOfTimes: 10000) {
      let a = randomDivisible()
      let b = a.rounded(to: 1.milliseconds)
      
      return check(
        condition: { a == b },
        errorMessage: "\(a) rounded to 1 millisecond is \(b)."
      )
    }
  }

  func testRemainderOfRoundedValue() {
    check(numberOfTimes: 10000) {
      let a = randomDivisible()
      let divider = randomDivider()
      let b = a.rounded(to: divider)
      let remainder = b.positiveRemainder(divider: divider)

      return check(
        condition: { remainder == .zero },
        errorMessage:
          "\(a) rounded to \(divider) = \(b), " +
          "but \(b) modulo \(divider) = \(remainder)"
      )
    }
  }

  func testAbsoluteDifference() {
    check(numberOfTimes: 10000) {
      let a = randomDivisible()
      let divider = randomDivider()
      
      let b = a.rounded(to: divider)

      return check(
        condition: { abs(a - b) * 2 < divider },
        errorMessage:
          "Too large difference between rounded and unrounded values: " +
          "\(a) rounded to \(divider) = \(b)."
      )
    }
  }

  func testDirectionOfRounding() {
    check(numberOfTimes: 100_000) {
      let a = randomDivisible()
      let divider = randomDivider()
      let remainder = a.positiveRemainder(divider: divider)
      let b = a.rounded(to: divider)
      
      return check(
        condition: { remainder * 2 < divider ? a >= b : a < b },
        errorMessage: "Invalid direction of rounding. \(a) rounded to \(divider) is \(b)."
      )
    }
  }

  func testIdempotency() {
    check(numberOfTimes: 10000) {
      let a = randomDivisible()
      let divider = randomDivider()

      let b = a.rounded(to: divider)
      let c = b.rounded(to: divider)
      
      return check(
        condition: { c == b },
        errorMessage:
          "Idempotency violated: " +
          "\(a) rounded to \(divider) = \(b), " +
          "but \(b) rounded to \(divider) = \(c)"
      )
    }
  }
  
  func testCoordination() {
    check(numberOfTimes: 10000) {
      let a = randomDivisible()
      let divider = randomDivider()
      let b = a.rounded(to: divider)
      let c = a.rounded(upTo: divider)
      let d = a.rounded(downTo: divider)
      
      return check(
        condition: { b == c || b == d },
        errorMessage:
          "\(a) rounded to \(divider) is \(b). " +
          "It is not equal neither \(c) (= \(a) rounded up to \(divider)) " +
          "not \(d) (= \(a) rounded down to \(divider))."
      )
    }
  }
}
