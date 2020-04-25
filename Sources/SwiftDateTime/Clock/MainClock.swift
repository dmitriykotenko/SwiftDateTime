//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import Foundation


public class MainClock: Clock {
  
  private let calendar = Calendar(identifier: .gregorian)
  private let datesManipulator = DatesManipulator()
  
  public init() {}
  
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
