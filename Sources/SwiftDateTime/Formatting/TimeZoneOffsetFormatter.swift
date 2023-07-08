//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import Foundation


public class TimeZoneOffsetFormatter {

  private let expectedStringLength = 6 // "+03:00"
  
  public init() {}

  public func stringFromTimeZoneOffset(_ offset: Duration) -> String {
    let positive = offset.milliseconds >= 0
    
    let sign = positive ? "+" : "-"
    
    let hours = offset.seconds / 3600
    let minutes = hours * 60 - offset.seconds / 60
    
    let hoursString = String(format: "%02d", hours)
    let minutesString = String(format: "%02d", minutes)
    
    return "\(sign)\(hoursString):\(minutesString)"
  }

  public func timeZoneOffsetFromDateString(_ dateString: String,
                                           dateFormat: String) -> ParseResult<Duration> {
    timeZoneComponent(dateString: dateString, dateFormat: dateFormat)
      .map { timeZoneOffsetFromString($0) }
      ?? .success(.zero)
  }
  
  private func timeZoneComponent(dateString: String,
                                 dateFormat: String) -> String? {
    /// Do not try to parse time zone if it is not mentioned in the format.
    guard dateFormat.isTimeZoneMentioned else { return nil }

    let timeZoneIndex = dateString.lastIndex(of: "Z")
      ?? dateString.lastIndex(of: "z")
      ?? dateString.lastIndex(of: "+")
      ?? dateString.lastIndex(of: "-")
    
    return timeZoneIndex.map { String(dateString.suffix(from: $0)) }
  }

  public func timeZoneOffsetFromString(_ string: String) -> ParseResult<Duration> {
    guard string.first?.lowercased() != "z" else { return .success(.zero) }

    return
      isNevative(string).flatMap { isNegative in
        hoursMinutes(from: string).map { hoursMinutesSeconds in
          Duration(
            negative: isNegative,
            seconds: hoursMinutesSeconds.hours * 3600 + hoursMinutesSeconds.minutes * 60
          )
        }
      }
  }

  private func isNevative(_ string: String) -> ParseResult<Bool> {
    switch string.first {
    case "+":
      return .success(false)
    case "-":
      return .success(true)
    default:
      return .failure(.invalidTimeZoneOffset(string))
    }
  }

  private func hoursMinutes(from string: String) -> ParseResult<HoursMinutesSeconds> {
    components(from: string).flatMap {
      let maybeHours = ($0.first).flatMap { Int($0) }
      let maybeMinutes = ($0.dropFirst().first).flatMap { Int($0) }

      switch ($0.count, maybeHours, maybeMinutes) {
      case (2, let hours?, let minutes?) where isValid(hours: hours, minutes: minutes):
        return .success(
          HoursMinutesSeconds(
            hours: hours,
            minutes: minutes,
            seconds: 0
          )
        )
      default:
        return .failure(.invalidTimeZoneOffset(string))
      }
    }
  }

  private func components(from string: String) -> ParseResult<[String]> {
    let stringWithoutSign = String(string.dropFirst())

    switch string.count {
    case 5: // "+0300"
      return .success(
        Array(stringWithoutSign)
          .chunks(length: 2)
          .map { String($0) }
      )
    case 6: // "+03:00"
      return .success(
        Array(stringWithoutSign.components(separatedBy: ":"))
      )
    default:
      return .failure(.invalidTimeZoneOffset(string))
    }
  }

  private func isValid(hours: Int,
                       minutes: Int) -> Bool {
    switch (hours, minutes) {
    case (0...23, 0...59): return true
    default: return false
    }
  }
}


private extension String {

  /// Check if the date format mensions time zone.
  var isTimeZoneMentioned: Bool {
    // Possible time zone symbols
    // (according to https://unicode-org.github.io/icu/userguide/format_parse/datetime/#datetime-format-syntax)
    let timeZoneCharacters = CharacterSet(charactersIn: "zZOvVxX")

    return !CharacterSet(charactersIn: self).intersection(timeZoneCharacters).isEmpty
  }
}
