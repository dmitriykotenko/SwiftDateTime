//  Copyright © 2020 Evgeniy Lubaev. All rights reserved.


public extension LocalDateTime {
  
  var weekday: Weekday {
    date.weekday
  }
  
  static func - (this: LocalDateTime, that: LocalDateTime) -> Duration {
    let dateDifference = this.date - that.date
    let timeDifference = this.time - that.time
    
    return Duration.day * dateDifference.days + timeDifference
  }
  
  static func + (dateTime: LocalDateTime, duration: Duration) -> LocalDateTime {
    DateTimesManipulator()
      .localDateTime(dateTime, plus: duration)
  }
  
  static func - (dateTime: LocalDateTime, duration: Duration) -> LocalDateTime {
    dateTime + (-duration)
  }
  
  static func + (dateTime: LocalDateTime, calendarDuration: CalendarDuration) -> LocalDateTime {
    dateTime.copy(
      date: dateTime.date + calendarDuration
    )
  }
  
  static func - (dateTime: LocalDateTime, calendarDuration: CalendarDuration) -> LocalDateTime {
    dateTime + (-calendarDuration)
  }
}
