//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import XCTest
@testable import SwiftDateTime


class WeekerTests: XCTestCase & DateTimeGenerator {
  
  let weeker = Weeker()
  
  func testThat7september1812isMonday() {
    XCTAssertEqual(
      weeker.weekday(DayMonthYear(day: 7, month: 9, year: 1812)),
      .monday
    )
  }
  
  func testThatYear2001startsOnMonday() {
    XCTAssertEqual(
      weeker.weekday(DayMonthYear(day: 1, month: 1, year: 2001)),
      .monday
    )
  }
  
  func testThatYear2000startsOnSaturday() {
    XCTAssertEqual(
      weeker.weekday(DayMonthYear(day: 1, month: 1, year: 2000)),
      .saturday
    )
  }
  
  func testThatYear2002startsOnTuesday() {
    XCTAssertEqual(
      weeker.weekday(DayMonthYear(day: 1, month: 1, year: 2002)),
      .tuesday
    )
  }
  
  func testThatDecember2018startsOnSaturday() {
    XCTAssertEqual(
      weeker.weekday(DayMonthYear(day: 1, month: 12, year: 2018)),
      .saturday
    )
  }
  
  func testThat2025endsOnWednesday() {
    XCTAssertEqual(
      weeker.weekday(DayMonthYear(day: 31, month: 12, year: 2025)),
      .wednesday
    )
  }
  
  func testThat2018matches2007() {
    for _ in 1...1000 {
      let (day, month) = randomDayAndMonth(allowLeapDay: false)
      let a = DayMonthYear(day: day, month: month, year: 2018)
      let b = DayMonthYear(day: day, month: month, year: 2007)
      
      let aWeekday = weeker.weekday(a)
      let bWeekday = weeker.weekday(b)
      
      if aWeekday != bWeekday {
        XCTFail(
          "\(a) and \(b) expeced to be the same days of week. " +
          "Actually \(a) is \(aWeekday), but \(b) is \(bWeekday)."
        )
        
        return
      }
    }
  }
  
  func testSameWeekday1() {
    for _ in 1...10000 {
      let year = Int.random(in: -10000...10000)
      let firstDate = DayMonthYear(day: 14, month: 5, year: year)
      let secondDate = DayMonthYear(day: 31, month: 12, year: year)
      
      let firstWeekday = weeker.weekday(firstDate)
      let secondWeekday = weeker.weekday(secondDate)
      
      if firstWeekday != secondWeekday {
        XCTFail(
          "\(firstDate) and \(secondDate) expected to be the same days of week. " +
          "Actually \(firstDate) is \(firstWeekday), but \(secondDate) is \(secondWeekday)."
        )
        
        return
      }
    }
  }
  
  func testSameWeekday2() {
    for _ in 1...10000 {
      let year = Int.random(in: -10000...10000)
      let firstDate = DayMonthYear(day: 17, month: 5, year: year)
      let secondDate = DayMonthYear(day: 28, month: 2, year: year + 1)
      
      let firstWeekday = weeker.weekday(firstDate)
      let secondWeekday = weeker.weekday(secondDate)
      
      if firstWeekday != secondWeekday {
        XCTFail(
          "\(firstDate) and \(secondDate) expeced to be the same days of week. " +
          "Actually \(firstDate) is \(firstWeekday), but \(secondDate) is \(secondWeekday)."
        )
        
        return
      }
    }
  }
  
  func testSameWeekday3() {
    for _ in 1...10000 {
      let a = randomDayMonthYear()
      
      let yearsPerWeekCycle = 2800
      let weekCycles = Int.random(in: -100...100)
      
      let b = DayMonthYear(day: a.day, month: a.month, year: a.year + weekCycles * yearsPerWeekCycle)
      
      let aWeekday = weeker.weekday(a)
      let bWeekday = weeker.weekday(b)
      
      if aWeekday != bWeekday {
        XCTFail(
          "\(a) and \(b) expeced to be the same days of week. " +
          "Actually \(a) is \(aWeekday), but \(b) is \(bWeekday)."
        )
        
        return
      }
    }
  }
  
  func testThatWeekStartsOnMonday() {
    for _ in 1...10000 {
      let date = randomDayMonthYear()
      
      let week = weeker.week(date)
      let weekStart = weeker.weekday(week.start)
      
      if weekStart != .monday {
        XCTFail(
          "Week containing \(date) should start on Monday. " +
          "But actually week is \(week) and starts on \(weekStart)."
        )
        
        return
      }
    }
  }
  
  func testThatWeekAlwaysContains7days() {
    for _ in 1...10000 {
      let date = randomDayMonthYear()
      let week = weeker.week(date)
      let weekLength = DatesManipulator().days(from: week.start, to: week.end)
      
      if weekLength != 7 {
        XCTFail(
          "Week containing \(date) should contain 7 days. " +
          "But actually week is \(week), and contains \(weekLength) days."
        )
        
        return
      }
    }
  }
}
