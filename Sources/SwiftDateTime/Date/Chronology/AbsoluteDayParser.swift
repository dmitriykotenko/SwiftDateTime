//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


class AbsoluteDayParser: Chronology {
  
  func dayMonthYear(absoluteDay: Int) -> DayMonthYear {
    
    // Absolute day 1 is January 1, 2001.
    let referenceYear = 2001
    let zeroBazedDay = absoluteDay - 1

    let (epochs, epochDay) = detachEpochs(absoluteDay: zeroBazedDay)
    let (centuries, centuryDay) = detachCenturies(epochDay: epochDay)
    let (leapCycles, leapCycleDay) = detachLeapCycles(centuryDay: centuryDay)
    let (years, dayOfYear) = detachYears(leapCycleDay: leapCycleDay)
    
    let year = referenceYear + epochs * yearsPerEpoch + centuries * 100 + leapCycles * 4 + years
    let dayAndMonth = DayOfYearConverter(year: year).dayAndMonth(dayOfYear: dayOfYear + 1)
    
    return DayMonthYear(
      day: dayAndMonth.day,
      month: dayAndMonth.month,
      year: year
    )
  }
  
  private func detachEpochs(absoluteDay: Int) -> PeriodAndDay {
    let (epochsCorrection, positiveDay) = makePositive(absoluteDay: absoluteDay)
    let (epochs, epochDay) = split(day: positiveDay, into: daysPerEpoch)
    
    return (period: epochs + epochsCorrection, day: epochDay)
  }
  
  private func makePositive(absoluteDay: Int) -> (epochs: Int, positiveDay: Int) {
    if absoluteDay >= 0 {
      return (epochs: 0, positiveDay: absoluteDay)
    } else {
      let amount = abs(absoluteDay) / daysPerEpoch
      let epochs = -(amount + 1)
      
      return (epochs: epochs, positiveDay: absoluteDay - epochs * daysPerEpoch)
    }
  }
  
  private func detachCenturies(epochDay: Int) -> PeriodAndDay {
    split(
      day: epochDay,
      into: daysPerNonLeapCentury,
      maximumPeriods: centuriesPerEpoch - 1
    )
  }
  
  private func detachLeapCycles(centuryDay: Int) -> PeriodAndDay {
    let leapCyclesPerNonLeapCentury = 24

    return split(
      day: centuryDay,
      into: daysPerLeapCycle,
      maximumPeriods: leapCyclesPerNonLeapCentury
    )
  }
  
  private func detachYears(leapCycleDay: Int) -> PeriodAndDay {
    split(day: leapCycleDay, into: 365, maximumPeriods: 3)
  }

  private func split(day: Int,
                     into daysPerPeriod: Int,
                     maximumPeriods: Int = Int.max) -> PeriodAndDay {
    let period = divide(day, by: daysPerPeriod, maximumValue: maximumPeriods)
    
    return (period: period, day: day - period * daysPerPeriod)
  }
  
  private typealias PeriodAndDay = (period: Int, day: Int)

  private func divide(_ a: Int, by b: Int, maximumValue: Int = Int.max) -> Int {
    min(a / b, maximumValue)
  }
}
