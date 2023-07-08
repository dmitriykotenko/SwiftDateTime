//  Copyright © 2020 Evgeniy Lubaev. All rights reserved.

import Foundation


public extension Duration {
    
  var toDispatchTimeInterval: DispatchTimeInterval {
    .milliseconds(Int(milliseconds))
  }
}
