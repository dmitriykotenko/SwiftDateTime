//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.

import Foundation


public protocol Clock {
  
  var now: DateTime { get }
}
