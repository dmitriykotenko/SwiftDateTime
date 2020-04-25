//  Copyright © 2020 Evgeniy Lubaev. All rights reserved.


public extension CalendarDuration {
  
  static func days(_ days: Int) -> CalendarDuration {
    return CalendarDuration(days: days)
  }
  
  static func weeks(_ weeks: Int) -> CalendarDuration {
    return CalendarDuration(days: weeks * 7)
  }
}


public extension Int {
  
  var days: CalendarDuration {
    return .days(self)
  }
  
  var weeks: CalendarDuration {
    return .weeks(self)
  }
}
