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

  public func timeZoneOffsetFromDateString(_ dateString: String) -> ParseResult<Duration> {
    return
      timeZoneComponent(dateString: dateString)
      .map { timeZoneOffsetFromString($0) }
      ?? .success(.zero)
  }
  
  private func timeZoneComponent(dateString: String) -> String? {
    let timeZoneIndex = dateString.lastIndex(of: "Z")
      ?? dateString.lastIndex(of: "z")
      ?? dateString.lastIndex(of: "+")
      ?? dateString.lastIndex(of: "-")
    
    return timeZoneIndex.map { String(dateString.suffix(from: $0)) }
  }

  public func timeZoneOffsetFromString(_ string: String) -> ParseResult<Duration> {
    guard string.first?.lowercased() != "z" else { return .success(.zero) }
    
    guard string.count == expectedStringLength else { return .failure(.invalidTimeZoneOffset(string)) }
    
    guard
      let sign = string.first,
      sign == "+" || sign == "-"
    else {
        return .failure(.invalidTimeZoneOffset(string))
    }
    
    let isNegative = (sign != "+")
    
    let hoursMinutes = String(string.dropFirst()).components(separatedBy: ":")
    
    guard
      hoursMinutes.count == 2,
      let absoluteHours = Int(hoursMinutes[0]),
      let minutes = Int(hoursMinutes[1]),
      isValid(hours: absoluteHours, minutes: minutes)
    else {
        return .failure(.invalidTimeZoneOffset(string))
    }
    
    let absoluteSeconds = absoluteHours * 3600 + minutes * 60
    
    return .success(
      Duration(
        negative: isNegative,
        seconds: absoluteSeconds
      )
    )
  }
  
  private func isValid(hours: Int,
                       minutes: Int) -> Bool {
    switch (hours, minutes) {
    case (0...23, 0...59): return true
    default: return false
    }
  }
}

