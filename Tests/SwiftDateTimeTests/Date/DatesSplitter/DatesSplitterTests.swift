//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import XCTest
@testable import SwiftDateTime


/// Tests for splitting DayMonthYearPeriod into chunks of different size.
class DatesSplitterTests: XCTestCase, DateTimeGenerator {
  
  let splitter = DatesSplitter()
  let manipulator = DatesManipulator()
  
  func testSingleDay() {
    for _ in 1...10000 {
      let randomDate = randomDayMonthYear()
    
      let success = checkThatLast(
        1,
        .day,
        from: randomDate,
        is: [
          DayMonthYearPeriod(
            start: randomDate,
            end:  manipulator.nextDay(randomDate)
          )
        ]
      )
      
      if success == false { return }
    }
  }
  
  func testNumberOfLastDays() {
    for _ in 1...100 {
      let expectedNumberOfDays = Int.random(in: 1...1000)
      
      let start = randomDayMonthYear()
      let end = manipulator.date(start, plusDays: expectedNumberOfDays)
      let period = DayMonthYearPeriod(start: start, end: end)
      
      let daysBetween = splitter.last(
        expectedNumberOfDays + 50,
        .day,
        from: period
      )
      
      if daysBetween.count != expectedNumberOfDays {
        XCTFail(
          "Number of last days from \(period) expected to be \(expectedNumberOfDays), " +
          "but actually it is \(daysBetween.count)."
        )
        
        return
      }
    }
  }

  func testWeekOf31december2000() {
    checkThatLast(
      1,
      .week,
      from: 31.december(2000),
      is: [
        DayMonthYearPeriod(
          start: 25.december(2000),
          end: 1.january(2001)
        )
      ]
    )
  }

  func testWeekOf30december2000() {
    checkThatLast(
      1,
      .week,
      from: 30.december(2000),
      is: [
        DayMonthYearPeriod(
          start: 25.december(2000),
          end: 1.january(2001)
        )
      ]
    )
  }

  func testMonthOf29february1992() {
    checkThatLast(
      1,
      .month,
      from: 29.february(1992),
      is: [
        DayMonthYearPeriod(
          start: 1.february(1992),
          end: 1.march(1992)
        )
      ]
    )
  }
  
  func testYearOf17december2009() {
    checkThatLast(
      1,
      .year,
      from: 17.december(2009),
      is: [
        DayMonthYearPeriod(
          start: 1.january(2009),
          end: 1.january(2010)
        )
      ]
    )
  }
  
  func testTenWeeksOfDecember2009() {
    checkThatLast(
      10,
      .week,
      from: DayMonthYearPeriod(
        start: 1.december(2009),
        end: 1.january(2010)
      ),
      is: [
        DayMonthYearPeriod(
          start: 30.november(2009),
          end: 7.december(2009)
        ),
        DayMonthYearPeriod(
          start: 7.december(2009),
          end: 14.december(2009)
        ),
        DayMonthYearPeriod(
          start: 14.december(2009),
          end: 21.december(2009)
        ),
        DayMonthYearPeriod(
          start: 21.december(2009),
          end: 28.december(2009)
        ),
        DayMonthYearPeriod(
          start: 28.december(2009),
          end: 4.january(2010)
        )
      ]
    )
  }
  
  func testTwoWeeksOfDecember2009() {
    checkThatLast(
      2,
      .week,
      from: DayMonthYearPeriod(
        start: 1.december(2009),
        end: 1.january(2010)
      ),
      is: [
        DayMonthYearPeriod(
          start: 21.december(2009),
          end: 28.december(2009)
        ),
        DayMonthYearPeriod(
          start: 28.december(2009),
          end: 4.january(2010)
        )
      ]
    )
  }
  
  func testMonthsOfLastWeekOf2011() {
    checkThatLast(
      10,
      .month,
      from: DayMonthYearPeriod(
        start: 26.december(2011),
        end: 2.january(2012)
      ),
      is: [
        DayMonthYearPeriod(
          start: 1.december(2011),
          end: 1.january(2012)
        ),
        DayMonthYearPeriod(
          start: 1.january(2012),
          end: 1.february(2012)
        )
      ]
    )
  }
  
  func testFewDaysOfMay2023() {
    checkThatLast(
      5, .day,
      from: DayMonthYearPeriod(
        start: 17.may(2023),
        end: 27.may(2023)
      ),
      is: [
        DayMonthYearPeriod(
          start: 22.may(2023),
          end: 23.may(2023)
        ),
        DayMonthYearPeriod(
          start: 23.may(2023),
          end: 24.may(2023)
        ),
        DayMonthYearPeriod(
          start: 24.may(2023),
          end: 25.may(2023)
        ),
        DayMonthYearPeriod(
          start: 25.may(2023),
          end: 26.may(2023)
        ),
        DayMonthYearPeriod(
          start: 26.may(2023),
          end: 27.may(2023)
        )
      ]
    )
  }

  @discardableResult
  private func checkThatLast(_ count: Int,
                         _ unit: PeriodUnit,
                         from singleDate: DayMonthYear,
                         is expectedResult: [DayMonthYearPeriod]) -> Bool {
    return checkThatLast(
      count,
      unit,
      from: DayMonthYearPeriod(
        start: singleDate,
        end: DatesManipulator().nextDay(singleDate)
      ),
      is: expectedResult
    )
  }

  @discardableResult
  private func checkThatLast(_ count: Int,
                             _ unit: PeriodUnit,
                             from period: DayMonthYearPeriod,
                             is expectedResult: [DayMonthYearPeriod]) -> Bool {
    
    let actualResult = splitter.last(count, unit, from: period)
    
    if actualResult != expectedResult {
      XCTFail(
        ".last(\(count), \(unit), from \(period)) should be:\n" +
        "\(expectedResult)\n\n" +
        "But actually it is:\n" +
        "\(actualResult)."
      )
      
      return false
    }
    
    return true
  }
}
