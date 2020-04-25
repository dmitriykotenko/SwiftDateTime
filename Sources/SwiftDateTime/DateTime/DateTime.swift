//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import Foundation


public struct DateTime: Codable, Equatable, Hashable {
  
  public let date: DayMonthYear
  public let time: HoursMinutesSeconds
  public let timeZoneOffset: Duration
  
  public init(date: DayMonthYear,
              time: HoursMinutesSeconds,
              timeZoneOffset: Duration) {
    
    self.date = date
    self.time = time
    self.timeZoneOffset = timeZoneOffset
  }
  
  public init(localDateTime: LocalDateTime,
              timeZoneOffset: Duration) {
    self.date = localDateTime.date
    self.time = localDateTime.time
    self.timeZoneOffset = timeZoneOffset
  }
  
  public func copy(date: DayMonthYear? = nil,
                   time: HoursMinutesSeconds? = nil,
                   timeZoneOffset: Duration? = nil) -> DateTime {
    return DateTime(
      date: date ?? self.date,
      time: time ?? self.time,
      timeZoneOffset: timeZoneOffset ?? self.timeZoneOffset
    )
  }
  
  public func copy(localDateTime: LocalDateTime? = nil,
                   timeZoneOffset: Duration? = nil) -> DateTime {
    return DateTime(
      date: localDateTime?.date ?? self.date,
      time: localDateTime?.time ?? self.time,
      timeZoneOffset: timeZoneOffset ?? self.timeZoneOffset
    )
  }
  
  public var local: LocalDateTime {
    return LocalDateTime(
      date: date,
      time: time
    )
  }
}
