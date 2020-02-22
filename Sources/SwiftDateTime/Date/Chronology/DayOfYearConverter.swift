//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


class DayOfYearConverter {
  
  private let year: Int
  
  init(year: Int) {
    self.year = year
  }
  
  func dayAndMonth(dayOfYear: Int) -> (day: Int, month: Int) {
    let months = (1...12).reversed()
    
    let month = months.first { monthStart($0) < dayOfYear } ?? 1
    
    return (day: dayOfYear - monthStart(month), month: month )
  }
  
  func dayOfYear(day: Int, month: Int) -> Int {
    return monthStart(month) + day
  }
  
  private func monthStart(_ month: Int) -> Int {
    let previousMonths = (1..<month)
    
    return previousMonths.map ( monthLength ).reduce(0, +)
  }
  
  func yearLength() -> Int {
    return isLeapYear() ? 366 : 365
  }
  
  func monthLength(_ month: Int) -> Int {
    switch month {
    case 1, 3, 5, 7, 8, 10, 12: return 31
    case 4, 6, 9, 11: return 30
    default:
      return isLeapYear() ? 29 : 28
    }
  }
  
  func isLeapYear() -> Bool {
    return
        (year % 400 == 0) ? true :
        (year % 100 == 0) ? false :
        (year % 4 == 0) ? true :
        false
  }
}
