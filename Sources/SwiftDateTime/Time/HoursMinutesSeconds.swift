//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


public struct HoursMinutesSeconds: Codable, Equatable, Hashable {

  public var hours: Int
  public var minutes: Int
  public var seconds: Int
  public var milliseconds: Int
  
  public init(hours: Int, minutes: Int, seconds: Int, milliseconds: Int = 0) {
    self.hours = hours
    self.minutes = minutes
    self.seconds = seconds
    self.milliseconds = milliseconds
  }
  
  public init(secondsFromMidnight: Int, milliseconds: Int = 0) {
    hours = secondsFromMidnight / 3600
    minutes = (secondsFromMidnight / 60) - hours * 60
    seconds = secondsFromMidnight % 60
    self.milliseconds = milliseconds
  }
    
  public init(durationFromMidnight: Duration) {
    self.init(
        secondsFromMidnight: durationFromMidnight.seconds,
        milliseconds: durationFromMidnight.thousandths
    )
  }
    
  public var durationFromMidnight: Duration {
    return Duration(
      milliseconds: (hours * 3600 + minutes * 60 + seconds) * 1000 + milliseconds
    )
  }
  
  public static let zero = HoursMinutesSeconds(hours: 0, minutes: 0, seconds: 0)
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
