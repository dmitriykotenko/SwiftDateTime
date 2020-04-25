//  Copyright © 2020 Evgeniy Lubaev. All rights reserved.


public extension Duration {
  
  var roundedToSeconds: Duration {
    if thousandths < 500 {
      return self - thousandths.thousandths
    } else {
      return self + (1000 - thousandths).thousandths
    }
  }
  
  var roundedUpToSeconds: Duration {
    return self + (1000 - thousandths).thousandths
  }
}
