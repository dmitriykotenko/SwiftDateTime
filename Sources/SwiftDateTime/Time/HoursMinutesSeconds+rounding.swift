//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import Foundation


public extension HoursMinutesSeconds {
  
  func rounded(to duration: Duration) -> HoursMinutesSeconds {
    HoursMinutesSeconds(
      durationFromMidnight: unsafelyRounded(to: duration)
        .durationFromMidnight
        .positiveRemainder(divider: .day)
    )
  }

  func rounded(upTo duration: Duration) -> HoursMinutesSeconds {
    HoursMinutesSeconds(
      durationFromMidnight: unsafelyRounded(upTo: duration)
        .durationFromMidnight
        .positiveRemainder(divider: .day)
    )
  }

  func rounded(downTo duration: Duration) -> HoursMinutesSeconds {
    HoursMinutesSeconds(
      durationFromMidnight: unsafelyRounded(downTo: duration)
        .durationFromMidnight
        .positiveRemainder(divider: .day)
    )
  }
}


extension HoursMinutesSeconds {
  
  func unsafelyRounded(to duration: Duration) -> HoursMinutesSeconds {
    HoursMinutesSeconds(
      durationFromMidnight: durationFromMidnight.rounded(to: duration)
    )
  }
  
  func unsafelyRounded(upTo duration: Duration) -> HoursMinutesSeconds {
    HoursMinutesSeconds(
      durationFromMidnight: durationFromMidnight.rounded(upTo: duration)
    )
  }
  
  func unsafelyRounded(downTo duration: Duration) -> HoursMinutesSeconds {
    HoursMinutesSeconds(
      durationFromMidnight: durationFromMidnight.rounded(downTo: duration)
    )
  }
}
