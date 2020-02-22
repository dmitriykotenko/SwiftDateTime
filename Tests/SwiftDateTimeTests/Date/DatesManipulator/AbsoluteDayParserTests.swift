//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import XCTest
@testable import SwiftDateTime


class AbsoluteDayParserTests: XCTestCase, DateTimeGenerator {
  
  let parser = AbsoluteDayParser()
  let builder = AbsoluteDayBuilder()
  
  func test1january2000() {
    check(absoluteDay: -366 + 1, expectedDate: 1.january(2000))
  }

  func test28february2000() {
    check(absoluteDay: -366 + 31 + 28, expectedDate: 28.february(2000))
  }

  func test31december2000() {
    check(absoluteDay: 0, expectedDate: 31.december(2000))
  }

  func test1january2001() {
    check(absoluteDay: 1, expectedDate: 1.january(2001))
  }

  func test31december20012() {
    check(absoluteDay: 12 * 365 + 3, expectedDate: 31.december(2012))
  }

  func test1january20013() {
    check(absoluteDay: 12 * 365 + 3 + 1, expectedDate: 1.january(2013))
  }

  func test17december2009() {
    check(absoluteDay: 9 * 365 + 2 - 14, expectedDate: 17.december(2009))
  }

  func testSymmetry1() {
    for _ in 1...10000 {
      let date = randomDayMonthYear()
      
      let sameDate = parser.dayMonthYear(absoluteDay: builder.absoluteDay(date))
      
      if sameDate != date {
        XCTFail("Symmetry violated when converting date to absolute day and back again. Date \(date) became \(sameDate).")
        return
      }
    }
  }
  
  func testSymmetry2() {
    for _ in 1...10000 {
      let absoluteDay = Int.random(in: -10000000...10000000)
      
      let sameAbsoluteDay = builder.absoluteDay(parser.dayMonthYear(absoluteDay: absoluteDay))
      
      if sameAbsoluteDay != absoluteDay {
        XCTFail("Symmetry violated when converting absolute day to date and back again. Day \(absoluteDay) became \(sameAbsoluteDay).")
        return
      }
    }
  }

  func testOrdering() {
    for _ in 1...10000 {
      let a = Int.random(in: -10000000...9999999)
      let b = Int.random(in: (a + 1)...10000000)

      let aDate = parser.dayMonthYear(absoluteDay: a)
      let bDate = parser.dayMonthYear(absoluteDay: b)
      
      guard aDate < bDate else {
        XCTFail(
          "Ordering violated when converting absolute day to date. " +
          "Day \(a) < day \(b), but date(a) = \(aDate) >= \(bDate) = date(b)."
        )
        
        return
      }
    }
  }

  private func check(absoluteDay: Int,
                     expectedDate: DayMonthYear) {
    let actualDate = parser.dayMonthYear(absoluteDay: absoluteDay)
    
    XCTAssertEqual(
      actualDate,
      expectedDate,
      "Wrong date for absolute day \(absoluteDay). Expected: \(expectedDate), actual: \(actualDate)."
    )
  }
}
