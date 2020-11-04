//  Copyright © 2020 Evgeniy Lubaev. All rights reserved.

import Foundation


public extension DateTime {
  
  var moment: Date {
    let dateComponents = DateComponents(
      calendar: Calendar(identifier: .gregorian),
      timeZone: TimeZone(secondsFromGMT: Int(timeZoneOffset.milliseconds / 1000)),
      year: date.year,
      month: date.month,
      day: date.day,
      hour: time.hours,
      minute: time.minutes,
      second: time.seconds,
      nanosecond: time.milliseconds * .nanosecondsPerMillisecond
    )
    
    if let moment = dateComponents.date {
      return moment
    } else {
      fatalError("Can not convert date components \(dateComponents) to Date")
    }
  }

  var weekday: Weekday {
    return local.weekday
  }

  func withTimeZoneOffsetChanged(to newOffset: Duration) -> DateTime {
    return DateTimesManipulator().dateTime(
      self,
      withTimeZoneOffsetChangedTo: newOffset
    )
  }

  static func - (this: DateTime, that: DateTime) -> Duration {

    return (this.local - that.local) + (that.timeZoneOffset - this.timeZoneOffset)
  }

  static func + (dateTime: DateTime, duration: Duration) -> DateTime {
    return DateTimesManipulator()
      .dateTime(dateTime, plus: duration)
  }
  
  static func - (dateTime: DateTime, duration: Duration) -> DateTime {
    return dateTime + (-duration)
  }
  
  static func + (dateTime: DateTime, calendarDuration: CalendarDuration) -> DateTime {
    return dateTime.copy(
      date: dateTime.date + calendarDuration
    )
  }
  
  static func - (dateTime: DateTime, calendarDuration: CalendarDuration) -> DateTime {
    return dateTime + (-calendarDuration)
  }
}
