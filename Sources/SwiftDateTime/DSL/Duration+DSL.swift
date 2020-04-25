//  Copyright © 2020 Evgeniy Lubaev. All rights reserved.


public extension Int {
  
  var hours: Duration {
    return Duration(negative: signum() < 0, hours: abs(self))
  }

  var minutes: Duration {
    return Duration(negative: signum() < 0, minutes: abs(self))
  }

  var seconds: Duration {
    return Duration(negative: signum() < 0, seconds: abs(self))
  }
  
  var thousandths: Duration {
    return Duration(negative: signum() < 0, thousandths: abs(self))
  }
}
