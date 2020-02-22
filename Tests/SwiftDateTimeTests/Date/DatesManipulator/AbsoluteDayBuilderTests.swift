//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import XCTest
@testable import SwiftDateTime


class AbsoluteDayBuilderTests: XCTestCase, DateTimeGenerator {
  
  let builder = AbsoluteDayBuilder()

  func test7september1812() {
    check(
      date: 7.september(1812),
      expectedAbsoluteDay: 365 * (-189) - (49 - 2) + (31 + 29 + 31 + 30 + 31 + 30 + 31 + 31) + 7
    )
  }

  func test7september2212() {
    check(
      date: 7.september(2212),
      expectedAbsoluteDay: 365 * 211 + (48 + 2) + (31 + 29 + 31 + 30 + 31 + 30 + 31 + 31) + 7
    )
  }

  func test5april1990() {
    check(
      date: 5.april(1990),
      expectedAbsoluteDay: 365 * (-11) - 3 + 31 + 28 + 31 + 5
    )
  }

  func test1january2000() {
    check(
      date: 1.january(2000),
      expectedAbsoluteDay: 1 - 366
    )
  }

  func test1january2001() {
    check(
      date: 1.january(2001),
      expectedAbsoluteDay: 1
    )
  }
  
  func test1january2002() {
    check(
      date: 1.january(2002),
      expectedAbsoluteDay: 366
    )
  }
  
  func test1january2004() {
    check(
      date: 1.january(2004),
      expectedAbsoluteDay: 365 * 3 + 1
    )
  }

  func test28february2004() {
    check(
      date: 28.february(2004),
      expectedAbsoluteDay: 365 * 3 + 31 + 28
    )
  }

  func test29february2004() {
    check(
      date: 29.february(2004),
      expectedAbsoluteDay: 365 * 3 + 31 + 29
    )
  }

  func test1march2004() {
    check(
      date: 1.march(2004),
      expectedAbsoluteDay: 365 * 3 + 31 + 29 + 1
    )
  }
  
  func test31december2004() {
    check(
      date: 31.december(2004),
      expectedAbsoluteDay: 365 * 3 + 366
    )
  }

  func test1january2005() {
    check(
      date: 1.january(2005),
      expectedAbsoluteDay: 365 * 3 + 366 + 1
    )
  }

  func test28february2005() {
    check(
      date: 28.february(2005),
      expectedAbsoluteDay: 365 * 3 + 366 + 31 + 28
    )
  }

  func test1march2005() {
    check(
      date: 1.march(2005),
      expectedAbsoluteDay: 365 * 3 + 366 + 31 + 28 + 1
    )
  }

  func test31december2000() {
    check(
      date: 31.december(2000),
      expectedAbsoluteDay: 0
    )
  }

  func test1march2100() {
    check(
      date: 1.march(2100),
      expectedAbsoluteDay: 99 * 365 + 24 + 31 + 28 + 1
    )
  }

  func test31december2100() {
    check(
      date: 31.december(2100),
      expectedAbsoluteDay: 100 * 365 + 24
    )
  }

  func test31december2200() {
    check(
      date: 31.december(2200),
      expectedAbsoluteDay: (100 * 365 + 24) * 2
    )
  }

  private func check(date: DayMonthYear,
                     expectedAbsoluteDay: Int) {
    let actualAbsoluteDay = builder.absoluteDay(date)
    XCTAssertEqual(
      actualAbsoluteDay,
      expectedAbsoluteDay,
      "Wrong absolute day for \(date). Expected: \(expectedAbsoluteDay), actual: \(actualAbsoluteDay)."
    )
  }
}
