//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import Foundation


public class DurationFormatter {

  public init() {}

  public func formatApproximately(_ duration: Duration) -> String {
    let sign = duration.seconds.signum()
    let absSeconds = abs(duration.seconds)
    
    let hours = absSeconds / 3600
    let minutes = absSeconds / 60 - 60 * hours
    let secondsOfMinute = absSeconds % 60    
    
    let components = DateComponents(hour: hours, minute: minutes, second: secondsOfMinute)
    
    let formatter = DateComponentsFormatter()
    
    switch (hours, minutes) {
    case (0, 0): formatter.allowedUnits = [.second]
    case (100..., _): formatter.allowedUnits = [.hour]
    default: formatter.allowedUnits = [.hour, .minute]
    }
    
    formatter.unitsStyle = .abbreviated
    formatter.zeroFormattingBehavior = .dropLeading
    
    let signString = formatSign(sign)
    
    return signString + (formatter.string(from: components) ?? "")
  }
  
  public func formatExactly(_ duration: Duration) -> String {
    let sign = duration.seconds.signum()
    let seconds = abs(duration.seconds)
    
    let hours = seconds / 3600
    let minutes = seconds / 60 - 60 * hours
    let secondsOfMinute = seconds % 60
    
    let signString = formatSign(sign)
    let hoursString = hours == 0 ? "" : String(format: "%d:", hours)
    let minutesString = String(format: "%02d:", minutes)
    let secondsString = String(format: "%02d", secondsOfMinute)
    
    return signString + hoursString + minutesString + secondsString
  }
  
  private func formatSign(_ sign: Int) -> String {
    sign == -1 ? "−" : ""
  }
}
