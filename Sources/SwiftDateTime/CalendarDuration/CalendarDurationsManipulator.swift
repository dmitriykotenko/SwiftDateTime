//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


extension CalendarDuration {
  
  static prefix func - (duration: CalendarDuration) -> CalendarDuration {
    return CalendarDuration(days: -duration.days)
  }
  
  static func + (this: CalendarDuration, that: CalendarDuration) -> CalendarDuration {
    return CalendarDuration(days: this.days + that.days)
  }
  
  static func - (this: CalendarDuration, that: CalendarDuration) -> CalendarDuration {
    return CalendarDuration(days: this.days - that.days)
  }
}
