//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import XCTest
@testable import SwiftDateTime


protocol DateTimeGenerator {
  
  func randomDateTime(date: DayMonthYear?,
                      time: HoursMinutesSeconds?,
                      timeZoneOffset: Duration?) -> DateTime
  
  func randomDayMonthYear() -> DayMonthYear
  
  func randomHoursMinutesSeconds(hours: Int?,
                                 minutes: Int?,
                                 seconds: Int?,
                                 milliseconds: Int?) -> HoursMinutesSeconds
  
  func randomTimeZoneOffset() -> Duration
}


extension DateTimeGenerator {
  
  func randomDateTime(date: DayMonthYear? = nil,
                      time: HoursMinutesSeconds? = nil,
                      timeZoneOffset: Duration? = nil) -> DateTime {
    return DateTime(
      date: date ?? randomDayMonthYear(),
      time: time ?? randomHoursMinutesSeconds(),
      timeZoneOffset: timeZoneOffset ?? randomTimeZoneOffset()
    )
  }
  
  func randomDayMonthYear() -> DayMonthYear {
    let year = 1980 + arc4random_uniform(50)
    let month = 1 + arc4random_uniform(12)
    let day = 1 + arc4random_uniform(monthLength(year: year, month: month))

    return DayMonthYear(
      day: Int(day),
      month: Int(month),
      year: Int(year)
    )
  }
  
  func randomDayAndMonth(allowLeapDay: Bool = true) -> (day: Int, month: Int) {
    let sampleYear: UInt32 = allowLeapDay ? 2000 : 2001
    
    let month = 1 + arc4random_uniform(12)
    let day = 1 + arc4random_uniform(monthLength(year: sampleYear, month: month))
    
    return (day: Int(day), month: Int(month))
  }

  private func monthLength(year: UInt32, month: UInt32) -> UInt32 {
    switch month {
    case 1, 3, 5, 7, 8, 10, 12: return 31
    case 4, 6, 9, 11: return 30
    default:
      return
        (year % 400 == 0) ? 29 :
        (year % 100 == 0) ? 28 :
        (year % 4 == 0) ? 29 :
        28
    }
  }
  
  func randomHoursMinutesSeconds(hours: Int? = nil,
                                 minutes: Int? = nil,
                                 seconds: Int? = nil,
                                 milliseconds: Int? = nil) -> HoursMinutesSeconds {
    return HoursMinutesSeconds(
      hours: hours ?? Int.random(in: 0..<24),
      minutes: minutes ?? Int.random(in: 0..<60),
      seconds: seconds ?? Int.random(in: 0..<60),
      milliseconds: milliseconds ?? Int.random(in: 0..<1000)
    )
  }
  
  func randomTimeZoneOffset() -> Duration {
    // Possible time zone offsets: https://en.wikipedia.org/wiki/List_of_UTC_time_offsets
    let westernmost = -12
    let easternmost = 14
    let hours = Int.random(in: westernmost...easternmost)
    
    return Duration(
      negative: hours < 0,
      hours: abs(hours)
    )
  }
}
