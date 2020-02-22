//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import Foundation


class DateTimeFormatter {
  
  private let dateFormatter = DayMonthYearFormatter()
  private let timeFormatter = HoursMinutesSecondsFormatter()
  private let timeZoneOffsetFormatter = TimeZoneOffsetFormatter()
  
  func stringFromDateTime(_ dateTime: DateTime) -> String {
    
    let dateString = dateFormatter.stringFromDayMonthYear(dateTime.date)
    let timeString = timeFormatter.stringFromTime(dateTime.time)
    let timeZoneString = timeZoneOffsetFormatter.stringFromTimeZoneOffset(dateTime.timeZoneOffset)
    
    return "\(dateString) \(timeString) \(timeZoneString)"
  }
  
  func dateTimeFromString(_ string: String) -> ParseResult<DateTime> {
    let dateAndTimeAndZone = string.components(separatedBy: " ")
    
    guard dateAndTimeAndZone.count == 3 else { return .failure(.invalidDateTime(string)) }
    
    let dateString = dateAndTimeAndZone[0]
    let timeString = dateAndTimeAndZone[1]
    let timeZoneOffsetString = dateAndTimeAndZone[2]
    
    let date = dateFormatter.dayMonthYearFromString(dateString)
    let time = timeFormatter.timeFromString(timeString)
    let timeZoneOffset = timeZoneOffsetFormatter.timeZoneOffsetFromString(timeZoneOffsetString)
    
    let result =
      date.flatMap { d in
      time.flatMap { t in
      timeZoneOffset.flatMap { o in
        .success(DateTime(date: d, time: t, timeZoneOffset: o))
      }}}
    
    return result
  }
}

