//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import XCTest
@testable import SwiftDateTime


protocol DurationGenerator {
  
  func randomDuration(seconds: Int?,
                      thousandths: Int?) -> Duration
}


extension DurationGenerator {
  
  func randomDuration(seconds: Int? = nil,
                      thousandths: Int? = nil) -> Duration {
    let secondsPerDay = 86400
    let fewYears = 10 * 365 * secondsPerDay
    
    return Duration(
      seconds: seconds ?? Int.random(in: 0...fewYears),
      thousandths: thousandths ?? Int.random(in: 0..<1000)
    )
  }
}
