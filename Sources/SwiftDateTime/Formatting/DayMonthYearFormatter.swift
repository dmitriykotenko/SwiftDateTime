//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


import Foundation


public class DayMonthYearFormatter {
  
  public init() {}
  
  /// Formats DayMonthYear as string in format "dd.MM.yyyy".
  ///
  /// E. g.: April 30, 2019 is formatted as "30.04.2019"; December 1, 2019 is formatted as "01.12.2019".
  public func dotBasedStringFromDayMonthYear(_ dayMonthYear: DayMonthYear) -> String {
    let year = String(format: "%04d", dayMonthYear.year)
    let month = String(format: "%02d", dayMonthYear.month)
    let day = String(format: "%02d", dayMonthYear.day)
    
    return "\(day).\(month).\(year)"
  }

  /// Formats DayMonthYear as string in format "yyyy-MM-dd".
  ///
  /// E. g.: April 30, 2019 is formatted as "2019-04-30"; December 1, 2019 is formatted as "2019-12-01".
  public func canonicalStringFromDayMonthYear(_ dayMonthYear: DayMonthYear) -> String {
    let year = String(format: "%04d", dayMonthYear.year)
    let month = String(format: "%02d", dayMonthYear.month)
    let day = String(format: "%02d", dayMonthYear.day)
    
    return "\(year)-\(month)-\(day)"
  }
  
  /// Parses string in format "dd.MM.yyyy" to DayMonthYear.
  ///
  /// E. g. "30.04.2019" → April 30, "01.12.2019" → December 1, 2019.
  public func dotBasedDayMonthYearFromString(_ string: String) -> ParseResult<DayMonthYear> {
    let firstMinus = string.prefix { $0 == "-" }
    let withoutMinus = string.drop { $0 == "-" }
    guard firstMinus.count <= 1 else { return .failure(.invalidDayMonthYear(string)) }

    let yearSign = firstMinus.isEmpty ? 1 : -1
    let splittedString = withoutMinus.components(separatedBy: ".")
    
    guard splittedString.count == 3 else { return .failure(.invalidDayMonthYear(string)) }

    return dayMonthYear(
      string: string,
      yearSign: yearSign,
      dayComponent: splittedString[0],
      monthComponent: splittedString[1],
      yearComponent: splittedString[2]
    )
  }

  /// Parses string in format "yyyy-MM-dd" to DayMonthYear.
  ///
  /// E. g. "2019-04-30" → April 30, "2019-12-01" → December 1, 2019.
  public func canonicalDayMonthYearFromString(_ string: String) -> ParseResult<DayMonthYear> {
    let firstMinus = string.prefix { $0 == "-" }
    let withoutMinus = string.drop { $0 == "-" }
    guard firstMinus.count <= 1 else { return .failure(.invalidDayMonthYear(string)) }

    let yearSign = firstMinus.isEmpty ? 1 : -1
    let splittedString = withoutMinus.components(separatedBy: "-")
    
    guard splittedString.count == 3 else { return .failure(.invalidDayMonthYear(string)) }

    return dayMonthYear(
      string: string,
      yearSign: yearSign,
      dayComponent: splittedString[2],
      monthComponent: splittedString[1],
      yearComponent: splittedString[0]
    )
  }
  
  private func dayMonthYear(string: String,
                            yearSign: Int,
                            dayComponent: String,
                            monthComponent: String,
                            yearComponent: String) -> ParseResult<DayMonthYear> {
    guard
      yearComponent.count >= 4,
      monthComponent.count == 2,
      dayComponent.count == 2
      else { return .failure(.invalidDayMonthYear(string)) }

    let year = yearComponent.asNonNegativeInteger
    let month = monthComponent.asNonNegativeInteger
    let day = dayComponent.asNonNegativeInteger
    
    return year
      .flatMap { unsignedYear in
        let year = unsignedYear * yearSign
        
        return month.flatMap { month in
          day.flatMap { day in
            if isValid(day: day, month: month, year: year) {
              return .success(
                DayMonthYear(
                  day: day,
                  month: month,
                  year: year
                )
              )
            } else {
              return .failure(.invalidDayMonthYear(string))
            }
          }
        }
    }
  }
  
  private func isValid(day: Int, month: Int, year: Int) -> Bool {
    switch (month, day) {
    case (1...12, 1...monthLength(month: month, year: year)):
      return true
    default:
      return false
    }
  }
  
  private func monthLength(month: Int, year: Int) -> Int {
    switch month {
    case 1, 3, 5, 7, 8, 10, 12: return 31
    case 4, 6, 9, 11: return 30
    default:
      return
        (year % 400 == 0) ? 29 :
        (year % 100 == 0) ? 28 :
        (year % 4 == 0) ? 29 :
        28
    }
  }
}


private extension String {
  
  var asNonNegativeInteger: ParseResult<Int> {
    if allSatisfy({ isDecimalDigit($0) }), let number = Int(self) {
      return .success(number)
    } else {
      return .failure(.invalidNonNegativeInteger(self))
    }
  }
  
  private func isDecimalDigit(_ character: Character) -> Bool {
    let digits = CharacterSet.decimalDigits
    
    return character.unicodeScalars.allSatisfy { digits.contains($0) }
  }
}
