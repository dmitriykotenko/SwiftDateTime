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
    
    let millisecondsPerDay: Int64 = 24 * 3600 * 1000
    
    let millisecondsFromMidnight = duration.milliseconds.positiveRemainder(modulo: millisecondsPerDay)
    let daysCorrection = duration.milliseconds.divideWithoutRemainder(millisecondsPerDay)
    
    return (
      daysCorrection: Int(daysCorrection),
      time: HoursMinutesSeconds(
        durationFromMidnight: Duration(milliseconds: millisecondsFromMidnight)
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


private extension Int64 {
  
  func positiveRemainder(modulo divider: Int64) -> Int64 {
    return self - (divideWithoutRemainder(divider) * divider)
  }
  
  func divideWithoutRemainder(_ divider: Int64) -> Int64 {
    if self >= 0 { return self / divider }
    
    let absQuotient = abs(self) / divider
    let absRemainder = abs(self) % divider
    
    return absRemainder == 0 ? -absQuotient : -absQuotient - 1
  }
}
