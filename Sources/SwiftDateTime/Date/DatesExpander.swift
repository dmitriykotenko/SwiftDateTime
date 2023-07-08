//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


public class DatesExpander {
  
  let manipulator = DatesManipulator()
  let weeker = Weeker()
  
  public func expand(_ dayMonthYear: DayMonthYear,
                     to unit: PeriodUnit) -> DayMonthYearPeriod {
    switch unit {
    case .day: return singleDay(dayMonthYear)
    case .week: return week(dayMonthYear)
    case .month: return month(dayMonthYear)
    case .year: return year(dayMonthYear)
    }
  }
  
  public func singleDay(_ dayMonthYear: DayMonthYear) -> DayMonthYearPeriod {
    DayMonthYearPeriod(
      start: dayMonthYear,
      end: manipulator.nextDay(dayMonthYear)
    )
  }
  
  public func week(_ dayMonthYear: DayMonthYear) -> DayMonthYearPeriod {
    weeker.week(dayMonthYear)
  }
  
  public func month(_ dayMonthYear: DayMonthYear) -> DayMonthYearPeriod {    
    let nextMonth = dayMonthYear.month % 12 + 1
    let year = (nextMonth == 1) ? (dayMonthYear.year + 1) : dayMonthYear.year
    
    return DayMonthYearPeriod(
      start: DayMonthYear(
        day: 1,
        month: dayMonthYear.month,
        year: dayMonthYear.year
      ),
      end: DayMonthYear(
        day: 1,
        month: nextMonth,
        year: year
      )
    )
  }
  
  public func year(_ dayMonthYear: DayMonthYear) -> DayMonthYearPeriod {
    DayMonthYearPeriod(
      start: DayMonthYear(day: 1, month: 1, year: dayMonthYear.year),
      end: DayMonthYear(day: 1, month: 1, year: dayMonthYear.year + 1)
    )
  }
}
