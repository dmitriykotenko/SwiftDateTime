//  Copyright © 2020 Evgeniy Lubaev. All rights reserved.


public extension DayMonthYear {

  var nextDay: DayMonthYear {
    DatesManipulator().nextDay(self)
  }
  
  var previousDay: DayMonthYear {
    DatesManipulator().previousDay(self)
  }

  static func + (date: DayMonthYear,
                 duration: CalendarDuration) -> DayMonthYear {
    DatesManipulator().date(date, plus: duration)
  }
  
  static func - (date: DayMonthYear,
                 duration: CalendarDuration) -> DayMonthYear {
    date + (-duration)
  }
  
  static func - (this: DayMonthYear,
                 that: DayMonthYear) -> CalendarDuration {
    DatesManipulator().duration(from: that, to: this)
  }
}


public extension DayMonthYear {
  
  var weekday: Weekday {
    Weeker().weekday(self)
  }
  
  var week: DayMonthYearPeriod {
    Weeker().week(self)
  }
  
  var weekStart: DayMonthYear {
    Weeker().weekstart(self)
  }
  
  var weekEnd: DayMonthYear {
    Weeker().weekend(self)
  }
  
  var nextWeek: DayMonthYearPeriod {
    Weeker().week(self + 7.days)
  }
  
  var previousWeek: DayMonthYearPeriod {
    Weeker().week(self - 7.days)
  }
}
