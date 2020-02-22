//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import XCTest
@testable import SwiftDateTime


/// Tests for number of days between two dayMonthYears.
class DatesManipulatorDifferenceTests: XCTestCase, DateTimeGenerator {
  
  let manipulator = DatesManipulator()
  
  func testDaysBetweenReferenceDateAndReferenceDate() {
    check(
      firstDate: 1.january(2001),
      secondDate: 1.january(2001),
      expectedDifference: 0
    )
  }
  
  func testDaysBetweenSameDate() {
    for _ in 1...10000 {
      let dayMonthYear = randomDayMonthYear()
      
      check(
        firstDate: dayMonthYear,
        secondDate: dayMonthYear,
        expectedDifference: 0
      )
    }
  }
  
  func testAntisymmetry() {
    for _ in 1...10000 {
      let a = randomDayMonthYear()
      let b = randomDayMonthYear()
      
      let bMinusA = manipulator.days(from: a, to: b)
      let aMinusB = manipulator.days(from: b, to: a)
      
      if aMinusB != -bMinusA {
        XCTFail(
          "Antisymmetry violated: \(b) - \(a) = \(bMinusA), " +
          "but \(a) - \(b) = \(aMinusB)."
        )
        
        return
      }
    }
  }
  
  func testTransitivity() {
    for _ in 1...10000 {
      let a = randomDayMonthYear()
      let b = randomDayMonthYear()
      let c = randomDayMonthYear()
      
      let bMinusA = manipulator.days(from: a, to: b)
      let cMinusB = manipulator.days(from: b, to: c)
      let cMinusA = manipulator.days(from: a, to: c)
      
      if cMinusA != cMinusB + bMinusA {
        XCTFail(
          "Transitivity violated: \(c) - \(b) = \(cMinusB), " +
          "\(b) - \(a) = \(bMinusA), but " +
          "\(c) - \(a) = \(cMinusA)."
        )
        
        return
      }
    }
  }
  
  func testSameDayAndMonth() {
    for _ in 1...10000 {
      let a = randomDayMonthYear()
      
      if a.day == 29 && a.month == 2 { continue }
      
      let b = DayMonthYear(
        day: a.day,
        month: a.month,
        year: a.year + Int.random(in: -3...3)
      )
      
      let days = manipulator.days(from: a, to: b)
      
      switch days % 365 {
      case -1, 0, 1, 364: break
      default:
        XCTFail("Number of days between \(a) and \(b) is wrong. It is \(days)")
        return
      }
    }
  }

  func testJanuary1of5000minusDecember31of4999() {
    let december31 = 31.december(4999)
    let january1 = 1.january(5000)
    
    check(
      firstDate: december31,
      secondDate: january1,
      expectedDifference: 1
    )
  }
  
  func testJanuary1minusDecember31() {
    for _ in 1...10000 {
      let year = Int.random(in: -10000...10000)
      let december31 = 31.december(year)
      let january1 = 1.january(year + 1)
      
      check(
        firstDate: december31,
        secondDate: january1,
        expectedDifference: 1
      )
    }
  }
  
  func testWeeksConsistency() {
    for _ in 1...10000 {
      let a = randomDayMonthYear()
      let b = DayMonthYear(day: a.day, month: a.month, year: a.year + 2800)
      let actualDifference = manipulator.days(from: a, to: b)
      
      if actualDifference % 7 != 0 {
        XCTFail("Weeks consistency violated: \(b) - \(a) = \(actualDifference) != 0 (mod 7).")
        return
      }
    }
  }

  private func check(firstDate: DayMonthYear,
                     secondDate: DayMonthYear,
                     expectedDifference: Int) {
    XCTAssertEqual(
      manipulator.days(from: firstDate, to: secondDate),
      expectedDifference,
      "\(secondDate) minus \(firstDate) should be equal to \(expectedDifference) days."
    )
  }
}
