//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import Foundation


public class MainClock: Clock {
  
  private let calendar: Calendar
  private let datesManipulator = DatesManipulator()

  public init(timeZone: TimeZone? = nil) {
    var newCalendar = Calendar(identifier: .gregorian)
    timeZone.map { newCalendar.timeZone = $0 }
    self.calendar = newCalendar
  }
  
  public convenience init(timeZoneOffset: Duration?) {
    self.init(timeZone:
      timeZoneOffset.flatMap { TimeZone(secondsFromGMT: $0.seconds) }
    )
  }

  public var now: DateTime {
    let nowDate = Date()
    let timeZoneOffsetSeconds = calendar.timeZone.secondsFromGMT(for: nowDate)
    
    let nowComponents = calendar.dateComponents(
      [.day, .month, .year, .hour, .minute, .second, .nanosecond],
      from: nowDate
    )
    
    guard
      let day = nowComponents.day,
      let month = nowComponents.month,
      let year = nowComponents.year,
      let hours = nowComponents.hour,
      let minutes = nowComponents.minute,
      let seconds = nowComponents.second,
      let milliseconds = nowComponents.nanosecond.map ({ $0 / .nanosecondsPerMillisecond })
      else {
        fatalError("Clock could not parse nowComponents.")
    }
    
    return DateTime(
      date: DayMonthYear(day: day, month: month, year: year),
      time: HoursMinutesSeconds(hours: hours, minutes: minutes, seconds: seconds, milliseconds: milliseconds),
      timeZoneOffset: Duration(seconds: timeZoneOffsetSeconds)
    )
  }
}
