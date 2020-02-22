//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import XCTest
@testable import SwiftDateTime


/// Tests for .< and .<= methods of DayMonthYear struct.
class DayMonthYearComparisonTests: XCTestCase, DateTimeGenerator {
  
  func testEqualityToSelf() {
    for _ in 1..<10000 {
      let a = randomDayMonthYear()
      
      if a != a {
        XCTFail("\(a) is not equal to itself.")
      }
    }
  }
  
  func testThatLessAndEqualityDoNotOverlap() {
    for _ in 1..<10000 {
      let a = randomDayMonthYear()
      let b = randomDayMonthYear()
      
      XCTAssert(!(a == b) || !(a < b), "Contradiction: \(a) is equal and strictly less than \(b).")
    }
  }
  
  func testThatAllDayMonthYearsAreComparable() {
    for _ in 1..<10000 {
      let a = randomDayMonthYear()
      let b = randomDayMonthYear()
      
      XCTAssert(a == b || a < b || b < a, "Can not compare \(a) and \(b)")
    }
  }
  
  func testAntiSymmetry() {
    for _ in 1..<10000 {
      let a = randomDayMonthYear()
      let b = randomDayMonthYear()
      
      if a < b && b < a {
        XCTFail("Anti-symmetry violated: \(a) and \(b) are strictly less than each other.")
      }
    }
  }
  
  func testTransitivity() {
    for _ in 1..<10000 {
      let a = randomDayMonthYear()
      let b = randomDayMonthYear()
      let c = randomDayMonthYear()
      
      if a < b && b < c && !(a < c) {
        XCTFail("Transitivity violated: \(a) < \(b), \(b) < \(c), but \(a) is not less than \(c).")
      }
    }
  }
  
  func testDifferentObjectsEquality() {
    checkThat(
      DayMonthYear(day: 17, month: 1, year: 2020),
      isNotEqualTo: DayMonthYear(day: 17, month: 12, year: 2020)
    )
  }
  
  func testDifferentYears1() {
    checkThat(
      DayMonthYear(day: 30, month: 9, year: 2020),
      isLessThan: DayMonthYear(day: 1, month: 1, year: 2021)
    )
  }
  
  func testDifferentYears2() {
    checkThat(
      DayMonthYear(day: 10, month: 9, year: 2021),
      isGreaterThan: DayMonthYear(day: 1, month: 1, year: 2020)
    )
  }
  
  func testDifferentMonths1() {
    let day = 28
    let year = 2020
    
    checkThat(
      DayMonthYear(day: day, month: 1, year: year),
      isLessThan: DayMonthYear(day: day, month: 3, year: year)
    )
  }
  
  func testDifferentMonths2() {
    let day = 27
    let year = 2020
    
    checkThat(
      DayMonthYear(day: day, month: 7, year: year),
      isGreaterThan: DayMonthYear(day: day, month: 3, year: year)
    )
  }
  
  func testDifferentDaysAndMonths1() {
    let year = 2020
    
    checkThat(
      DayMonthYear(day: 2, month: 5, year: year),
      isGreaterThan: DayMonthYear(day: 26, month: 2, year: year)
    )
  }
  
  func testDifferentDays1() {
    let month = 3
    let year = 2020
    
    checkThat(
      DayMonthYear(day: 13, month: month, year: year),
      isLessThan: DayMonthYear(day: 21, month: month, year: year)
    )
  }
  
  func testDifferentDays2() {
    let month = 5
    let year = 2010
    
    checkThat(
      DayMonthYear(day: 11, month: month, year: year),
      isGreaterThan: DayMonthYear(day: 9, month: month, year: year)
    )
  }
}


extension DayMonthYearComparisonTests {
  
  func checkThat(_ left: DayMonthYear,
                 isEqualTo right: DayMonthYear,
                 errorMessage: String = "") {
    
    XCTAssertEqual(left, right, errorMessage)
  }
  
  func checkThat(_ left: DayMonthYear,
                 isNotEqualTo right: DayMonthYear,
                 errorMessage: String = "") {
    
    XCTAssertNotEqual(left, right, errorMessage)
  }
  
  func checkThat(_ left: DayMonthYear,
                 isLessThan right: DayMonthYear,
                 errorMessage: String = "") {
    
    XCTAssertLessThan(left, right, errorMessage)
  }
  
  func checkThat(_ left: DayMonthYear,
                 isGreaterThan right: DayMonthYear,
                 errorMessage: String = "") {
    
    XCTAssertGreaterThan(left, right, errorMessage)
  }
}
