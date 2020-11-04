//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import Foundation


public class DateTimesManipulator {
  
  public func dateTime(_ dateTime: DateTime,
                       plus duration: Duration) -> DateTime {
    return DateTime(
      localDateTime: localDateTime(dateTime.local, plus: duration),
      timeZoneOffset: dateTime.timeZoneOffset
    )
  }
  
  public func dateTime(_ dateTime: DateTime,
                       minus duration: Duration) -> DateTime {
    return DateTime(
      localDateTime: localDateTime(dateTime.local, minus: duration),
      timeZoneOffset: dateTime.timeZoneOffset
    )
  }
  
  public func localDateTime(_ dateTime: LocalDateTime,
                            plus duration: Duration) -> LocalDateTime {
    let (days, time) = daysAndTime(dateTime.time, plus: duration)
    
    return LocalDateTime(
      date: DatesManipulator().date(dateTime.date, plusDays: days),
      time: time
    )
  }
  
  public func localDateTime(_ dateTime: LocalDateTime,
                            minus duration: Duration) -> LocalDateTime {
    return localDateTime(
      dateTime,
      plus: -duration
    )
  }
  
  private func daysAndTime(_ time: HoursMinutesSeconds,
                           plus duration: Duration) -> (days: Int, time: HoursMinutesSeconds) {
    return daysAndTime(time.durationFromMidnight + duration)
  }

  private func daysAndTime(_ duration: Duration) -> (days: Int, time: HoursMinutesSeconds) {
    let millisecondsPerDay = 86400 * 1000

    let milliseconds = duration.milliseconds
    let doubleDays = (Double(milliseconds) / Double(millisecondsPerDay)).rounded(.down)
    let days = Int(doubleDays)
    
    let remainingMilliseconds = Int(milliseconds) - days * millisecondsPerDay

    return (
      days: days,
      time: HoursMinutesSeconds(
        secondsFromMidnight: remainingMilliseconds / 1000,
        milliseconds: remainingMilliseconds % 1000
      )
    )
  }
}
