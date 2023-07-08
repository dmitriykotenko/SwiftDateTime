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

  public convenience init(_ dateFormat: String) {
    let nestedFormatter = DateFormatter()
    nestedFormatter.dateFormat = dateFormat

    // Formatter's time zone matters when parsing date-times without time zone. E. g.: "1998-07-26 04:42:10"
    nestedFormatter.timeZone = .utc

    self.init(nestedFormatter)
  }

  public func string(dateTime: DateTime) -> String {
    let dateFormatter = nestedFormatter
      .flatMap { $0.copy() as? DateFormatter }
    
    switch dateFormatter {
    case nil:
      return canonicalStringFromDateTime(dateTime)
    case let formatter?:
      formatter.timeZone = TimeZone(secondsFromGMT: dateTime.timeZoneOffset.seconds)
      
      return stringFromDateTime(dateTime, formatter: formatter)
    }
  }
  
  private func canonicalStringFromDateTime(_ dateTime: DateTime) -> String {
    
    let dateString = dateFormatter.canonicalStringFromDayMonthYear(dateTime.date)
    let timeString = timeFormatter.stringFromTime(dateTime.time)
    let timeZoneString = timeZoneOffsetFormatter.stringFromTimeZoneOffset(dateTime.timeZoneOffset)
    
    return "\(dateString) \(timeString) \(timeZoneString)"
  }
  
  private func stringFromDateTime(_ dateTime: DateTime,
                                  formatter: DateFormatter) -> String {
    formatter.string(from: dateTime.moment)
  }
  
  public func dateTime(string: String) -> ParseResult<DateTime> {
    switch nestedFormatter {
    case nil:
      return dateTimeFromCanonicalString(string)
    case let formatter?:
      return dateTimeFromString(string, formatter: formatter)
    }
  }
  
  private func dateTimeFromCanonicalString(_ string: String) -> ParseResult<DateTime> {
    let dateAndTimeAndZone = string.components(separatedBy: " ")
    
    guard dateAndTimeAndZone.count == 3 else { return .failure(.invalidDateTime(string)) }
    
    let dateString = dateAndTimeAndZone[0]
    let timeString = dateAndTimeAndZone[1]
    let timeZoneOffsetString = dateAndTimeAndZone[2]
    
    let date = dateFormatter.canonicalDayMonthYearFromString(dateString)
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
  
  private func dateTimeFromString(_ string: String,
                                  formatter: DateFormatter) -> ParseResult<DateTime> {
    let moment = formatter.date(from: string)

    let timeZoneOffset = timeZoneOffsetFormatter.timeZoneOffsetFromDateString(
      string,
      dateFormat: formatter.dateFormat
    )

    let timeZone = timeZoneOffset.map { TimeZone(secondsFromGMT: $0.seconds) }

    switch (moment, timeZone) {
    case (let date?, .success(let zone?)):
      return .success(DateTime(moment: date, timeZone: zone))
    default:
      return .failure(.invalidDateTime(string))
    }
  }
}

