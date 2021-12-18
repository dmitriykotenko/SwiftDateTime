//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import Foundation


public extension DateTime {
  
  init(moment: Date,
       timeZone: TimeZone = .utc) {
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = timeZone
    
    let timeZoneOffsetSeconds = calendar.timeZone.secondsFromGMT(for: moment)
    
    let nowComponents = calendar.dateComponents(
      [.day, .month, .year, .hour, .minute, .second, .nanosecond],
      from: moment
    )
    
    guard
      let day = nowComponents.day,
      let month = nowComponents.month,
      let year = nowComponents.year,
      let hours = nowComponents.hour,
      let minutes = nowComponents.minute,
      let seconds = nowComponents.second,
      let nanoseconds = nowComponents.nanosecond
      else { fatalError("Can not parse date components.") }

    let milliseconds = nanoseconds.rounded(to: 1_000_000) / 1_000_000

    self.init(
      date: DayMonthYear(day: day, month: month, year: year),
      time: HoursMinutesSeconds(hours: hours, minutes: minutes, seconds: seconds, milliseconds: milliseconds),
      timeZoneOffset: Duration(seconds: timeZoneOffsetSeconds)
    )
  }
}


private extension Int {

  func rounded(to interval: Int) -> Int {
    let remainder = positiveRemainder(modulo: interval)

    return
    (remainder * 2 < interval) ?
    (self - remainder) :
    (self + interval - remainder)
  }

  private func positiveRemainder(modulo divider: Int) -> Int {
    self - (divideWithoutRemainder(divider) * divider)
  }

  private func divideWithoutRemainder(_ divider: Int) -> Int {
    if self >= 0 { return self / divider }

    let absQuotient = abs(self) / divider
    let absRemainder = abs(self) % divider

    return absRemainder == 0 ? -absQuotient : -absQuotient - 1
  }
}
