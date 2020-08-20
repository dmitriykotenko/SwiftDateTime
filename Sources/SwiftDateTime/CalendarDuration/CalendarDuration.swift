//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


public struct CalendarDuration: Codable, Equatable, Hashable {
  
  public static let zero = CalendarDuration(days: 0)
  
  public var days: Int
  
  public var signum: Int {
    return Int(days.signum())
  }
  
  public init(days: Int) {
    self.days = days
  }
}


extension CalendarDuration: Comparable {
  
  public static func < (this: CalendarDuration, that: CalendarDuration) -> Bool {
    return this.days < that.days
  }
}
