//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import XCTest
@testable import SwiftDateTime


extension Int {
  
  func january(_ year: Int) -> DayMonthYear {
    return DayMonthYear(day: self, month: 1, year: year)
  }

  func february(_ year: Int) -> DayMonthYear {
    return DayMonthYear(day: self, month: 2, year: year)
  }

  func march(_ year: Int) -> DayMonthYear {
    return DayMonthYear(day: self, month: 3, year: year)
  }

  func april(_ year: Int) -> DayMonthYear {
    return DayMonthYear(day: self, month: 4, year: year)
  }

  func may(_ year: Int) -> DayMonthYear {
    return DayMonthYear(day: self, month: 5, year: year)
  }

  func june(_ year: Int) -> DayMonthYear {
    return DayMonthYear(day: self, month: 6, year: year)
  }

  func july(_ year: Int) -> DayMonthYear {
    return DayMonthYear(day: self, month: 7, year: year)
  }

  func august(_ year: Int) -> DayMonthYear {
    return DayMonthYear(day: self, month: 8, year: year)
  }

  func september(_ year: Int) -> DayMonthYear {
    return DayMonthYear(day: self, month: 9, year: year)
  }

  func october(_ year: Int) -> DayMonthYear {
    return DayMonthYear(day: self, month: 10, year: year)
  }

  func november(_ year: Int) -> DayMonthYear {
    return DayMonthYear(day: self, month: 11, year: year)
  }

  func december(_ year: Int) -> DayMonthYear {
    return DayMonthYear(day: self, month: 12, year: year)
  }
}


extension DayMonthYear {
  
  func time(_ hours: Int,
            _ minutes: Int,
            _ seconds: Int = 0,
            _ milliseconds: Int = 0) -> LocalDateTime {
    
    return LocalDateTime(
      date: self,
      time: HoursMinutesSeconds(
        hours: hours,
        minutes: minutes,
        seconds: seconds,
        milliseconds: milliseconds
      )
    )
  }
}


extension LocalDateTime {
  
  func utc() -> DateTime {
    return DateTime(
      localDateTime: self,
      timeZoneOffset: .zero
    )
  }
  
  func zone(hours: Int) -> DateTime {
    return DateTime(
      localDateTime: self,
      timeZoneOffset: Duration(
        negative: hours < 0,
        hours: abs(hours)
      )
    )
  }
}
