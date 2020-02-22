//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


struct DayMonthYear: Codable, Equatable, Hashable {
  
  var day: Int
  var month: Int
  var year: Int
  
  func copy(day: Int? = nil,
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
  
  static func < (this: DayMonthYear, that: DayMonthYear) -> Bool {
    if this.year != that.year {
      return this.year < that.year
    }
    
    if this.month != that.month {
      return this.month < that.month
    }
    
    return this.day < that.day
  }
}
