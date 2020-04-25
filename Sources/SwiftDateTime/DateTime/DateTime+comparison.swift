//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import Foundation


extension DateTime: Comparable {
  
  public func inUtc() -> DateTime {
    let (daysCorrection, fixedTime) = toUtc(time: time, timeZoneOffset: timeZoneOffset)
    
    return DateTime(
      date: DatesManipulator().date(date, plusDays: daysCorrection),
      time: fixedTime,
      timeZoneOffset: .zero
    )
  }
  
  private func toUtc(time: HoursMinutesSeconds,
                     timeZoneOffset: Duration) -> (daysCorrection: Int, time: HoursMinutesSeconds) {
    let duration = time.durationFromMidnight - timeZoneOffset
    
    let millisecondsFromMidnight = duration.positiveRemainder(divider: .day)
    let daysCorrection = duration.divided(by: .day)
    
    return (
      daysCorrection: daysCorrection,
      time: HoursMinutesSeconds(
        durationFromMidnight: millisecondsFromMidnight
      )
    )
  }
  
  public static func < (this: DateTime, that: DateTime) -> Bool {
    // Translate both datetimes to same time zone.
    let thisInUtc = this.inUtc()
    let thatInUtc = that.inUtc()
    
    if thisInUtc.local != thatInUtc.local {
      return thisInUtc.local < thatInUtc.local
    }
    
    return this.timeZoneOffset < that.timeZoneOffset
  }
}
