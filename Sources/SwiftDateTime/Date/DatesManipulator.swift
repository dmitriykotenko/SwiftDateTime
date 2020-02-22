//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


class DatesManipulator {
  
  let parser = AbsoluteDayParser()
  let builder = AbsoluteDayBuilder()
  
  func nextDay(_ dayMonthYear: DayMonthYear) -> DayMonthYear {
    return date(dayMonthYear, plusDays: 1)
  }

  func previousDay(_ dayMonthYear: DayMonthYear) -> DayMonthYear {
    return date(dayMonthYear, minusDays: 1)
  }

  func days(from a: DayMonthYear, to b: DayMonthYear) -> Int {    
    return builder.absoluteDay(b) - builder.absoluteDay(a)
  }
  
  func date(_ a: DayMonthYear,
            plusDays days: Int) -> DayMonthYear {
    
    return parser.dayMonthYear(absoluteDay:
      builder.absoluteDay(a) + days
    )
  }
  
  func date(_ a: DayMonthYear,
            minusDays days: Int) -> DayMonthYear {
    return date(a, plusDays: -days)
  }
}
