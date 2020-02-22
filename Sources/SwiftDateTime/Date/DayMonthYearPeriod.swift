//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


public struct DayMonthYearPeriod: Codable, Equatable, Hashable {
  
  let start: DayMonthYear
  let end: DayMonthYear
  
  func contains(_ dayMonthYear: DayMonthYear) -> Bool {
    return dayMonthYear >= start && dayMonthYear < end
  }
  
  func contains(_ localDateTime: LocalDateTime) -> Bool {
    return contains(localDateTime.date)
  }

  func contains(_ dateTime: DateTime) -> Bool {
    return contains(dateTime.local)
  }
  
  var days: [DayMonthYear] {
    return Array(DayMonthYearsSequence(self))
  }
}


private class DayMonthYearsSequence: Sequence, IteratorProtocol {

  typealias Element = DayMonthYear

  private let period: DayMonthYearPeriod
  private lazy var manipulator = DatesManipulator()
  private lazy var currentDay: DayMonthYear = manipulator.previousDay(period.start)
  
  init(_ period: DayMonthYearPeriod) {
    self.period = period
  }
  
  func next() -> DayMonthYearsSequence.Element? {
    currentDay = manipulator.nextDay(currentDay)
    
    return currentDay < period.end ? currentDay : nil
  }
}
