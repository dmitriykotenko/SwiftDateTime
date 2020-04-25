//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


public class Weeker {

  private let reference = (
    dayMonthYear: DayMonthYear(day: 1, month: 1, year: 2001),
    weekday: Weekday.monday
  )
  
  private let manipulator = DatesManipulator()
  
  public func week(_ dayMonthYear: DayMonthYear) -> DayMonthYearPeriod {
    let start = weekstart(dayMonthYear)

    return DayMonthYearPeriod(
      start: start,
      end: manipulator.date(start, plusDays: 7)
    )
  }
  
  public func weekday(_ dayMonthYear: DayMonthYear) -> Weekday {
    let daysSinceMonday = manipulator.days(from: reference.dayMonthYear, to: dayMonthYear)
    
    return reference.weekday.plus(days: daysSinceMonday)
  }
  
  public func weekstart(_ dayMonthYear: DayMonthYear) -> DayMonthYear {
    return last(.monday, before: dayMonthYear)
  }
  
  public func weekend(_ dayMonthYear: DayMonthYear) -> DayMonthYear {
    return first(.sunday, after: dayMonthYear)
  }

  private func last(_ desiredWeekday: Weekday,
                    before dayMonthYear: DayMonthYear) -> DayMonthYear {
    let days = (weekday(dayMonthYear).rawValue - desiredWeekday.rawValue + 7) % 7
    
    return manipulator.date(dayMonthYear, minusDays: days)
  }

  private func first(_ desiredWeekday: Weekday,
                    after dayMonthYear: DayMonthYear) -> DayMonthYear {
    let days = (desiredWeekday.rawValue - weekday(dayMonthYear).rawValue + 7) % 7
    
    return manipulator.date(dayMonthYear, plusDays: days)
  }
}


private extension Weekday {
  
  func plus(days: Int) -> Weekday {
    var raw = (rawValue + days) % 7
    if raw < 1 { raw += 7 }
    
    return Weekday(rawValue: raw)!
  }
  
  func plus(_ duration: CalendarDuration) -> Weekday {
    var raw = (rawValue + duration.days) % 7
    if raw < 1 { raw += 7 }
    
    return Weekday(rawValue: raw)!
  }
}
