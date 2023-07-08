//  Copyright © 2020 Evgeniy Lubaev. All rights reserved.

import Foundation


public extension Duration {
  
  var toTimeInterval: TimeInterval {
    TimeInterval(milliseconds) / 1000
  }
}
