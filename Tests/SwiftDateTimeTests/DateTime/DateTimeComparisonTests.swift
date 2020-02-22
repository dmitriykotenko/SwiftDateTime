//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import XCTest
@testable import SwiftDateTime


class DateTimeComparisonTests: XCTestCase {
  
  func testThatDateIsMoreImportantThanTime() {
    let a = DateTime(
      date: DayMonthYear(day: 7, month: 8, year: 2009),
      time: HoursMinutesSeconds(hours: 18, minutes: 19, seconds: 20),
      timeZoneOffset: Duration(hours: 3)
    )
    
    let b = DateTime(
      date: DayMonthYear(day: 8, month: 8, year: 2009),
      time: HoursMinutesSeconds(hours: 12, minutes: 19, seconds: 21),
      timeZoneOffset: Duration(hours: 3)
    )
    
    XCTAssert(
      a < b,
      "\(a) is greater than or equal to \(b)"
    )
  }
  
  func testThatTimeIsMoreImportantThanTimeZone() {
    let date = DayMonthYear(day: 7, month: 8, year: 2009)
    
    let a = DateTime(
      date: date,
      time: HoursMinutesSeconds(hours: 18, minutes: 19, seconds: 20),
      timeZoneOffset: Duration(negative: true, hours: 3)
    )
    
    let b = DateTime(
      date: date,
      time: HoursMinutesSeconds(hours: 18, minutes: 19, seconds: 21),
      timeZoneOffset: Duration(hours: 3)
    )
    
    XCTAssert(
      a < b,
      "\(a) is greater than or equal to \(b)"
    )
  }
  
  func testThatTimeZoneComparedCorrectly() {
    let date = DayMonthYear(day: 7, month: 8, year: 2009)
    let time = HoursMinutesSeconds(hours: 18, minutes: 19, seconds: 20)
    
    let a = DateTime(
      date: date,
      time: time,
      timeZoneOffset: Duration(hours: 3)
    )
    
    let b = DateTime(
      date: date,
      time: time,
      timeZoneOffset: Duration(negative: true, hours: 3)
    )
    
    XCTAssert(
      a < b,
      "\(a) is greater than or equal to \(b)"
    )
  }
}
