//  Copyright © 2020 Evgeniy Lubaev. All rights reserved.


public extension Duration {
  
  var roundedToSeconds: Duration {
    let remainder = milliseconds.positiveRemainder(modulo: 1000)
    
    let correction = (remainder < 500) ? -remainder : 1000 - remainder
        
    return Duration(
      milliseconds: milliseconds + correction
    )
  }
  
  var roundedUpToSeconds: Duration {
    let remainder = milliseconds.positiveRemainder(modulo: 1000)
    let correction = remainder == 0 ? 0 : 1000 - remainder
    
    return Duration(
      milliseconds: milliseconds + correction
    )
  }
}
