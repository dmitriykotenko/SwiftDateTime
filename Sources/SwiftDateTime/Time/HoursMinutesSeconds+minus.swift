//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import Foundation


extension HoursMinutesSeconds {
  
  /// Subtracts one time from another.
  /// Returns result as number of seconds between given times.
  static func - (this: HoursMinutesSeconds, that: HoursMinutesSeconds) -> Duration {
    let seconds = (this.hours - that.hours) * 3600 + (this.minutes - that.minutes) * 60 + (this.seconds - that.seconds)
    
    let milliseconds = this.milliseconds - that.milliseconds
    
    return Duration(milliseconds: seconds * 1000 + milliseconds)
  }
}
