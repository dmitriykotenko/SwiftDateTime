//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import Foundation


public extension DateTime {
   
  /// - attention: If duration is not divider of Duration.day, the operation is not idempotent.
  func rounded(to duration: Duration) -> DateTime {
    copy(localDateTime: local.rounded(to: duration))
  }
  
  /// - attention: If duration is not divider of Duration.day, the operation is not idempotent.
  func rounded(upTo duration: Duration) -> DateTime {
    copy(localDateTime: local.rounded(upTo: duration))
  }
  
  func rounded(downTo duration: Duration) -> DateTime {
    copy(localDateTime: local.rounded(downTo: duration))
  }
}
