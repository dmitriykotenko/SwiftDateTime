//  Copyright © 2020 Evgeniy Lubaev. All rights reserved.


public extension Duration {
  
  static func random(in range: ClosedRange<Duration>) -> Duration {
    let millisecondsRange = range.lowerBound.milliseconds...range.upperBound.milliseconds
    
    return Duration(milliseconds: .random(in: millisecondsRange))
  }
}
