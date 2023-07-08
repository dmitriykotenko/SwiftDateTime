//  Copyright © 2020 Evgeniy Lubaev. All rights reserved.


public extension Int {
  
  var hours: Duration {
    Duration(negative: signum() < 0, hours: abs(self))
  }

  var minutes: Duration {
    Duration(negative: signum() < 0, minutes: abs(self))
  }

  var seconds: Duration {
    Duration(negative: signum() < 0, seconds: abs(self))
  }
  
  var thousandths: Duration {
    Duration(negative: signum() < 0, thousandths: abs(self))
  }
  
  var milliseconds: Duration {
    Duration(milliseconds: self)
  }
}


public extension Int64 {
  
  var milliseconds: Duration {
    Duration(milliseconds: self)
  }
}
