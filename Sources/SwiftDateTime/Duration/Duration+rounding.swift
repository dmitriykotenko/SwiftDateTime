//  Copyright © 2020 Evgeniy Lubaev. All rights reserved.


public extension Duration {
  
  func rounded(to interval: Duration) -> Duration {
    let remainder = positiveRemainder(divider: interval)

    return
      (remainder * 2 < interval) ?
        (self - remainder) :
        (self + interval - remainder)
  }
  
  func rounded(upTo interval: Duration) -> Duration {
    let remainder = positiveRemainder(divider: interval)
    
    return (remainder == .zero) ? self : (self - remainder) + interval
  }

  func rounded(downTo interval: Duration) -> Duration {
    return self - positiveRemainder(divider: interval)
  }
}
