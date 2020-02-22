//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


class Chronology {
  
  // Absolute day 1 is January 1, 2001.
  private(set) lazy var referenceDate = DayMonthYear(day: 1, month: 1, year: 2001)
  private(set) lazy var referenceYear = referenceDate.year

  private(set) lazy var yearsPerEpoch = 400
  private(set) lazy var centuriesPerEpoch = yearsPerEpoch / 100
  private(set) lazy var antiLeapCenturies = centuriesPerEpoch * 3 / 4
  private(set) lazy var leapYearsPerEpoch = (yearsPerEpoch / 4) - antiLeapCenturies
  private(set) lazy var daysPerEpoch = 365 * yearsPerEpoch + leapYearsPerEpoch

  private(set) lazy var leapYearsPerNonLeapCentury = 24
  private(set) lazy var daysPerNonLeapCentury = 365 * 100 + leapYearsPerNonLeapCentury
  
  private(set) lazy var daysPerLeapCycle = 365 * 3 + 366
}
