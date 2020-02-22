//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import XCTest
@testable import SwiftDateTime


class ClockTests: XCTestCase {
  
  let clock = Clock()
  
  func testThatNowDoesNotCrash() {
    let _ = clock.now
  }
  
  func testThatTodayDoesNotCrash() {
    let _ = clock.today
  }
  
  func testThatYesterdayIsLessThanToday() {
    let yesterday = clock.yesterday
    let today = clock.today
    
    XCTAssert(
      yesterday < today,
      "clock.yesterday (\(yesterday)) is greater than (or equal to) clock.today (\(today))."
    )
  }
}
