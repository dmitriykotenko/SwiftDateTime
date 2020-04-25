//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


public struct CalendarDuration: Codable, Equatable, Hashable {
  
  static let zero = CalendarDuration(days: 0)
  
  var days: Int
  
  var signum: Int {
    return Int(days.signum())
  }
  
  init(days: Int) {
    self.days = days
  }
}


extension CalendarDuration: Comparable {
  
  public static func < (this: CalendarDuration, that: CalendarDuration) -> Bool {
    return this.days < that.days
  }
}
