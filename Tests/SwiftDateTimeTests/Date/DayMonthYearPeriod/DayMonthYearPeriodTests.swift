//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import XCTest
@testable import SwiftDateTime


class DayMonthYearPeriodTests: XCTestCase, DateTimeGenerator {
  
  func testThatPeriodWithSameStartAndEndDoesNotContainItsStart() {
    for _ in 1..<10000 {
      let a = randomDayMonthYear()
      
      if doesContain(DayMonthYearPeriod(start: a, end: a), date: a) {
        break
      }
    }
  }
  
  func testThatPeriodWithSameStartAndEndContainsNothing() {
    for _ in 1..<10000 {
      let a = randomDayMonthYear()
      
      if doesContain(DayMonthYearPeriod(start: a, end: a), date: randomDayMonthYear()) {
        break
      }
    }
  }
  
  func testThatPeriodWithStartGreaterThanEndContainsNothing() {
    for _ in 1..<10000 {
      let a = randomDayMonthYear()
      let b = randomDayMonthYear()
      guard a > b else { continue }

      if doesContain(DayMonthYearPeriod(start: a, end: b), date: randomDayMonthYear()) {
        break
      }
    }
  }
  
  
  func testThatNonEmptyPeriodAlwaysContainsItsStart() {
    for _ in 1..<10000 {
      let a = randomDayMonthYear()
      let b = randomDayMonthYear()
      guard a < b else { continue }

      if notContain(DayMonthYearPeriod(start: a, end: b), date: a) {
        break
      }
    }
  }
  
  func testThatPeriodNeverContainsItsEnd() {
    for _ in 1..<10000 {
      let a = randomDayMonthYear()
      let b = randomDayMonthYear()
      guard a < b else { continue }

      if doesContain(DayMonthYearPeriod(start: a, end: b), date: b) {
        break
      }
    }
  }
  
  func testThatPeriodNeverContainsDatesLessThanStart() {
    for _ in 1..<10000 {
      let dates: Set = [randomDayMonthYear(), randomDayMonthYear(), randomDayMonthYear()]
      guard dates.count == 3 else { continue }
      
      let sortedDates = dates.sorted()
      
      if doesContain(DayMonthYearPeriod(start: sortedDates[1], end: sortedDates[2]), date: sortedDates[0]) {
        break
      }
    }
  }
  
  func testThatPeriodNeverContainsDatesGreaterThanEnd() {
    for _ in 1..<10000 {
      let dates: Set = [randomDayMonthYear(), randomDayMonthYear(), randomDayMonthYear()]
      guard dates.count == 3 else { continue }
      
      let sortedDates = dates.sorted()
      
      if doesContain(DayMonthYearPeriod(start: sortedDates[0], end: sortedDates[1]), date: sortedDates[2]) {
        break
      }
    }
  }
  
  func testThatPeriodAlwaysContainsDatesBetweenStartAndEnd() {
    for _ in 1..<10000 {
      let dates: Set = [randomDayMonthYear(), randomDayMonthYear(), randomDayMonthYear()]
      guard dates.count == 3 else { continue }
      
      let sortedDates = dates.sorted()
      
      if notContain(DayMonthYearPeriod(start: sortedDates[0], end: sortedDates[2]), date: sortedDates[1]) {
        break
      }
    }
  }

  func testThatParticularPeriodContainsProperValues() {
    let period = DayMonthYearPeriod(
      start: 18.march(2010),
      end: 17.december(2020)
    )
    
    let _ = notContain(period, date: 1.april(2010))
    let _ = notContain(period, date: 1.january(2016))
    let _ = notContain(period, date: 16.december(2020))
  }
  
  func testThatContainsCorrectlyWorksForDateTimes() {
    for _ in 1..<10000 {
      let period = DayMonthYearPeriod(
        start: randomDayMonthYear(),
        end: randomDayMonthYear()
      )
      
      let c = randomDayMonthYear()
      let cWithTime = DateTime(
        date: c,
        time: randomHoursMinutesSeconds(),
        timeZoneOffset: randomTimeZoneOffset()
      )
      
      if period.contains(c) != period.contains(cWithTime) {
        XCTFail("Method period.contains() should not depend on time and time zone offset")
        break
      }
    }
  }
  
  func testThatContainsCorrectlyWorksForLocalDateTimes() {
    for _ in 1..<10000 {
      let period = DayMonthYearPeriod(
        start: randomDayMonthYear(),
        end: randomDayMonthYear()
      )
      
      let c = randomDayMonthYear()
      let cWithTime = LocalDateTime(
        date: c,
        time: randomHoursMinutesSeconds()
      )
      
      if period.contains(c) != period.contains(cWithTime) {
        XCTFail("Method period.contains() should not depend on time.")
        break
      }
    }
  }

  private func doesContain(_ period: DayMonthYearPeriod, date: DayMonthYear) -> Bool {
    if !period.contains(date) {
      return false
    } else {
      let periodString = period.start >= period.end ? "Empty period \(period)" : "Period \(period)"
      XCTFail("\(periodString) contains date \(date).")
      return true
    }
  }
  
  private func notContain(_ period: DayMonthYearPeriod, date: DayMonthYear) -> Bool {
    if period.contains(date) {
      return false
    } else {
      let periodString = period.start >= period.end ? "Empty period \(period)" : "Period \(period)"
      XCTFail("\(periodString) does not contain date \(date).")
      return true
    }
  }
}
