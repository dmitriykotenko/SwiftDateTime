//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import XCTest
@testable import SwiftDateTime


class DateTimeFormatterTests: XCTestCase & DateTimeGenerator {
  
  let formatter = DateTimeFormatter()
  
  func testSymmetryOfFormattingAndParsing() {
    for _ in 1...10000 {
      let dateTime = randomDateTime()
      let formattedAndThenParsed = formatAndThenParse(dateTime)
      
      switch formattedAndThenParsed {
      case .success(let actualDateTime) where actualDateTime == dateTime:
        break
      default:
        XCTFail(
          "Symmetry of date time formatting violated: " +
          "after formatting and parsing date time \(dateTime) became \(formattedAndThenParsed)"
        )
        return
      }
    }
  }
  
  func testThatOrderingOfDateAndTimeIsPreserved() {
    for _ in 1...10000 {
      let timeZoneOffset = randomTimeZoneOffset()
      
      let a = randomDateTime(timeZoneOffset: timeZoneOffset)
      let b = randomDateTime(timeZoneOffset: timeZoneOffset)
      
      guard a < b else { continue }
      
      let formattedA = formatter.string(dateTime: a)
      let formattedB = formatter.string(dateTime: b)
      
      guard formattedA < formattedB else {
        XCTFail(
          "Date time formatting does not preserve ordering of date and time:\n" +
          "a = \(a), b = \(b)\n" +
          "formattedA = \(formattedA), formattedB = \(formattedB)\n" +
          "a < b, but formattedA >= formattedB"
        )
        return
      }
    }
  }
  
  func testThatOrderingOfTimeZoneOffsetIsPreserved() {
    for _ in 1...10000 {
      let date = randomDayMonthYear()
      let time = randomHoursMinutesSeconds()
      let a = randomDateTime(date: date, time: time)
      let b = randomDateTime(date: date, time: time)
      
      guard a < b else { continue }
      
      switch (formatAndThenParse(a), formatAndThenParse(b)) {
      case (.success(let parsedA), .success(let parsedB)) where parsedA < parsedB:
        continue
      case (let parsedA, let parsedB):
        XCTFail(
          "Date time formatting does not preserve ordering of time zone offset:\n" +
          "a = \(a), b = \(b)\n" +
          "parsedA = \(parsedA), parsedB = \(parsedB)\n" +
          "a < b, but parsedA is not less than parsedB."
        )
        return
      }
    }
  }
  
  func testFormatOfSingleDateTime() {
    checkThat(
      DateTime(
        date: DayMonthYear(day: 7, month: 8, year: 2009),
        time: HoursMinutesSeconds(hours: 18, minutes: 19, seconds: 20),
        timeZoneOffset: Duration(hours: 3)
      ),
      formattedAs: "2009-08-07 18:19:20.000 +03:00"
    )
  }
  
  func testFormatOfNegativeTimeZoneOffset() {
    checkThat(
      DateTime(
        date: DayMonthYear(day: 7, month: 8, year: 2009),
        time: HoursMinutesSeconds(hours: 18, minutes: 19, seconds: 20),
        timeZoneOffset: Duration(negative: true, hours: 7)
      ),
      formattedAs: "2009-08-07 18:19:20.000 -07:00"
    )
  }
  
  func testFormatOfMilliseconds() {
    checkThat(
      DateTime(
        date: DayMonthYear(day: 7, month: 8, year: 2009),
        time: HoursMinutesSeconds(hours: 18, minutes: 19, seconds: 20, milliseconds: 37),
        timeZoneOffset: Duration(negative: true, hours: 7)
      ),
      formattedAs: "2009-08-07 18:19:20.037 -07:00"
    )
  }
  
  func testParsingOfSingleDateTimeString() {
    checkThat(
      "1960-02-20 23:59:04.008 +01:00",
      parsedTo: DateTime(
        date: DayMonthYear(day: 20, month: 2, year: 1960),
        time: HoursMinutesSeconds(hours: 23, minutes: 59, seconds: 4, milliseconds: 8),
        timeZoneOffset: Duration(hours: 1)
      )
    )
  }
  
  func testParsingOf29februaryOfLeapYear() {
    checkThat(
      "2000-02-29 23:59:04.008 +01:00",
      parsedTo: DateTime(
        date: DayMonthYear(day: 29, month: 2, year: 2000),
        time: HoursMinutesSeconds(hours: 23, minutes: 59, seconds: 4, milliseconds: 8),
        timeZoneOffset: Duration(hours: 1)
      )
    )
  }
  
  func testParsingOfLargeYear() {
    checkThat(
      "890908-01-01 11:00:00.000 +03:00",
      parsedTo: 1.january(890908).time(11, 00).zone(hours: +3)
    )
  }
  
  func testParsingOfNegativeYear() {
    checkThat(
      "-890908-01-01 11:00:00.000 +03:00",
      parsedTo: 1.january(-890908).time(11, 00).zone(hours: +3)
    )
  }

  func testParsingOfPositiveTimeZoneWithoutColon() {
    checkThat(
      "-890908-01-01 11:00:00.000 +0300",
      parsedTo: 1.january(-890908).time(11, 00).zone(hours: +3)
    )
  }

  func testParsingOfNegativeTimeZoneWithoutColon() {
    checkThat(
      "-890908-01-01 11:00:00.000 -0500",
      parsedTo: 1.january(-890908).time(11, 00).zone(hours: -5)
    )
  }

  func testParsingOfEmptyString() {
    checkParsingOfInvalidString("")
  }
  
  func testParsingOfInvalidString() {
    checkParsingOfInvalidString("Four little Injuns up on a spree, One got fuddled and then there were three;")
  }
  
  func testParsingOfTwoDigitYear() {
    checkParsingOfInvalidString("98-7-26 04:42:10.003 +00:00")
  }
  
  func testParsingOfInvalidMonth() {
    checkParsingOfInvalidString("1998-17-26 04:42:10.003 +00:00")
  }
  
  func testParsingOfOneDigitMonth() {
    checkParsingOfInvalidString("1998-7-26 04:42:10.003 +00:00")
  }
  
  func testParsingOfInvalidDay() {
    checkParsingOfInvalidString("1998-10-32 04:42:10.003 +00:00")
  }
  
  func testParsingOfOneDigitDay() {
    checkParsingOfInvalidString("1998-7-2 04:42:10.003 +00:00")
  }
  
  func testParsingOf29februaryOfNonLeapYear() {
    checkParsingOfInvalidString("1998-02-29 04:42:10.003 +00:00")
  }
  
  func testParsingOfInvalidTime() {
    checkParsingOfInvalidString("1998-17-26 04:69:10.003 +00:00")
  }
  
  func testParsingOfOneDigitHour() {
    checkParsingOfInvalidString("1998-07-26 4:42:10.003 +00:00")
  }
  
  func testParsingOfOneDigitMinute() {
    checkParsingOfInvalidString("1998-07-26 04:4:10.003 +00:00")
  }
  
  func testParsingOfOneDigitSecond() {
    checkParsingOfInvalidString("1998-07-26 04:42:1.003 +00:00")
  }
  
  func testParsingOfOneDigitMilliseconds() {
    checkParsingOfInvalidString("1998-07-26 04:42:10.3 +00:00")
  }
  
  func testParsingOfSenselessTimeZoneOffset() {
    checkParsingOfInvalidString("1998-17-26 04:69:10.003 +ad:bc")
  }
  
  func testParsingOfTimeZoneOffsetWithSeconds() {
    checkParsingOfInvalidString("1998-17-26 04:69:10.003 +05:00:00")
  }

  func testParsingOfTimeZoneWithOneDigitHours() {
    checkParsingOfInvalidString("1998-07-26 04:42:10.3 +0:00")
  }
  
  func testParsingOfTimeZoneOffsetWithoutSign() {
    checkParsingOfInvalidString("1998-07-26 04:42:10.3 01:00")
  }
  
  func testParsingOfTimeZoneOffsetWithOneDigitMinutes() {
    checkParsingOfInvalidString("1998-07-26 04:42:10.3 +00:3")
  }
  
  func testNestedDateFormatter() {
    let nestedDateFormatter = DateFormatter()
    nestedDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXX"
    
    let formatter = DateTimeFormatter(nestedDateFormatter)
    
    let string = "2015-05-25T09:59:04+06:00"
    let expectedDateTime = 25.may(2015).time(9, 59, 4).zone(6.hours)

    switch formatter.dateTime(string: string) {
    case .failure(let error):
      XCTFail("Error when parsing valid date time string \"\(string)\": \(error.localizedDescription)")
    case .success(let actualDateTime) where actualDateTime != expectedDateTime:
      XCTFail("\"\(string)\" was parsed as \(actualDateTime), but expected \(expectedDateTime)")
    case .success(let dateTime):
      let parsedThenFormattedString = formatter.string(dateTime: dateTime)
      
      if parsedThenFormattedString != string {
        XCTFail("\"\(string)\" when parsed and then formatted again become \(parsedThenFormattedString)")
      }
    }
  }

  func testInitWithFormat1() {
    check(
      dateFormat: "yyyy-MM-dd'T'HH:mm:ssXXX",
      dateTimeString: "2015-05-25T09:59:04+06:00",
      expectedDateTime: 25.may(2015).time(9, 59, 4).zone(6.hours)
    )
  }

  func testInitWithFormat2() {
    check(
      dateFormat: "dd.M.yyyy HH:mm:ss.SSSXXX",
      dateTimeString: "25.5.2015 09:59:04.321+06:00",
      expectedDateTime: 25.may(2015).time(9, 59, 4, 321).zone(6.hours)
    )
  }

  func testInitWithFormat3() {
    check(
      dateFormat: "HH:mm, d.M.yyyy, XXX",
      dateTimeString: "09:59, 1.5.2015, +06:00",
      expectedDateTime: 1.may(2015).time(9, 59).zone(6.hours)
    )
  }

  @discardableResult
  private func check(dateFormat: String,
                     dateTimeString: String,
                     expectedDateTime: DateTime) -> Bool {
    let formatter = DateTimeFormatter(dateFormat)

    switch formatter.dateTime(string: dateTimeString) {
    case .failure(let error):
      XCTFail("Error when parsing valid date time string \"\(dateTimeString)\": \(error.localizedDescription)")
      return false
    case .success(let actualDateTime) where actualDateTime != expectedDateTime:
      XCTFail(
        "\"\(dateTimeString)\" was parsed as \(actualDateTime), but expected \(expectedDateTime)"
      )
      return false
    case .success(let dateTime):
      let parsedThenFormattedString = formatter.string(dateTime: dateTime)

      if parsedThenFormattedString != dateTimeString {
        XCTFail(
          "\"\(dateTimeString)\" when parsed and then formatted again become \(parsedThenFormattedString)"
        )
        return false
      } else {
        return true
      }
    }
  }
}


private extension DateTimeFormatterTests {
  
  func formatAndThenParse(_ dateTime: DateTime) -> ParseResult<DateTime> {
    return formatter.dateTime(string: formatter.string(dateTime: dateTime))
  }
  
  func parseAndThenFormat(_ string: String) -> ParseResult<String> {
    return formatter.dateTime(string: string)
      .map { formatter.string(dateTime: $0) }
  }

  func checkThat(_ dateTime: DateTime,
                 formattedAs expectedResult: String) {
    XCTAssertEqual(
      formatter.string(dateTime: dateTime),
      expectedResult
    )
  }
  
  func checkThat(_ string: String,
                 parsedTo expectedDateTime: DateTime) {
    switch formatter.dateTime(string: string) {
    case .failure(let error):
      XCTFail("Error when parsing valid date time string \"\(string)\": \(error.localizedDescription)")
    case .success(let actualDateTime) where actualDateTime != expectedDateTime:
      XCTFail("\"\(string)\" was parsed as \(actualDateTime), but expected \(expectedDateTime)")
    default:
      break
    }
  }
  
  func checkParsingOfInvalidString(_ string: String) {
    switch formatter.dateTime(string: string) {
    case .failure:
      break
    case .success(let actualDateTime):
      XCTFail("When parsing invalid date time string \"\(string)\", the result is \(actualDateTime).")
    }
  }
}
