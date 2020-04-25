//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import Foundation


public class DateTimeFormatter {
  
  private let dateFormatter = DayMonthYearFormatter()
  private let timeFormatter = HoursMinutesSecondsFormatter()
  private let timeZoneOffsetFormatter = TimeZoneOffsetFormatter()

  public var nestedFormatter: DateFormatter?
  
  public init(_ nestedFormatter: DateFormatter? = nil) {
    self.nestedFormatter = nestedFormatter
  }

  public func stringFromDateTime(_ dateTime: DateTime) -> String {
    
    let dateString = dateFormatter.canonicalStringFromDayMonthYear(dateTime.date)
    let timeString = timeFormatter.stringFromTime(dateTime.time)
    let timeZoneString = timeZoneOffsetFormatter.stringFromTimeZoneOffset(dateTime.timeZoneOffset)
    
    return "\(dateString) \(timeString) \(timeZoneString)"
  }
  
  public func dateTime(string: String) -> ParseResult<DateTime> {
    switch nestedFormatter {
    case nil:
      return canonicalDateTimeFromString(string)
    default:
      return customizableDateTimeFromString(string)
    }
  }

  public func canonicalDateTimeFromString(_ string: String) -> ParseResult<DateTime> {
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

  public func customizableDateTimeFromString(_ string: String) -> ParseResult<DateTime> {
    let moment = nestedFormatter?.date(from: string)
    let timeZoneOffset = timeZoneOffsetFormatter.timeZoneOffsetFromDateString(string)
    let timeZone = timeZoneOffset.map { TimeZone(secondsFromGMT: $0.seconds) }
    
    switch (moment, timeZone) {
    case (let date?, .success(let zone?)):
      return .success(DateTime(moment: date, timeZone: zone))
    default:
      return .failure(.invalidDateTime(string))
    }
  }
}

