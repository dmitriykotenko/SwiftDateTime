//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import Foundation


extension DateTime: CustomStringConvertible {
  
  public var description: String {
    return "\(date), \(time)"
  }
}


extension DayMonthYear: CustomStringConvertible {
  
  public var description: String {
    return String(format: "%d.%02d.%04d", day, month, year)
  }
}


extension DayMonthYearPeriod: CustomStringConvertible {
  
  public var description: String {
    return start == end ? "\(start)" : "\(start) — \(end)"
  }
}


extension Duration: CustomStringConvertible {
  
  public var description: String {
    
    let hours = seconds / 3600
    let minutes = seconds / 60 - 60 * hours
    let secondsOfMinute = seconds % 60

    let signString = signum == -1 ? "−" : ""
    let hoursString = hours == 0 ? "" : String(format: "%d:", hours)
    let minutesString = String(format: "%02d:", minutes)
    let secondsString = String(format: "%02d", secondsOfMinute)
    let thousandthsString = thousandths == 0 ? "" : String(format: ".%03d", thousandths)
    
    return signString + hoursString + minutesString + secondsString + thousandthsString
  }
}


extension HoursMinutesSeconds: CustomStringConvertible {
  
  public var description: String {
    let millisecondsString = (milliseconds == 0) ? "" : String(format: ".%03d", milliseconds)
    
    return String(
      format: "%02d:%02d:%02d%@",
      hours, minutes, seconds, millisecondsString
    )
  }
}


extension LocalDateTime: CustomStringConvertible {
  
  public var description: String {
    return "\(date), \(time)"
  }
}
