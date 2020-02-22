//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import XCTest
@testable import SwiftDateTime


/// Tests for adding days to dayMonthYear and for subtracting days from dayMonthYear.
class DatesManipulatorTranslationTests: XCTestCase, DateTimeGenerator {
  
  let manipulator = DatesManipulator()
  
  func testThatResultIsAlwaysValidDate() {
    for _ in 1..<100000 {
      let a = randomDayMonthYear()
      let days = Int.random(in: -10000...10000)
      
      let b = manipulator.date(a, plusDays: days)
      
      if isInvalidDate(b) {
        XCTFail("Invalid date: \(b) = \(a) + \(days) days.")
        break
      }
    }
  }
  
  func testAdditionOfOneDay() {
    check(
      20.october(2018),
      plus: 1,
      equals: 21.october(2018)
    )
  }
  
  func testAdditionTo29february() {
    check(
      29.february(2016),
      plus: 1,
      equals: 1.march(2016)
    )
  }
  
  func testAdditionTo31december() {
    check(
      31.december(2016),
      plus: 11,
      equals:  11.january(2017)
    )
  }
  
  func testAdditionOfManyDays() {
    check(
      1.february(2016),
      plus: 1461,
      equals: 1.february(2020)
    )
  }
  
  func testAdditionToEndOfMonth() {
    check(
      25.june(2016),
      plus: 19,
      equals: 14.july(2016)
    )
  }
  
  func testAdditionOfFewMonths() {
    check(
      25.february(2017),
      plus: 120,
      equals: 25.june(2017)
    )
  }
  
  func testSubtractionOfOneDay() {
    check(
      20.october(2018),
      plus: -1,
      equals: 19.october(2018)
    )
  }
  
  func testSubtractionFrom1marchOfLeapYear() {
    check(
      1.march(2016),
      plus: -1,
      equals: 29.february(2016)
    )
  }
  
  func testSubtractionFrom1january() {
    check(
      1.january(2016),
      plus: -11,
      equals: 21.december(2015)
    )
  }
  
  func testSubtractionOfManyDays() {
    check(
      1.february(2016),
      plus: -1461,
      equals: 1.february(2012)
    )
  }
  
  func testSubtractionFromBeginningOfMonth() {
    check(
      4.june(2016),
      plus: -19,
      equals: 16.may(2016)
    )
  }
  
  func testSubtractionOfFewMonths() {
    check(
      25.february(2017),
      plus: -120,
      equals: 28.october(2016)
    )
  }

  @discardableResult
  private func check(_ date: DayMonthYear,
                     plus days: Int,
                     equals expectedResult: DayMonthYear) -> Bool {
    let actualResult = manipulator.date(date, plusDays: days)
    
    if actualResult != expectedResult {
      XCTFail("\(date) + \(days) days = \(actualResult), but it should be equal to \(expectedResult).")
      return false
    }
    
    return true
  }

  private func isInvalidDate(_ date: DayMonthYear) -> Bool {
    return date.month <= 0
      || date.month > 12
      || date.day <= 0
      || date.day > monthLength(date)
  }
  
  private func monthLength(_ date: DayMonthYear) -> Int {
    switch date.month {
    case 1, 3, 5, 7, 8, 10, 12: return 31
    case 4, 6, 9, 11: return 30
    default:
      return isLeapYear(date.year) ? 29 : 28
    }
  }
  
  func isLeapYear(_ year: Int) -> Bool {
    return
      (year % 400 == 0) ? true :
        (year % 100 == 0) ? false :
        (year % 4 == 0) ? true :
    false
  }
  
  func testTransitivity() {
    for _ in 1..<10000 {
      let a = randomDayMonthYear()
      let n = Int.random(in: -1000...1000)
      let m = Int.random(in: -1000...1000)
      
      let first = manipulator.date(manipulator.date(a, plusDays: n), plusDays: m)
      let second = manipulator.date(a, plusDays: n + m)
      
      if first != second {
        XCTFail(
          "Transitivity broken. (a + n) + m = \(first), a + (n + m) = \(second)." +
          "a = \(a), n = \(n), m = \(m)."
        )
        break
      }
    }
  }
  
  func testThatOrderingIsPreserved() {
    for _ in 1..<10000 {
      let a = randomDayMonthYear()
      let b = randomDayMonthYear()
      
      if a < b {
        let n = Int.random(in: -1000...1000)
        let first = manipulator.date(a, plusDays: n)
        let second = manipulator.date(b, plusDays: n)
        
        if !(first < second) {
          XCTFail("Ordering broken: \(a) < \(b), but \(a) + \(n) >= \(b) + \(n).")
          break
        }
      }
    }
  }
  
  func testSymmetry() {
    for _ in 1..<10000 {
      let a = randomDayMonthYear()
      let n = Int.random(in: -1000...1000)
      
      let first = manipulator.date(manipulator.date(a, plusDays: n), plusDays: -n)
      
      if first != a {
        XCTFail("Symmetry broken: \(a) + \(n) - \(n) != \(a).")
        break
      }
    }
  }
  
  func testYearOverflow() {
    for _ in 1..<10000 {
      let a = randomDayMonthYear()
      
      let sign = Bool.random() ? 1 : -1
      let module = Int.random(in: 366...1000)
      let n = sign * module
      
      let first = manipulator.date(a, plusDays: n)
      
      if first.year == a.year {
        XCTFail("\(a) + \(n) days has the same year as \(a).")
        break
      }
    }
  }

  func testPerformanceOfAddition() {
    self.measure {
      let a = randomDayMonthYear()
      let n = Int.random(in: -1000...1000)
      let _ = manipulator.date(a, minusDays: n)
    }
  }
}
