//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import Foundation


class DateTimeManipulator {
  
  func localDateTime(_ dateTime: LocalDateTime,
            plus duration: Duration) -> LocalDateTime {
    let (days, time) = daysAndTime(dateTime.time, plus: duration)
    
    return LocalDateTime(
      date: DatesManipulator().date(dateTime.date, plusDays: days),
      time: time
    )
  }
  
  func localDateTime(_ dateTime: LocalDateTime,
                     minus duration: Duration) -> LocalDateTime {
    return localDateTime(
      dateTime,
      plus: Duration(
        seconds: -duration.seconds,
        thousandths: Int(duration.milliseconds)
      )
    )
  }
  
  private func daysAndTime(_ time: HoursMinutesSeconds,
                           plus duration: Duration) -> (days: Int, time: HoursMinutesSeconds) {
    return daysAndTime(time.toDuration + duration)
  }
  
  private func daysAndTime(_ duration: Duration) -> (days: Int, time: HoursMinutesSeconds) {
    let secondsPerDay = 86400

    let doubleDays = (Double(duration.seconds) / Double(secondsPerDay)).rounded(.down)
    let days = Int(doubleDays)
    
    let remainingSeconds = duration.seconds - days * secondsPerDay
    let milliseconds = Int(duration.milliseconds)
    
    return (
      days: days,
      time: HoursMinutesSeconds(
        secondsFromMidnight: remainingSeconds,
        milliseconds: milliseconds
      )
    )
  }
}


fileprivate extension HoursMinutesSeconds {
  
  var toDuration: Duration {
    return Duration(
      hours: hours,
      minutes: minutes,
      seconds: seconds,
      thousandths: milliseconds
    )
  }
}
