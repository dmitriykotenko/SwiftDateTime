//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


extension Duration {
  
  static func + (this: Duration, that: Duration) -> Duration {
    return Duration(milliseconds:
      this.milliseconds + that.milliseconds
    )
  }

  static func - (this: Duration, that: Duration) -> Duration {
    return Duration(milliseconds:
      this.milliseconds - that.milliseconds
    )
  }
  
  static prefix func - (duration: Duration) -> Duration {
    return Duration(milliseconds: -duration.milliseconds)
  }
}
