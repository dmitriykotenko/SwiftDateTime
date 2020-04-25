//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


extension CalendarDuration {
  
  static prefix func - (duration: CalendarDuration) -> CalendarDuration {
    return CalendarDuration(days: -duration.days)
  }
  
  static func + (this: CalendarDuration, that: CalendarDuration) -> CalendarDuration {
    return CalendarDuration(days: this.days + that.days)
  }
  
  static func - (this: CalendarDuration, that: CalendarDuration) -> CalendarDuration {
    return this + (-that)
  }
  
  static func * (duration: CalendarDuration, multiplier: Int) -> CalendarDuration {
    return CalendarDuration(days: duration.days * multiplier)
  }
  
  static func / (duration: CalendarDuration, divider: Int) -> CalendarDuration {
    return CalendarDuration(days: duration.days / divider)
  }
}
