//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


public struct DayMonthYear: Codable, Equatable, Hashable {
  
  public var day: Int
  public var month: Int
  public var year: Int
  
  public func copy(day: Int? = nil,
                   month: Int? = nil,
                   year: Int? = nil) -> DayMonthYear {
    
    return DayMonthYear(
      day: day ?? self.day,
      month: month ?? self.month,
      year: year ?? self.year
    )
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
