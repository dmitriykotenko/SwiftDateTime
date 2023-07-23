//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import XCTest
@testable import SwiftDateTime


class DateTimesManipulatorTimeZoneChangingTests: XCTestCase, DateTimeGenerator, DurationGenerator {
  
  let manipulator = DateTimesManipulator()
  
  func testAdditionOfFewHours() {
    check(
      dateTime: 5.february(2019).time(11, 25, 53, 11).utc(),
      convertedToTimeZoneOffset: Duration(hours: 3),
      is: 5.february(2019).time(14, 25, 53, 11).zone(Duration(hours: 3))
    )
  }
  
  func testSubtractingOfFewHours() {
    check(
      dateTime: 31.december(2018).time(6, 05, 48, 318).zone(Duration(hours: 3)),
      convertedToTimeZoneOffset: Duration(hours: -4),
      is: 30.december(2018).time(23, 05, 48, 318).zone(Duration(hours: -4))
    )
  }

  func testMomentInvariability() {
    for _ in 1...10000 {
      let dateTime = randomDateTime()
      let timeZoneOffset = randomTimeZoneOffset()

      let newDateTime = manipulator.dateTime(
        dateTime,
        convertedToTimeZoneOffset: timeZoneOffset
      )

      if newDateTime.moment != dateTime.moment {
        XCTFail(
          "Moment invariability violated: " +
          "\(dateTime).moment = \(dateTime.moment) != \(newDateTime.moment) = \(newDateTime).moment."
        )
        return
      }
    }
  }

  func testSymmetry() {
    for _ in 1...10000 {
      let dateTime = randomDateTime()
      let timeZoneOffset = randomTimeZoneOffset()

      let sameDateTime = manipulator.dateTime(
        manipulator.dateTime(dateTime, convertedToTimeZoneOffset: timeZoneOffset),
        convertedToTimeZoneOffset: dateTime.timeZoneOffset
      )
      
      if sameDateTime != dateTime {
        XCTFail(
          "Symmetry violated: " +
          "(\(dateTime) with time zone offset changed to \(timeZoneOffset) (and back again) = \(sameDateTime)."
        )
        return
      }
    }
  }

  func testFinalTimeZone() {
    for _ in 1...10000 {
      let dateTime = randomDateTime()
      let timeZoneOffset = randomTimeZoneOffset()

      let newDateTime = manipulator.dateTime(
        dateTime,
        convertedToTimeZoneOffset: timeZoneOffset
      )

      if newDateTime.timeZoneOffset != timeZoneOffset {
        XCTFail("Time zone offset is wrong. Expected: \(timeZoneOffset). Actual: \(newDateTime.timeZoneOffset).")
        return
      }
    }
  }

  private func check(dateTime: DateTime,
                     convertedToTimeZoneOffset timeZoneOffset: Duration,
                     is expectedDateTime: DateTime) {
    let actualDateTime = manipulator.dateTime(
      dateTime,
      convertedToTimeZoneOffset: timeZoneOffset
    )
    
    XCTAssertEqual(
      actualDateTime,
      expectedDateTime,
      "Incorrect changing of time zone \(timeZoneOffset) for \(dateTime).\n" +
      "Expected result: \(expectedDateTime).\n" +
      "Actual result: \(actualDateTime)."
    )
  }
}
