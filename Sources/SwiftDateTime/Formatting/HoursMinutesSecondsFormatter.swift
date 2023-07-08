//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import Foundation


public class HoursMinutesSecondsFormatter {
  
  private let expectedStringLength = 12 // "23:07:52.483"
  
  public init() {}

  public func stringFromTime(_ time: HoursMinutesSeconds) -> String {
    let hours = String(format: "%02d", time.hours)
    let minutes = String(format: "%02d", time.minutes)
    let seconds = String(format: "%02d", time.seconds)
    let milliseconds = String(format: "%03d", time.milliseconds)
    
    return "\(hours):\(minutes):\(seconds).\(milliseconds)"
  }
  
  public func timeFromString(_ string: String) -> ParseResult<HoursMinutesSeconds> {
    guard string.count == expectedStringLength else { return .failure(.invalidHoursMinutesSeconds(string)) }

    let hoursMinutesSeconds = string.components(separatedBy: ":")
    
    guard hoursMinutesSeconds.count == 3 else { return .failure(.invalidHoursMinutesSeconds(string)) }

    let secondsMilliseconds = hoursMinutesSeconds[2].components(separatedBy: ".")
    
    guard secondsMilliseconds.count == 2 else { return .failure(.invalidHoursMinutesSeconds(string)) }

    guard
      let hours = Int(hoursMinutesSeconds[0]),
      let minutes = Int(hoursMinutesSeconds[1]),
      let seconds = Int(secondsMilliseconds[0]),
      let milliseconds = Int(secondsMilliseconds[1]),
      isValid(hours: hours, minutes: minutes, seconds: seconds, milliseconds: milliseconds)
      else {
        return .failure(.invalidHoursMinutesSeconds(string))
      }
    
    return .success(
      HoursMinutesSeconds(
        hours: hours,
        minutes: minutes,
        seconds: seconds,
        milliseconds: milliseconds
      )
    )
  }
  
  private func isValid(hours: Int,
                       minutes: Int,
                       seconds: Int,
                       milliseconds: Int) -> Bool {
    
    switch (hours, minutes, seconds, milliseconds) {
    case (0...23, 0...59, 0...59, 0...999):
      return true
    default:
      return false
    }
  }
}

