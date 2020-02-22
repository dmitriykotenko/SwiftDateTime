//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


public struct HoursMinutesSeconds: Codable, Equatable, Hashable {

  var hours: Int
  var minutes: Int
  var seconds: Int
  var milliseconds: Int
  
  init(hours: Int, minutes: Int, seconds: Int, milliseconds: Int = 0) {
    self.hours = hours
    self.minutes = minutes
    self.seconds = seconds
    self.milliseconds = milliseconds
  }
  
  init(secondsFromMidnight: Int, milliseconds: Int = 0) {
    hours = secondsFromMidnight / 3600
    minutes = (secondsFromMidnight / 60) - hours * 60
    seconds = secondsFromMidnight % 60
    self.milliseconds = milliseconds
  }
  
  static let zero = HoursMinutesSeconds(hours: 0, minutes: 0, seconds: 0)
}


extension HoursMinutesSeconds: Comparable {
  
  public static func < (this: HoursMinutesSeconds, that: HoursMinutesSeconds) -> Bool {
    if this.hours != that.hours {
      return this.hours < that.hours
    }
    
    if this.minutes != that.minutes {
      return this.minutes < that.minutes
    }
    
    if this.seconds != that.seconds {
      return this.seconds < that.seconds
    }
    
    return this.milliseconds < that.milliseconds
  }
}
