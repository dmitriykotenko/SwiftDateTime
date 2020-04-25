//  Copyright © 2020 Evgeniy Lubaev. All rights reserved.


public extension DayMonthYear {

  var nextDay: DayMonthYear {
    return DatesManipulator().nextDay(self)
  }
  
  var previousDay: DayMonthYear {
    return DatesManipulator().previousDay(self)
  }

  static func + (date: DayMonthYear,
                 duration: CalendarDuration) -> DayMonthYear {
    return DatesManipulator().date(date, plus: duration)
  }
  
  static func - (date: DayMonthYear,
                 duration: CalendarDuration) -> DayMonthYear {
    return date + (-duration)
  }
  
  static func - (this: DayMonthYear,
                 that: DayMonthYear) -> CalendarDuration {
    return DatesManipulator().duration(from: that, to: this)
  }
}


public extension DayMonthYear {
  
  var weekday: Weekday {
    return Weeker().weekday(self)
  }
  
  var week: DayMonthYearPeriod {
    return Weeker().week(self)
  }
  
  var weekStart: DayMonthYear {
    return Weeker().weekstart(self)
  }
  
  var weekEnd: DayMonthYear {
    return Weeker().weekend(self)
  }
  
  var nextWeek: DayMonthYearPeriod {
    return Weeker().week(self + 7.days)
  }
  
  var previousWeek: DayMonthYearPeriod {
    return Weeker().week(self - 7.days)
  }
}
