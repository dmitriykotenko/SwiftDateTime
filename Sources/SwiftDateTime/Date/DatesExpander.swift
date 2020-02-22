//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


class DatesExpander {
  
  let manipulator = DatesManipulator()
  let weeker = Weeker()
  
  func expand(_ dayMonthYear: DayMonthYear,
              to unit: PeriodUnit) -> DayMonthYearPeriod {
    switch unit {
    case .day: return singleDay(dayMonthYear)
    case .week: return week(dayMonthYear)
    case .month: return month(dayMonthYear)
    case .year: return year(dayMonthYear)
    }
  }
  
  func singleDay(_ dayMonthYear: DayMonthYear) -> DayMonthYearPeriod {
    return DayMonthYearPeriod(
      start: dayMonthYear,
      end: manipulator.nextDay(dayMonthYear)
    )
  }

  func week(_ dayMonthYear: DayMonthYear) -> DayMonthYearPeriod {
    return weeker.week(dayMonthYear)
  }

  func month(_ dayMonthYear: DayMonthYear) -> DayMonthYearPeriod {
    
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

  func year(_ dayMonthYear: DayMonthYear) -> DayMonthYearPeriod {
    return DayMonthYearPeriod(
      start: DayMonthYear(day: 1, month: 1, year: dayMonthYear.year),
      end: DayMonthYear(day: 1, month: 1, year: dayMonthYear.year + 1)
    )
  }
}
