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
    
    return DayMonthYear(
      day: day ?? self.day,
      month: month ?? self.month,
      year: year ?? self.year
    )
  }
  
  public var monthYear: MonthYear {
    return MonthYear(month: month, year: year)
  }
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
