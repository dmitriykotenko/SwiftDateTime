//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


public struct MonthYear: Codable, Equatable, Hashable {
  
  public var month: Int
  public var year: Int
  
  public init(month: Int, year: Int) {
    self.month = month
    self.year = year
  }
  
  public func copy(month: Int? = nil,
                   year: Int? = nil) -> MonthYear {
    
    return MonthYear(
      month: month ?? self.month,
      year: year ?? self.year
    )
  }
}


extension MonthYear: Comparable {
  
  public static func < (this: MonthYear, that: MonthYear) -> Bool {
    if this.year != that.year {
      return this.year < that.year
    }
    
    return this.month < that.month
  }
}
