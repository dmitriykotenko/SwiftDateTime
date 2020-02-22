//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import XCTest
@testable import SwiftDateTime


/// Tests for formatting of durations.
class DurationFormatterTests: XCTestCase {
  
  let formatter = DurationFormatter()
  let maximumStringLength = 7

  func testExactFormattingOfZero() {
    check(
      duration: .zero,
      expectedExactFormatting: "00:00"
    )
  }

  func testExactFormattingSeconds1() {
    check(
      duration: Duration(hours: 0, minutes: 0, seconds: 1, thousandths: 999),
      expectedExactFormatting: "00:01"
    )
  }

  func testExactFormattingMinutesAndSeconds1() {
    check(
      duration: Duration(hours: 0, minutes: 2, seconds: 1, thousandths: 900),
      expectedExactFormatting: "02:01"
    )
  }

  func testExactFormattingMinutesAndSeconds2() {
    check(
      duration: Duration(hours: 0, minutes: 50, seconds: 0, thousandths: 907),
      expectedExactFormatting: "50:00"
    )
  }

  func testExactFormattingMinutesAndSeconds3() {
    check(
      duration: Duration(hours: 0, minutes: 50, seconds: 22, thousandths: 065),
      expectedExactFormatting: "50:22"
    )
  }

  func testExactFormattingHoursMinutesAndSeconds1() {
    check(
      duration: Duration(hours: 4, minutes: 33, seconds: 22, thousandths: 111),
      expectedExactFormatting: "4:33:22"
    )
  }

  func testExactFormattingHoursMinutesAndSeconds2() {
    check(
      duration: Duration(hours: 404, minutes: 3, seconds: 2, thousandths: 1),
      expectedExactFormatting: "404:03:02"
    )
  }

  func testExactFormattingHoursMinutesAndSeconds3() {
    check(
      duration: Duration(hours: 404, minutes: 3, seconds: 0, thousandths: 0),
      expectedExactFormatting: "404:03:00"
    )
  }

  func testExactFormattingHoursMinutesAndSeconds4() {
    check(
      duration: Duration(hours: 404, minutes: 0, seconds: 0, thousandths: 0),
      expectedExactFormatting: "404:00:00"
    )
  }

  private func check(duration: Duration, expectedExactFormatting expectedFormatting: String) {
    let actualFormatting = formatter.formatExactly(duration)
    
    XCTAssertEqual(actualFormatting, expectedFormatting)
  }

  func testThatApproximatelyFormattedDurationIsNoLongerThan6symbols() {
    for _ in 1...10000 {
      let duration = randomDuration()
      let string = formatter.formatApproximately(duration)
      
      if string.count > maximumStringLength {
        XCTFail("Duration \(duration) is formatted to very long string: \"\(string)\".")
        break
      }
    }
  }
  
  private func randomDuration() -> Duration {
    return Duration(milliseconds: Int.random(in: 0...3000000000))
  }
}
