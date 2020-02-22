//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import Foundation


struct DateTime: Codable, Equatable, Hashable {
  
  let date: DayMonthYear
  let time: HoursMinutesSeconds  
  let timeZoneOffset: Duration
  
  init(date: DayMonthYear,
       time: HoursMinutesSeconds,
       timeZoneOffset: Duration) {
    
    self.date = date
    self.time = time
    self.timeZoneOffset = timeZoneOffset
  }
  
  init(localDateTime: LocalDateTime,
       timeZoneOffset: Duration) {
    self.date = localDateTime.date
    self.time = localDateTime.time
    self.timeZoneOffset = timeZoneOffset
  }
  
  func copy(date: DayMonthYear? = nil,
            time: HoursMinutesSeconds? = nil,
            timeZoneOffset: Duration? = nil) -> DateTime {
    return DateTime(
      date: date ?? self.date,
      time: time ?? self.time,
      timeZoneOffset: timeZoneOffset ?? self.timeZoneOffset
    )
  }
  
  func copy(localDateTime: LocalDateTime? = nil,
            timeZoneOffset: Duration? = nil) -> DateTime {
    return DateTime(
      date: localDateTime?.date ?? self.date,
      time: localDateTime?.time ?? self.time,
      timeZoneOffset: timeZoneOffset ?? self.timeZoneOffset
    )
  }

  var local: LocalDateTime {
    return LocalDateTime(
      date: date,
      time: time
    )
  }
}


extension DateTime: Comparable {
  
  static func < (this: DateTime, that: DateTime) -> Bool {
    if this.date != that.date {
      return this.date < that.date
    }

    if this.time != that.time {
      return this.time < that.time
    }
    
    return this.timeZoneOffset > that.timeZoneOffset
  }
}
