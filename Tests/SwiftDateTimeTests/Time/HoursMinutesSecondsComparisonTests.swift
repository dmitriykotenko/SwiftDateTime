//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import XCTest
@testable import SwiftDateTime


/// Tests for .< and .<= methods of HoursMinutesSeconds struct.
class HoursMinutesSecondsComparisonTests: XCTestCase, DateTimeGenerator {
  
  func testEqualityToSelf() {
    for _ in 1..<10000 {
      let a = randomHoursMinutesSeconds()
      
      if a != a {
        XCTFail("\(a) is not equal to itself.")
      }
    }
  }
  
  func testThatLessAndEqualityDoNotOverlap() {
    for _ in 1..<10000 {
      let a = randomHoursMinutesSeconds()
      let b = randomHoursMinutesSeconds()
      
      XCTAssert(!(a == b) || !(a < b), "Contradiction: \(a) is equal and strictly less than \(b).")
    }
  }
  
  func testThatAllHoursMinutesSecondsAreComparable() {
    for _ in 1..<10000 {
      let a = randomHoursMinutesSeconds()
      let b = randomHoursMinutesSeconds()
      
      XCTAssert(a == b || a < b || b < a, "Can not compare \(a) and \(b)")
    }
  }
  
  func testThatValuesWithDifferentMillisecondsAreComparable() {
    let a = HoursMinutesSeconds(hours: 5, minutes: 9, seconds: 24, milliseconds: 383)
    let b = HoursMinutesSeconds(hours: 5, minutes: 9, seconds: 24, milliseconds: 245)
    
    XCTAssert(a == b || a < b || b < a, "Can not compare \(a) and \(b)")
  }

  func testAntiSymmetry() {
    for _ in 1..<10000 {
      let a = randomHoursMinutesSeconds()
      let b = randomHoursMinutesSeconds()
      
      if a < b && b < a {
        XCTFail("Anti-symmetry violated: \(a) and \(b) are strictly less than each other.")
      }
    }
  }
  
  func testTransitivity() {
    for _ in 1..<10000 {
      let a = randomHoursMinutesSeconds()
      let b = randomHoursMinutesSeconds()
      let c = randomHoursMinutesSeconds()
      
      if a < b && b < c && !(a < c) {
        XCTFail("Transitivity violated: \(a) < \(b), \(b) < \(c), but \(a) is not less than \(c).")
      }
    }
  }
  
  func testDifferentObjectsEquality() {
    checkThat(
      HoursMinutesSeconds(hours: 17, minutes: 1, seconds: 50, milliseconds: 11),
      isNotEqualTo: HoursMinutesSeconds(hours: 3, minutes: 21, seconds: 0, milliseconds: 865)
    )
  }

  func testDifferentHours1() {
    for _ in 1..<10000 {
      checkThat(
        randomHoursMinutesSeconds(hours: 7),
        isLessThan: randomHoursMinutesSeconds(hours: 11)
      )
    }
  }

  func testDifferentHours2() {
    for _ in 1..<10000 {
      checkThat(
        randomHoursMinutesSeconds(hours: 2),
        isLessThan: randomHoursMinutesSeconds(hours: 21)
      )
    }
  }

  func testDifferentMinutes() {
    for _ in 1..<10000 {
      let a = randomHoursMinutesSeconds(minutes: 7)
      let b = HoursMinutesSeconds(
        hours: a.hours,
        minutes: 28,
        seconds: a.seconds,
        milliseconds: a.milliseconds
      )
      
      checkThat(a, isLessThan: b)
    }
  }

  func testDifferentSeconds() {
    for _ in 1..<10000 {
      let a = randomHoursMinutesSeconds(seconds: 4)
      let b = HoursMinutesSeconds(
        hours: a.hours,
        minutes: a.minutes,
        seconds: 13,
        milliseconds: a.milliseconds
      )
      
      checkThat(a, isLessThan: b)
    }
  }
  
  func testDifferentMilliseconds1() {
    checkThat(
      HoursMinutesSeconds(
        hours: 18,
        minutes: 57,
        seconds: 44,
        milliseconds: 11
      ),
      isNotEqualTo: HoursMinutesSeconds(
        hours: 18,
        minutes: 57,
        seconds: 44,
        milliseconds: 900
    ))
  }
  
  func testDifferentMilliseconds2() {
    for _ in 1..<10000 {
      let a = randomHoursMinutesSeconds()
      let b = randomHoursMinutesSeconds(
        hours: a.hours,
        minutes: a.minutes,
        seconds: a.seconds
      )
      
      if a.milliseconds != b.milliseconds && a == b {
        XCTFail("Dates with different milliseconds are considered equal: a = \(a), b = \(b).")
        break
      }
    }
  }
}


extension HoursMinutesSecondsComparisonTests {
  
  func checkThat(_ left: HoursMinutesSeconds,
                 isEqualTo right: HoursMinutesSeconds,
                 errorMessage: String = "") {
    
    XCTAssertEqual(left, right, errorMessage)
  }
  
  func checkThat(_ left: HoursMinutesSeconds,
                 isNotEqualTo right: HoursMinutesSeconds,
                 errorMessage: String = "") {
    
    XCTAssertNotEqual(left, right, errorMessage)
  }
  
  func checkThat(_ left: HoursMinutesSeconds,
                 isLessThan right: HoursMinutesSeconds,
                 errorMessage: String = "") {
    
    XCTAssertLessThan(left, right, errorMessage)
  }
  
  func checkThat(_ left: HoursMinutesSeconds,
                 isGreaterThan right: HoursMinutesSeconds,
                 errorMessage: String = "") {
    
    XCTAssertGreaterThan(left, right, errorMessage)
  }
}
