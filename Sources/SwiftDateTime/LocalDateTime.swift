//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import Foundation


struct LocalDateTime: Codable, Equatable, Hashable {
  
  let date: DayMonthYear
  let time: HoursMinutesSeconds
  
  func copy(date: DayMonthYear? = nil,
            time: HoursMinutesSeconds? = nil) -> LocalDateTime {
    return LocalDateTime(
      date: date ?? self.date,
      time: time ?? self.time
    )
  }
}


extension LocalDateTime: Comparable {
  
  static func < (this: LocalDateTime, that: LocalDateTime) -> Bool {
    if this.date != that.date {
      return this.date < that.date
    }
    
    return this.time < that.time
  }
}
