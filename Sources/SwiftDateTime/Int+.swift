//  Copyright © 2020 Evgeniy Lubaev. All rights reserved.


extension Int {
  
  static var nanosecondsPerMillisecond: Int {
    return 1_000_000
  }
}


extension Int64 {
  
  static var millisecondsPerDay: Int64 {
    return 24 * 3600 * 1000
  }
  
  func positiveRemainder(modulo divider: Int64) -> Int64 {
    return self - (divideWithoutRemainder(divider) * divider)
  }
  
  func divideWithoutRemainder(_ divider: Int64) -> Int64 {
    if self >= 0 { return self / divider }
    
    let absQuotient = abs(self) / divider
    let absRemainder = abs(self) % divider
    
    return absRemainder == 0 ? -absQuotient : -absQuotient - 1
  }
}
