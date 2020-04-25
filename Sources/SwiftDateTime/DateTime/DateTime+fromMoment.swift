//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import Foundation


public extension DateTime {
  
  init(moment: Date,
       timeZone: TimeZone = .utc) {
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = timeZone
    
    let timeZoneOffsetSeconds = calendar.timeZone.secondsFromGMT(for: moment)
    
    let nowComponents = calendar.dateComponents(
      [.day, .month, .year, .hour, .minute, .second, .nanosecond],
      from: moment
    )
    
    guard
      let day = nowComponents.day,
      let month = nowComponents.month,
      let year = nowComponents.year,
      let hours = nowComponents.hour,
      let minutes = nowComponents.minute,
      let seconds = nowComponents.second,
      let milliseconds = nowComponents.nanosecond.map({ $0 / 1_000_000 })
      else { fatalError("Can not parse date components.") }
    
    self.init(
      date: DayMonthYear(day: day, month: month, year: year),
      time: HoursMinutesSeconds(hours: hours, minutes: minutes, seconds: seconds, milliseconds: milliseconds),
      timeZoneOffset: Duration(seconds: timeZoneOffsetSeconds)
    )
  }
}
