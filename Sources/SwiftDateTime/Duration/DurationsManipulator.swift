//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


extension Duration {
  
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
