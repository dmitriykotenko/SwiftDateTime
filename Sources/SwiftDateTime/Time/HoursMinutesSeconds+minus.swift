//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import Foundation


extension HoursMinutesSeconds {
  
  /// Subtracts one time from another.
  /// Returns result as number of seconds between given times.
  public static func - (this: HoursMinutesSeconds, that: HoursMinutesSeconds) -> Duration {
    this.durationFromMidnight - that.durationFromMidnight
  }
}
