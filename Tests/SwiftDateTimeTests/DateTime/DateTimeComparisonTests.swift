//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import XCTest
@testable import SwiftDateTime


class DateTimeComparisonTests: XCTestCase {
  
  func testThatAbsoluteMomentIsMostImportant() {
    let a = 8.august(2009).time(01, 20, 53, 098).zone(hours: +5)
    let b = 7.august(2009).time(18, 19, 20, 0).zone(hours: -3)
    
    XCTAssert(
      a < b,
      "\(a) is greater than or equal to \(b)"
    )
  }
  
  func testThatAbsoluteMomentIsMoreImportantThanTime() {
    let a = 7.august(2009).time(19, 19, 33, 098).zone(hours: -2)
    let b = 7.august(2009).time(18, 20, 20, 0).zone(hours: -3)
    
    XCTAssert(
      a < b,
      "\(a) is greater than or equal to \(b)"
    )
  }
  
  func testThatLocalDateTimeMatters() {
    let timeZoneOffset = Duration(hours: -7)
    
    let a = DateTime(
      localDateTime: 29.february(2008).time(14, 00, 01, 777),
      timeZoneOffset: timeZoneOffset
    )
    
    let b = DateTime(
      localDateTime: 1.march(2008).time(03, 45, 00, 011),
      timeZoneOffset: timeZoneOffset
    )
    
    XCTAssert(
      a < b,
      "\(a) is greater than or equal to \(b)"
    )
  }
  
  func testThatTimeZoneOffsetMatters() {
    let local = 7.august(2009).time(8, 35, 00, 248)
    let a = local.zone(hours: +1)
    let b = local.zone(hours: -1)
    
    XCTAssert(
      a < b,
      "\(a) is greater than or equal to \(b)"
    )
  }
  
  func testThatTimeZoneOffsetMattersForEqualMoments() {
    let a = 7.august(2009).time(8, 35, 00, 248).zone(hours: -10)
    let b = 7.august(2009).time(14, 35, 00, 248).zone(hours: -4)
    
    XCTAssert(
      a < b,
      "\(a) is greater than or equal to \(b)"
    )
  }
}
