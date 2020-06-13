//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import Foundation


public extension LocalDateTime {

  /// - attention: If duration is not divider of Duration.day, the operation is not idempotent.
  func rounded(to duration: Duration) -> LocalDateTime {
    return copy(unsafeTime: time.unsafelyRounded(to: duration))
  }

  /// - attention: If duration is not divider of Duration.day, the operation is not idempotent.
  func rounded(upTo duration: Duration) -> LocalDateTime {
    return copy(unsafeTime: time.unsafelyRounded(upTo: duration))
  }

  func rounded(downTo duration: Duration) -> LocalDateTime {
    return copy(
      time: time.rounded(downTo: duration)
    )
  }

  private func copy(unsafeTime: HoursMinutesSeconds) -> LocalDateTime {
    let daysDifference = unsafeTime.durationFromMidnight.divided(by: .day)
    
    return copy(
      date: date + CalendarDuration(days: daysDifference),
      time: unsafeTime - (.day * daysDifference)
    )
  }
}
