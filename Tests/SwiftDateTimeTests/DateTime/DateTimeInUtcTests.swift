//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import XCTest
@testable import SwiftDateTime


class DateTimeInUtcTests: XCTestCase {
  
  func testPositiveTimeZoneOffset() {
    let a = 8.august(2009).time(01, 20, 53, 098).zone(hours: +5)
    
    let expected = 7.august(2009).time(20, 20, 53, 098).utc()
    let actual = a.inUtc()
    
    XCTAssert(
      actual == expected,
      "a.inUtc() is \(actual), but \(expected) expected"
    )
  }
  
  func testNegativeTimeZoneOffset1() {
    let a = 7.august(2009).time(18, 19, 20, 0).zone(hours: -3)
    
    let expected = 7.august(2009).time(21, 19, 20, 0).utc()
    let actual = a.inUtc()
    
    XCTAssert(
      actual == expected,
      "a.inUtc() is \(actual), but \(expected) expected"
    )
  }
  
  func testNegativeTimeZoneOffset2() {
    let a = 7.august(2009).time(18, 19, 20, 0).zone(hours: -17)
    
    let expected = 8.august(2009).time(11, 19, 20, 0).utc()
    let actual = a.inUtc()
    
    XCTAssert(
      actual == expected,
      "a.inUtc() is \(actual), but \(expected) expected"
    )
  }
}
