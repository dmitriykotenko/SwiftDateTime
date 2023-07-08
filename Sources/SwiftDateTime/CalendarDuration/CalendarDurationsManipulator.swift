//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


public extension CalendarDuration {
  
  static prefix func - (duration: CalendarDuration) -> CalendarDuration {
    CalendarDuration(days: -duration.days)
  }
  
  static func + (this: CalendarDuration, that: CalendarDuration) -> CalendarDuration {
    CalendarDuration(days: this.days + that.days)
  }
  
  static func - (this: CalendarDuration, that: CalendarDuration) -> CalendarDuration {
    this + (-that)
  }
  
  static func * (duration: CalendarDuration, multiplier: Int) -> CalendarDuration {
    CalendarDuration(days: duration.days * multiplier)
  }
  
  static func / (duration: CalendarDuration, divider: Int) -> CalendarDuration {
    CalendarDuration(days: duration.days / divider)
  }
}
