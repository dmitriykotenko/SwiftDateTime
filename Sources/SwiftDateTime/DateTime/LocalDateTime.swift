//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import Foundation


public struct LocalDateTime: Codable, Equatable, Hashable {
  
  public let date: DayMonthYear
  public let time: HoursMinutesSeconds
  
  public func copy(date: DayMonthYear? = nil,
                   time: HoursMinutesSeconds? = nil) -> LocalDateTime {
    return LocalDateTime(
      date: date ?? self.date,
      time: time ?? self.time
    )
  }
}


extension LocalDateTime: Comparable {
  
  public static func < (this: LocalDateTime, that: LocalDateTime) -> Bool {
    if this.date != that.date {
      return this.date < that.date
    }
    
    return this.time < that.time
  }
}
