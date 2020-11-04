//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import XCTest
@testable import SwiftDateTime


class DateTimesManipulatorLocalManipulationsTests: XCTestCase, DateTimeGenerator, DurationGenerator {
  
  let manipulator = DateTimesManipulator()
  
  func testAdditionOfFewMinutes() {
    check(
      dateTime: 5.february(2019).time(11, 25, 53, 11),
      plus: Duration(hours: 0, minutes: 7, seconds: 16, thousandths: 872),
      is: 5.february(2019).time(11, 33, 09, 883)
    )
  }
  
  func testAdditionOfFewDays() {
    check(
      dateTime: 31.december(2018).time(16, 05, 48, 318),
      plus: Duration(hours: 105, minutes: 14, seconds: 10, thousandths: 781),
      is: 5.january(2019).time(01, 19, 59, 099)
    )
  }
  
  func testSubtractionOfTwoWeeks() {
    let aboutTwoWeeks = Duration(
      seconds: 86400 * 14 + 3600 * 20 + 60 * 45 + 35,
      thousandths: 078
    )
    
    check(
      dateTime: 14.march(2008).time(14, 00, 35, 077),
      minus: aboutTwoWeeks,
      is: 28.february(2008).time(17, 14, 59, 999)
    )
  }
  
  func testSymmetry1() {
    for _ in 1...10000 {
      let dateTime = randomLocalDateTime()
      let duration = randomDuration()
      
      let sameDateTime = manipulator.localDateTime(
        manipulator.localDateTime(dateTime, plus: duration),
        minus: duration
      )
      
      if sameDateTime != dateTime {
        XCTFail("Symmetry violated: (\(dateTime) + \(duration)) - \(duration) = \(sameDateTime).")
        return
      }
    }
  }
  
  func testSymmetry2() {
    for _ in 1...10000 {
      let dateTime = randomLocalDateTime()
      let duration = randomDuration()
      
      let sameDateTime = manipulator.localDateTime(
        manipulator.localDateTime(dateTime, minus: duration),
        plus: duration
      )
      
      if sameDateTime != dateTime {
        XCTFail("Symmetry violated: (\(dateTime) - \(duration)) + \(duration) = \(sameDateTime).")
        return
      }
    }
  }
  
  func testAssociativity1() {
    for _ in 1...10000 {
      let dateTime = randomLocalDateTime()
      let durationA = randomDuration()
      let durationB = randomDuration()
      
      let a = manipulator.localDateTime(
        manipulator.localDateTime(dateTime, plus: durationA),
        plus: durationB
      )
      
      let b = manipulator.localDateTime(dateTime, plus: durationA + durationB)
      
      if a != b {
        XCTFail(
          "Associativity violated:\n" +
          "(\(dateTime) + \(durationA)) + \(durationB) = \(a),\n" +
          "but \(dateTime) + (\(durationA) + \(durationB)) = \(b)"
        )
        return
      }
    }
  }
  
  func testAssociativity2() {
    for _ in 1...10000 {
      let dateTime = randomLocalDateTime()
      let durationA = randomDuration()
      let durationB = randomDuration()
      
      let a = manipulator.localDateTime(
        manipulator.localDateTime(dateTime, minus: durationA),
        minus: durationB
      )
      
      let b = manipulator.localDateTime(dateTime, minus: durationA + durationB)
      
      if a != b {
        XCTFail(
          "Associativity violated:\n" +
          "(\(dateTime) - \(durationA)) - \(durationB) = \(a),\n" + 
          "but \(dateTime) - (\(durationA) + \(durationB)) = \(b)"
        )
        return
      }
    }
  }

  private func check(dateTime: LocalDateTime,
                     plus duration: Duration,
                     is expectedDateTime: LocalDateTime) {
    let actualDateTime = manipulator.localDateTime(dateTime, plus: duration)
    
    XCTAssertEqual(
      actualDateTime,
      expectedDateTime,
      "Incorrect addition of \(duration) to \(dateTime).\n" +
      "Expected result: \(expectedDateTime).\n" +
      "Actual result: \(actualDateTime)."
    )
  }
  
  private func check(dateTime: LocalDateTime,
                     minus duration: Duration,
                     is expectedDateTime: LocalDateTime) {
    let actualDateTime = manipulator.localDateTime(dateTime, minus: duration)
    
    XCTAssertEqual(
      actualDateTime,
      expectedDateTime,
      "Incorrect subtraction of \(duration) from \(dateTime).\n" +
      "Expected result: \(expectedDateTime).\n" +
      "Actual result: \(actualDateTime)."
    )
  }
}
