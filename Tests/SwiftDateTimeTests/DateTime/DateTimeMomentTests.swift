//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import XCTest
@testable import SwiftDateTime


class DateTimeMomentTests: XCTestCase, DateTimeGenerator {

  func testNonUtcTimeZone() {
    for _ in 1...10000 {
      let localDateTime = LocalDateTime(date: .init(day: 1, month: 1, year: 1970), time: .midnight)
      let timeZoneOffset = randomTimeZoneOffset()

      let dateTime = DateTime(localDateTime: localDateTime, timeZoneOffset: timeZoneOffset)

      let secondsSince1970 = dateTime.moment.timeIntervalSince1970

      if Int(secondsSince1970 * 1000) != -Int(timeZoneOffset.milliseconds) {
        XCTFail("Wrong moment \(dateTime.moment) for \(dateTime).")
        return
      }
    }
  }

  func testDifferentTimeZones() {
    for _ in 1...10000 {
      let localDateTime = randomLocalDateTime()

      let timeZoneOffsetA = randomTimeZoneOffset()
      let timeZoneOffsetB = randomTimeZoneOffset()

      let dateTimeA = DateTime(localDateTime: localDateTime, timeZoneOffset: timeZoneOffsetA)
      let dateTimeB = DateTime(localDateTime: localDateTime, timeZoneOffset: timeZoneOffsetB)

      let momentA = dateTimeA.moment
      let momentB = dateTimeB.moment

      let momentDifference = momentA.timeIntervalSince1970 - momentB.timeIntervalSince1970
      let timeZoneOffsetDifference = timeZoneOffsetA - timeZoneOffsetB

      if Int(momentDifference * 1000) != -Int(timeZoneOffsetDifference.milliseconds) {
        XCTFail(
          "At least one of the moments is wrong:\n" +
          "dateTimeA = \(dateTimeA)\n" +
          "dateTimeB = \(dateTimeB)\n" +
          "momentA = \(momentA)\n" +
          "momentB = \(momentB)\n" +
          "moments difference: momentA - momentB = \(momentDifference)\n" +
          "time zone offset difference: \(timeZoneOffsetA) - \(timeZoneOffsetB) = \(timeZoneOffsetDifference)"
        )
        return
      }
    }
  }
}
