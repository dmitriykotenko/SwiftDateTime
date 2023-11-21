//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


public class DatesManipulator {
  
  let parser = AbsoluteDayParser()
  let builder = AbsoluteDayBuilder()

  public init() {}

  public func nextDay(_ dayMonthYear: DayMonthYear) -> DayMonthYear {
    date(dayMonthYear, plusDays: 1)
  }
  
  public func previousDay(_ dayMonthYear: DayMonthYear) -> DayMonthYear {
    date(dayMonthYear, minusDays: 1)
  }
  
  public func days(from a: DayMonthYear, to b: DayMonthYear) -> Int {
    builder.absoluteDay(b) - builder.absoluteDay(a)
  }
  
  public func date(_ a: DayMonthYear,
                   plusDays days: Int) -> DayMonthYear {
    parser.dayMonthYear(absoluteDay:
      builder.absoluteDay(a) + days
    )
  }
  
  public func date(_ a: DayMonthYear,
                   minusDays days: Int) -> DayMonthYear {
    date(a, plusDays: -days)
  }
}


public extension DatesManipulator {
  
  func duration(from a: DayMonthYear, to b: DayMonthYear) -> CalendarDuration {
    CalendarDuration(days: days(from: a, to: b))
  }
  
  func date(_ a: DayMonthYear,
            plus duration: CalendarDuration) -> DayMonthYear {    
    parser.dayMonthYear(absoluteDay:
      builder.absoluteDay(a) + duration.days
    )
  }
  
  func date(_ a: DayMonthYear,
            minus duration: CalendarDuration) -> DayMonthYear {
    date(a, plus: -duration)
  }
}
