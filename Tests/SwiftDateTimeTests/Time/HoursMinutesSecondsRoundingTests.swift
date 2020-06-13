//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import XCTest
@testable import SwiftDateTime


class HoursMinutesSecondsRoundingTests: XCTestCase, DateTimeGenerator {
  
  func testThatRoundedValueIsValid() {
    check(numberOfTimes: 10000) {
      let a = randomHoursMinutesSeconds()
      let divider = randomDivider()
      let b = a.rounded(to: divider)
      
      return check(
        condition: {  b <= .lastMillisecondOfDay },
        errorMessage: "Wrong rounding: \(a) rounded to \(divider) is \(b)."
      )
    }
  }
  
  func testThatUpRoundedValueIsValid() {
    check(numberOfTimes: 10000) {
      let a = randomHoursMinutesSeconds()
      let divider = randomDivider()
      let b = a.rounded(upTo: divider)
      
      return check(
        condition: {  b <= .lastMillisecondOfDay },
        errorMessage: "Wrong rounding: \(a) rounded to \(divider) is \(b)."
      )
    }
  }
  
  func testThatDownRoundedValueIsValid() {
    check(numberOfTimes: 10000) {
      let a = randomHoursMinutesSeconds()
      let divider = randomDivider()
      let b = a.rounded(downTo: divider)
      
      return check(
        condition: {  b <= .lastMillisecondOfDay },
        errorMessage: "Wrong rounding: \(a) rounded to \(divider) is \(b)."
      )
    }
  }

  func testUnsafeRounding() {
    check(numberOfTimes: 10000) {
      let a = randomHoursMinutesSeconds()
      let divider = randomDivider()
      let b = a.unsafelyRounded(to: divider)
      let c = a.durationFromMidnight.rounded(to: divider)
      
      return check(
        condition: { b.durationFromMidnight == c },
        errorMessage: "Wrong rounding: \(a) unsafely rounded to \(divider) is \(b)."
      )
    }
  }
  
  func testUnsafeUpRounding() {
    check(numberOfTimes: 10000) {
      let a = randomHoursMinutesSeconds()
      let divider = randomDivider()
      let b = a.unsafelyRounded(upTo: divider)
      let c = a.durationFromMidnight.rounded(upTo: divider)
      
      return check(
        condition: { b.durationFromMidnight == c },
        errorMessage: "Wrong up rounding: \(a) unsafely rounded up to \(divider) is \(b)."
      )
    }
  }
  
  func testUnsafeDownRounding() {
    check(numberOfTimes: 10000) {
      let a = randomHoursMinutesSeconds()
      let divider = randomDivider()
      let b = a.unsafelyRounded(downTo: divider)
      let c = a.durationFromMidnight.rounded(downTo: divider)
      
      return check(
        condition: { b.durationFromMidnight == c },
        errorMessage: "Wrong down rounding: \(a) unsafely rounded down to \(divider) is \(b)."
      )
    }
  }

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
  
  func randomDivider() -> Duration {
    return .random(in: 1.milliseconds...1000.hours)
  }
}


private extension HoursMinutesSeconds {
  
  static let lastMillisecondOfDay = HoursMinutesSeconds(
    hours: 23,
    minutes: 59,
    seconds: 59,
    milliseconds: 999
  )
}
