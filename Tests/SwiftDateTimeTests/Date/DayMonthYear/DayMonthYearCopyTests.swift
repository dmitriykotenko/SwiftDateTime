//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import XCTest
@testable import SwiftDateTime


/// Tests for copying of DayMonthYear structs.
class DayMonthYearCopyTests: XCTestCase, DateTimeGenerator {
  
  func testThatCopiedSelfEqualsSelf() {
    let _ = (1..<10000)
      .map { _ in randomDayMonthYear() }
      .drop { areSame($0.copy(), $0) }
  }

  func testThatYearIsProperlyCopied() {
    let a = randomDayMonthYear()
    let b = a.copy(year: 1111)
    
    XCTAssertEqual(b.day, a.day)
    XCTAssertEqual(b.month, a.month)
    XCTAssertEqual(b.year, 1111)
  }
  
  func testThatMonthIsProperlyCopied() {
    let a = randomDayMonthYear()
    let month = a.month == 11 ? 9 : 11
    let b = a.copy(month: month)
    
    XCTAssertEqual(b.day, a.day)
    XCTAssertEqual(b.month, month)
    XCTAssertEqual(b.year, a.year)
  }
  
  func testThatDayIsProperlyCopied() {
    let a = randomDayMonthYear()
    let day = a.day == 2 ? 5 : 2
    let b = a.copy(day: day)
    
    XCTAssertEqual(b.day, day)
    XCTAssertEqual(b.month, a.month)
    XCTAssertEqual(b.year, a.year)
  }
  
  func testThatNilParametersAreCopiedProperly() {
    let _ = (1..<10000)
      .map { _ in randomDayMonthYear() }
      .drop { areSame($0.copy(day: nil, month: nil, year: nil), $0) }
  }
  
  func testThatCopyingWithAllParametersWorksProperly() {
    let _ = (1..<10000)
      .map { _ in (randomDayMonthYear(), randomDayMonthYear()) }
      .drop {
        areSame($0.copy(day: $1.day, month: $1.month, year: $1.year), $1)
      }
  }

  private func areSame(_ actual: DayMonthYear, _ expected: DayMonthYear) -> Bool {
    if expected == actual {
      return true
    } else {
      XCTFail("\(actual) is not equal to \(expected).")
      return false
    }
  }
  
  private func areDifferent(_ expected: DayMonthYear, actual: DayMonthYear) -> Bool {
    if expected != actual {
      return true
    } else {
      XCTFail("\(actual) is equal to \(expected).")
      return false
    }
  }
}
