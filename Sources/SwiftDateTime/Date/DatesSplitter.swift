//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


public class DatesSplitter {
  
  let manipulator = DatesManipulator()
  let expander = DatesExpander()

  func last(_ unit: PeriodUnit,
            from period: DayMonthYearPeriod) -> [DayMonthYearPeriod] {
    return last(1, unit, from: period)
  }

  func last(_ count: Int,
            _ unit: PeriodUnit,
            from period: DayMonthYearPeriod) -> [DayMonthYearPeriod] {
    return (1...count)
      .reduce([DayMonthYearPeriod]()) { result, _ in
        let sampleDate = manipulator.previousDay(
          result.first?.start ?? period.end
        )
        
        return [expand(sampleDate, by: unit)] + result
      }
      .filter { $0.end > period.start }
  }
  
  private func expand(_ date: DayMonthYear,
                      by unit: PeriodUnit) -> DayMonthYearPeriod {
    switch unit {
    case .day: return expander.singleDay(date)
    case .week: return expander.week(date)
    case .month: return expander.month(date)
    case .year: return expander.year(date)
    }
  }
}
