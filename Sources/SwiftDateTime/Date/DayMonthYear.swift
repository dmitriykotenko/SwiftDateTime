//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


public struct DayMonthYear: Codable, Equatable, Hashable {
  
  public var day: Int
  public var month: Int
  public var year: Int
    
  public init(day: Int, month: Int, year: Int) {
    self.day = day
    self.month = month
    self.year = year
  }
  
  public func copy(day: Int? = nil,
                   month: Int? = nil,
                   year: Int? = nil) -> DayMonthYear {    
    DayMonthYear(
      day: day ?? self.day,
      month: month ?? self.month,
      year: year ?? self.year
    )
  }
  
  public var monthYear: MonthYear {
    MonthYear(month: month, year: year)
  }
  
  public static let distantPast = DayMonthYear(day: 1, month: 1, year: -5000)
  public static let distantFuture = DayMonthYear(day: 1, month: 1, year: 5000)
}


extension DayMonthYear: Comparable {
  
  public static func < (this: DayMonthYear, that: DayMonthYear) -> Bool {
    if this.year != that.year {
      return this.year < that.year
    }
    
    if this.month != that.month {
      return this.month < that.month
    }
    
    return this.day < that.day
  }
}
