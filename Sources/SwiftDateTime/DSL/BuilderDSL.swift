//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


public extension Int {
  
  func january(_ year: Int) -> DayMonthYear {
    DayMonthYear(day: self, month: 1, year: year)
  }

  func february(_ year: Int) -> DayMonthYear {
    DayMonthYear(day: self, month: 2, year: year)
  }

  func march(_ year: Int) -> DayMonthYear {
    DayMonthYear(day: self, month: 3, year: year)
  }

  func april(_ year: Int) -> DayMonthYear {
    DayMonthYear(day: self, month: 4, year: year)
  }

  func may(_ year: Int) -> DayMonthYear {
    DayMonthYear(day: self, month: 5, year: year)
  }

  func june(_ year: Int) -> DayMonthYear {
    DayMonthYear(day: self, month: 6, year: year)
  }

  func july(_ year: Int) -> DayMonthYear {
    DayMonthYear(day: self, month: 7, year: year)
  }

  func august(_ year: Int) -> DayMonthYear {
    DayMonthYear(day: self, month: 8, year: year)
  }

  func september(_ year: Int) -> DayMonthYear {
    DayMonthYear(day: self, month: 9, year: year)
  }

  func october(_ year: Int) -> DayMonthYear {
    DayMonthYear(day: self, month: 10, year: year)
  }

  func november(_ year: Int) -> DayMonthYear {
    DayMonthYear(day: self, month: 11, year: year)
  }

  func december(_ year: Int) -> DayMonthYear {
    DayMonthYear(day: self, month: 12, year: year)
  }
}


public extension DayMonthYear {
  
  func time(_ hours: Int,
            _ minutes: Int,
            _ seconds: Int = 0,
            _ milliseconds: Int = 0) -> LocalDateTime {
    time(
      HoursMinutesSeconds(
        hours: hours,
        minutes: minutes,
        seconds: seconds,
        milliseconds: milliseconds
      )
    )
  }
  
  func time(_ time: HoursMinutesSeconds) -> LocalDateTime {
    LocalDateTime(
      date: self,
      time: time
    )
  }
}


public extension LocalDateTime {
  
  func utc() -> DateTime {
    DateTime(
      localDateTime: self,
      timeZoneOffset: .zero
    )
  }
  
  func zone(hours: Int) -> DateTime {
    DateTime(
      localDateTime: self,
      timeZoneOffset: Duration(
        negative: hours < 0,
        hours: abs(hours)
      )
    )
  }
  
  func zone(_ timeZoneOffset: Duration) -> DateTime {
    DateTime(
      localDateTime: self,
      timeZoneOffset: timeZoneOffset
    )
  }
}
