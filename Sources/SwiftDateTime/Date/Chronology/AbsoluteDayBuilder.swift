//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


class AbsoluteDayBuilder: Chronology {

  func absoluteDay(_ dayMonthYear: DayMonthYear) -> Int {
    let monther = DayOfYearConverter(year: dayMonthYear.year)
    
    let dayOfYear = monther.dayOfYear(
      day: dayMonthYear.day,
      month: dayMonthYear.month
    )
    
    return daysSinceReferenceYear(dayMonthYear.year) + dayOfYear
  }

  /// Number of days between start of referenceYear and start of given year.
  ///
  /// If given year is less than referenceYear, returns negative number of days.
  private func daysSinceReferenceYear(_ year: Int) -> Int {
    (year - referenceYear) * 365 + leapFactor(year)
  }

  /// Number of leap years between referenceYear and given year.
  private func leapFactor(_ year: Int) -> Int {
    let epochs = epochsToBeatReferenceYear(year: year)
    let greaterYear = addEpochs(epochs, to: year)    
    let finalCorrection = -epochs * leapYearsPerEpoch
    
    assert(greaterYear >= referenceYear)
    
    let years = greaterYear - referenceYear
    let julianLeapYears = years / 4

    let centuries = century(greaterYear) - century(referenceYear)
    let leapCenturies = centuries / 4
    let antiLeapYears = centuries - leapCenturies
    
    return julianLeapYears - antiLeapYears + finalCorrection
  }
  
  private func century(_ year: Int) -> Int {
    ((year - 1) / 100) + 1
  }
  
  private func epochsToBeatReferenceYear(year: Int) -> Int {
    let differenceInEpochs = Double(referenceYear - year) / Double(yearsPerEpoch)
    let epochsToAdd = max(differenceInEpochs, 0)
    
    return Int(epochsToAdd.rounded(.up))
  }
  
  private func addEpochs(_ epochs: Int, to year: Int) -> Int {
    year + epochs * yearsPerEpoch
  }
}
