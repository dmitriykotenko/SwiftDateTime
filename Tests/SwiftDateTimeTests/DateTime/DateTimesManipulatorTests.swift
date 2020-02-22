//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import XCTest
@testable import SwiftDateTime


class DateTimesManipulatorTests: XCTestCase, DateTimeGenerator, DurationGenerator {
  
  let manipulator = DateTimesManipulator()
  
  func testAdditionOfFewMinutes() {
    check(
      dateTime: 5.february(2019).time(11, 25, 53, 11).utc(),
      plus: Duration(hours: 0, minutes: 7, seconds: 16, thousandths: 872),
      is: 5.february(2019).time(11, 33, 09, 883).utc()
    )
  }
  
  func testAdditionOfFewDays() {
    check(
      dateTime: 31.december(2018).time(16, 05, 48, 318).utc(),
      plus: Duration(hours: 105, minutes: 14, seconds: 10, thousandths: 781),
      is: 5.january(2019).time(01, 19, 59, 099).utc()
    )
  }
  
  func testSubtractionOfTwoWeeks() {
    let aboutTwoWeeks = Duration(
      seconds: 86400 * 14 + 3600 * 20 + 60 * 45 + 35,
      thousandths: 078
    )
    
    check(
      dateTime: 14.march(2008).time(14, 00, 35, 077).utc(),
      minus: aboutTwoWeeks,
      is: 28.february(2008).time(17, 14, 59, 999).utc()
    )
  }
  
  func testSymmetry1() {
    for _ in 1...10000 {
      let dateTime = randomDateTime()
      let duration = randomDuration()
      
      let sameDateTime = manipulator.dateTime(
        manipulator.dateTime(dateTime, plus: duration),
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
      let dateTime = randomDateTime()
      let duration = randomDuration()
      
      let sameDateTime = manipulator.dateTime(
        manipulator.dateTime(dateTime, minus: duration),
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
      let dateTime = randomDateTime()
      let durationA = randomDuration()
      let durationB = randomDuration()
      
      let a = manipulator.dateTime(
        manipulator.dateTime(dateTime, plus: durationA),
        plus: durationB
      )
      
      let b = manipulator.dateTime(dateTime, plus: durationA + durationB)
      
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
      let dateTime = randomDateTime()
      let durationA = randomDuration()
      let durationB = randomDuration()
      
      let a = manipulator.dateTime(
        manipulator.dateTime(dateTime, minus: durationA),
        minus: durationB
      )
      
      let b = manipulator.dateTime(dateTime, minus: durationA + durationB)
      
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

  private func check(dateTime: DateTime,
                     plus duration: Duration,
                     is expectedDateTime: DateTime) {
    let actualDateTime = manipulator.dateTime(dateTime, plus: duration)
    
    XCTAssertEqual(
      actualDateTime,
      expectedDateTime,
      "Incorrect addition of \(duration) to \(dateTime).\n" +
      "Expected result: \(expectedDateTime).\n" +
      "Actual result: \(actualDateTime)."
    )
  }
  
  private func check(dateTime: DateTime,
                     minus duration: Duration,
                     is expectedDateTime: DateTime) {
    let actualDateTime = manipulator.dateTime(dateTime, minus: duration)
    
    XCTAssertEqual(
      actualDateTime,
      expectedDateTime,
      "Incorrect subtraction of \(duration) from \(dateTime).\n" +
      "Expected result: \(expectedDateTime).\n" +
      "Actual result: \(actualDateTime)."
    )
  }
}
