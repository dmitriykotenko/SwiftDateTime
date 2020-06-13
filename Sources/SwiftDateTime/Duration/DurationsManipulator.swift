//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


public extension Duration {
  
  static prefix func - (duration: Duration) -> Duration {
    return Duration(milliseconds: -duration.milliseconds)
  }

  static func + (this: Duration, that: Duration) -> Duration {
    return Duration(milliseconds:
      this.milliseconds + that.milliseconds
    )
  }
  
  static func - (this: Duration, that: Duration) -> Duration {
    return this + (-that)
  }
  
  static func * (duration: Duration, multiplier: Int) -> Duration {
    return Duration(milliseconds: duration.milliseconds * Int64(multiplier))
  }
  
  static func / (duration: Duration, divider: Int) -> Duration {
    return Duration(milliseconds: duration.milliseconds / Int64(divider))
  }
  
  static func * (duration: Duration, multiplier: Double) -> Duration {
    let newMilliseconds = Int64(Double(duration.milliseconds) * multiplier)
    
    return Duration(milliseconds: newMilliseconds)
  }
  
  static func / (duration: Duration, multiplier: Double) -> Duration {
    let newMilliseconds = Int64(Double(duration.milliseconds) / multiplier)
    
    return Duration(milliseconds: newMilliseconds)
  }

  func divided(by that: Duration) -> Int {
    return Int(
      milliseconds.divideWithoutRemainder(that.milliseconds)
    )
  }
  
  func positiveRemainder(divider: Duration) -> Duration {
    return Duration(milliseconds:
      milliseconds.positiveRemainder(modulo: divider.milliseconds)
    )
  }
}


public func abs(_ duration: Duration) -> Duration {
  return Duration(milliseconds: abs(duration.milliseconds))
}
