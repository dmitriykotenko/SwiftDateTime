//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


public struct DayMonthYearPeriod: Codable, Equatable, Hashable {
  
  public let start: DayMonthYear
  public let end: DayMonthYear

  public init(start: DayMonthYear, end: DayMonthYear) {
    self.start = start
    self.end = end
  }
  
  public func contains(_ dayMonthYear: DayMonthYear) -> Bool {
    dayMonthYear >= start && dayMonthYear < end
  }
  
  public func contains(_ localDateTime: LocalDateTime) -> Bool {
    contains(localDateTime.date)
  }

  public func contains(_ dateTime: DateTime) -> Bool {
    contains(dateTime.local)
  }
  
  public var days: [DayMonthYear] {
    Array(DayMonthYearsSequence(self))
  }
  
  public var duration: CalendarDuration {
    DatesManipulator().duration(from: start, to: end)
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
