//  Copyright © 2020 Evgeniy Lubaev. All rights reserved.


public extension HoursMinutesSeconds {

  static func + (time: HoursMinutesSeconds, duration: Duration) -> HoursMinutesSeconds {
    let totalDuration = time.durationFromMidnight + duration
    
    let clippedDuration = totalDuration.positiveRemainder(divider: .day)
    
    return HoursMinutesSeconds(
      durationFromMidnight: clippedDuration
    )
  }

  static func - (time: HoursMinutesSeconds, duration: Duration) -> HoursMinutesSeconds {
    time + (-duration)
  }
}
