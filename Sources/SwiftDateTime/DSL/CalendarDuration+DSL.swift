//  Copyright © 2020 Evgeniy Lubaev. All rights reserved.


public extension CalendarDuration {
  
  static func days(_ days: Int) -> CalendarDuration {
    CalendarDuration(days: days)
  }
  
  static func weeks(_ weeks: Int) -> CalendarDuration {
    CalendarDuration(days: weeks * 7)
  }
}


public extension Int {
  
  var days: CalendarDuration {
    .days(self)
  }
  
  var weeks: CalendarDuration {
    .weeks(self)
  }
}
